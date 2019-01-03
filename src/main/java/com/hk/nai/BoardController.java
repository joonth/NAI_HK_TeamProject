package com.hk.nai;





import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hk.nai.dtos.BoardDto;
import com.hk.nai.dtos.CommentDto1;
import com.hk.nai.dtos.CriteriaDto;
import com.hk.nai.dtos.LikeDto;
import com.hk.nai.dtos.MemberDto;
import com.hk.nai.dtos.PageMakerDto;
import com.hk.nai.services.BoardLikeService;
import com.hk.nai.services.IBoardLikeService;
import com.hk.nai.services.IBoardService;

@Controller
public class BoardController {
private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	@Autowired
	private IBoardService boardService; //객체생성안하고 스프링이 만들어서 넣어줄거임
/*	@Autowired
	private IBoardLikeService boardLikeService;*/
	
	//게시판 글 목록 조회  --> 기본은 최신순으로 10개씩 정렬
	@RequestMapping(value="/boardlist.do", method= RequestMethod.GET)
	public String boardList(@ModelAttribute("cri") CriteriaDto cri, HttpServletRequest request, Locale locale, Model model,String page,String pagelist) throws Exception {
				
		logger.info("글목록조회{}.", locale);

		//조회수를 증가시킨 글번호를 세션 초기화한다.
		request.getSession().removeAttribute("b_readcount");
		
		 //  커맨드 객체로 Criteria를 매개변수로 넣어줘, 넘어오는 page와 perPageNum정보를 받습니다.		 
        // 해당 cri 를 이용해서 service->dao->mapper.xml 순으로 접근하면서 DB처리를 해 cri 전달된
        // 현재 페이지 정보를 기준으로 BoardVO 객체를 담은 ArrayList가 반환될 것입니다.
		List<BoardDto> dto=null;

	     		 
        // 이제 view jsp 페이지에서 페이징 처리를 위해 사용할 PageMaker 객체를 생성하고
		PageMakerDto pageMaker = new PageMakerDto();
		pageMaker.setCri(cri);
		Integer totalNum = boardService.totalCount();
		pageMaker.setTotalCount(totalNum);
		
		
        // /views/board/listPage.jsp 에서 페이징 처리를 하기 위해 PageMaker 객체를 저장해 놓아야 할 것이고

		pagelist = request.getParameter("pagelist");
		
		request.getSession().setAttribute("pagelist", pagelist);
		model.addAttribute("pageMaker", pageMaker);
		
		//페이지 조회순,최신순,추천순으로 출력
		if(pagelist.equals("b_readcount")) { //조회순 b_readcount desc,b_seq desc
			dto=boardService.listCriteria1(page);
			model.addAttribute("list", dto);
			model.addAttribute("pagelist", "b_readcount");
			return "boardlist";
		}
		else if(pagelist.equals("b_regdate")) {//최신순 - b_seq desc
			dto = boardService.listCriteria(page);
			model.addAttribute("list", dto);
			model.addAttribute("pagelist", "b_regdate");
			return "boardlist";
		}else if(pagelist.equals("first")){
			dto = boardService.listCriteria(page);
			model.addAttribute("list", dto);
			model.addAttribute("pagelist", "first");
			return "boardlist";
		}else if(pagelist.equals("b_like")) {
			dto = boardService.listCriteria2(page);
			model.addAttribute("list", dto);
			model.addAttribute("pagelist", "b_like");
			return "boardlist";
		}
		return "boardlist";
	}

	//게시글 추가폼으로 이동
	@RequestMapping(value="/insertform.do" , method= RequestMethod.GET)
	public String insertform(Locale locale,Model model,String b_seq,BoardDto dto) {
		logger.info("글추가 폼이동{}.", locale);
		return "boardinsert";
	}
	
	//게시글 추가 처리
	@RequestMapping(value="/insertboard.do",method=RequestMethod.POST)
	public String insertBoard(Locale locale,Model model,String b_seq,BoardDto dto ) {
		logger.info("글 추가{}.", locale);
		boolean isS = boardService.insertBoard(dto);
		if(isS) {
			return "redirect:boardlist.do?page=1&pagelist=b_regdate";
		}else {
			model.addAttribute("msg", "글 추가 실패");
			return "error";
		}
	}
	
	//게시글 상세보기 
	@RequestMapping(value="/detailboard.do", method=RequestMethod.GET)
	public String detailBoard(HttpSession session, CriteriaDto cri, HttpServletRequest request, Locale locale,
							Model model,String b_seq,String page,String perPageNum) {
		// page정보와 perPageNum을 받을 수 있도록 Criteria 객체를 추가
		
		logger.info("글 상세조회{}.", locale);
		int sseq = Integer.parseInt(b_seq);
		
		MemberDto mdto = (MemberDto)session.getAttribute("member");
		String m_nick = mdto.getNickname();
		
		//조회수증가에 대한 처리
		String rseq = (String)request.getSession().getAttribute("b_readcount");
	
		if(rseq==null) {
			boardService.b_readCount(sseq);
		}	
		request.getSession().setAttribute("b_readcount", b_seq);
	

		
		List<CommentDto1> list = boardService.commentList(sseq);
	

		
		
		BoardDto dto = boardService.getBoard(new BoardDto(sseq,null));
		System.out.println(dto);
		model.addAttribute("cri", cri);
		model.addAttribute("dto", dto);
		model.addAttribute("list", list);

		return "boarddetail";
	}
	
	//게시글 수정폼 이동
	@RequestMapping(value="/updateform.do" , method=RequestMethod.GET)
	public String updateForm(CriteriaDto cri, Locale locale,Model model,String b_seq) {
		logger.info("글수정 폼이동{}.", locale);		
		
		int sseq = Integer.parseInt(b_seq);
		BoardDto dto = boardService.getBoard(new BoardDto(sseq,null));
		model.addAttribute("cri", cri);
		model.addAttribute("dto", dto);
		//boarddetail폼에서 hidden으로 보낸 page와 perPageNum값은 커맨드객체인 CriteriaDto객체에 담겨 모델에
		//cri라는 이름으로 저장된 상태로 boardupdate.jsp로 이동
		
		return "boardupdate";
	}
	
	//게시글 수정 처리
	@RequestMapping(value="/boardupdate.do" , method=RequestMethod.POST)
	public String updateBoard(CriteriaDto cri,Locale locale,Model model,String b_seq,BoardDto dto,String pagelist) {
		logger.info("글 수정하기{}.", locale);
		model.addAttribute("cri", cri);
		model.addAttribute("pagelist", pagelist);
		boolean isS = boardService.updateBoard(dto);
		
		if(isS) {			
			return "redirect:detailboard.do?page="+cri.getPage()+"&b_seq="+dto.getB_seq();

			
		}else {
			model.addAttribute("msg", "수정실패");
			return "error";
		}
	}
	
	//게시글 삭제
	@RequestMapping(value="/delboard.do" , method=RequestMethod.GET)
	public String delBoard(CriteriaDto cri, Locale locale,Model model,String b_seq,HttpServletRequest request,BoardDto dto,String page,String perPageNum,String pagelist) {
		logger.info("글삭제{}.", locale);
		int sseq = Integer.parseInt(b_seq);
		model.addAttribute("cri", cri);
		
		request.getSession().setAttribute("pagelist", pagelist);
		boolean isS = boardService.delBoard(sseq);
		if(isS) {
			return "redirect:boardlist.do?page="+cri.getPage()+"&pagelist="+dto.getPagelist();
		}else {
			model.addAttribute("msg", "글삭제 실패");
			return "error";
		}
		
	}
	
	//게시글상세보기에서 댓글 추가
	@RequestMapping(value="/insertcomment.do",method=RequestMethod.POST)
	public String insertComment(Locale locale,Model model,CommentDto1 cdto,CriteriaDto cri,BoardDto dto,String b_seq) {
		logger.info("댓글 추가{}.", locale);
		boolean isS = boardService.insertComment(cdto);
		if(isS) {
			return "redirect:detailboard.do?page="+cri.getPage()+"&b_seq="+dto.getB_seq();
		}else {
			model.addAttribute("msg", "글 추가 실패");
			return "error";
		}
	}
	//댓글 삭제
	@RequestMapping(value="/delcomment.do" , method=RequestMethod.GET)
	public String delComment(CriteriaDto cri, Locale locale,Model model,String r_seq,BoardDto dto,String page,String perPageNum,CommentDto1 cdto) {
		logger.info("댓글삭제{}.", locale);
		int sseq = Integer.parseInt(r_seq);
		
		model.addAttribute("cri", cri);
		model.addAttribute("dto",dto);
		model.addAttribute("cdto", cdto);
		
		boolean isS = boardService.delComment(sseq);
		if(isS) {
			
			return "redirect:detailboard.do?page="+cri.getPage()+"&perPageNum="+cri.getPerPageNum()+"&b_seq="+dto.getB_seq();
		}else {
			model.addAttribute("msg", "댓글삭제 실패");
			return "error";
		}
		
	}
	//댓글 수정폼으로 이동  -->게시글 상세보기와 수정할 댓글이 뜬다
	@RequestMapping(value="/updatecommentform.do",method=RequestMethod.GET)
	public String updateComment(CriteriaDto cri,Locale locale,Model model,String r_seq,String b_seq) {
		logger.info("댓글수정 폼이동{}.", locale);
		int sseq = Integer.parseInt(b_seq);
		int rseq = Integer.parseInt(r_seq);
		
		BoardDto dto = boardService.getBoard(new BoardDto(sseq,null));
		CommentDto1 cdto = boardService.readComment(rseq);
		model.addAttribute("cri", cri);
		model.addAttribute("dto", dto);
		model.addAttribute("cdto", cdto);
		
		
		return "commentupdate";
	}
	//댓글 수정처리
	@RequestMapping(value="/updatecomment.do", method=RequestMethod.POST)
	public String updateComment(Locale locale,Model model,CriteriaDto cri,String r_seq,CommentDto1 cdto,BoardDto dto) {
		logger.info("댓글 수정하기{}.",locale);
		model.addAttribute("cri", cri);
		boolean isS = boardService.replyBoardUpdate(cdto);
		if(isS) {			
			return "redirect:detailboard.do?page="+cri.getPage()+"&perPageNum="+cri.getPerPageNum()+"&b_seq="+dto.getB_seq();
			
		}else {
			model.addAttribute("msg", "수정실패");
			return "error";
		}
		
	}
	@Autowired
	private BoardLikeService boardLikeService;
	//좋아요기능
	
	@ResponseBody
	@RequestMapping(value="/like.do",method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public String like(int b_seq,String m_nick,HttpSession session,HttpServletRequest request,Model model) {
		JSONObject obj = new JSONObject();
		
		ArrayList<String> msgs = new ArrayList<String>();

		LikeDto ldto = new LikeDto();
		ldto.setB_seq(b_seq);
		ldto.setM_nick(m_nick);
		
		BoardDto dto = boardService.getBoard(new BoardDto(b_seq,null));
		System.out.println("3");
		int b_like=dto.getB_like(); //게시판의 좋아요카운트
		System.out.println(b_like);
				
		if(boardLikeService.countbyLike(ldto)==0) {
			boardLikeService.create(ldto);			
		}
		ldto = boardLikeService.read(ldto);
		int like_check = 0;
		if(ldto.getLike_check() == 0) {
			boardLikeService.like_check(ldto);
			msgs.add("좋아요!");			
			like_check=1;
			b_like++;
			boardService.b_like_up(b_seq);	
		}else {
			boardLikeService.like_check_cancle(ldto);
			msgs.add("좋아요 취소");			
			like_check=0;
			b_like--;
			boardService.b_like_down(b_seq);
			
		}
		obj.put("b_seq", ldto.getB_seq());
		obj.put("like_check",like_check);
		obj.put("b_like", b_like);
		obj.put("msg", msgs);
		
		return obj.toJSONString();
	}
}
