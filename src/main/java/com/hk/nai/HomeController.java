package com.hk.nai;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.RSAPublicKeySpec;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hk.nai.dtos.AuthDto;
import com.hk.nai.dtos.MemberDto;
import com.hk.nai.services.MemberService;
import com.hk.nai.HomeController;
import com.hk.nai.dtos.InfoDto;
import com.hk.nai.dtos.AcInfoDto;
import com.hk.nai.dtos.StartClassDto;
import com.hk.nai.services.InfoService;
import com.hk.nai.services.SearchService;
import com.hk.nai.utils.SearchUtil;
import com.hk.nai.dtos.BasketDto;
import com.hk.nai.dtos.AcademyDto;
import com.hk.nai.services.CommentAddPermitService;
import com.hk.nai.services.CommentService;
import com.hk.nai.services.DataHandleService;
import com.hk.nai.services.IBoardService;
import com.hk.nai.services.CacheService;
import com.hk.nai.dtos.MessageDto;
import com.hk.nai.daos.MessageDao;
import com.hk.nai.daos.PointHandleDao;
import com.hk.nai.dtos.commentDto;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	//API를 여러번 호출하지않기 위해서 받아온  Data를 맵에 저장하여 필요한부분에서 사용할 수 있도록.
	Map<String,LinkedList<AcInfoDto>> getAcInfoMap = new HashMap<String,LinkedList<AcInfoDto>>();	

	@Autowired		//api로 얻어온 xml data의 tag를 없애는 util.
	SearchUtil util;
	@Autowired
	MessageDao messageDao;
	@Autowired
	CommentService Cserv;
	@Autowired
	PointHandleDao pointDao;
	@Autowired
	SearchService Sserv;
	@Autowired
	InfoService Iserv;
	@Autowired
	CommentAddPermitService commentAddPermit;
	@Autowired
	DataHandleService dataHandleService;
	
	@Value("#{apiKey['key']}")	//github에 apikey를 올리지 않기 위해서 key를 따로 저장후 받아옴.
	private String key;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CacheService cacheService;
	
	@Autowired
	IBoardService boardService;
	
	List<AcInfoDto> list = new ArrayList<AcInfoDto>();
	int count = 0;	//출력되는 과정수를 나타내기 위한 변수.
	
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws IOException {
		logger.info("main {}.", locale);
		if(list.size() ==0) {		// 과정정보 list를 구하는 for문을 한번만 돌리기 위한 if문.
			logger.info("학원리스트 출력",locale);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");	
		    Calendar c1 = Calendar.getInstance();
		    String strToday = sdf.format(c1.getTime());
			
			org.jsoup.nodes.Document doc=
			Jsoup.connect("http://www.hrd.go.kr/hrdp/api/apieo/APIEO0101T.do?srchTraEndDt=20191231&pageSize=1500&srchTraStDt="+strToday+"&sortCol=TOT_FXNUM&authKey="+key+"&sort=ASC&returnType=XML&outType=1&pageNum=1&srchTraPattern=2&srchPart=-99&apiRequstPageUrlAdres=/jsp/HRDP/HRDPO00/HRDPOA11/HRDPOA11_1.jsp&apiRequstIp=112.221.224.124")
			.timeout(60000).maxBodySize(10*1024*1024).get();
			Elements datas = doc.select("scn_list");
			
			// 훈련분야를 분류하는 코드를 사용할 수 없어서 키워드로 it분야를 분류...
			for(int i = 0; i < datas.size(); i++){
				String title = util.tagTrim(datas.get(i).select("title"), "title");
				if(title.contains("자바")
						|| title.contains("웹")
						|| title.contains("앱")
						|| title.contains("빅데이터")
						|| title.contains("개발자")
						|| title.contains("Iot")
						|| title.contains("ICT")
						|| title.contains("파이썬")
						|| title.contains("오라클")
						|| title.contains("UI")
						|| title.contains("UX")
						|| title.contains("디지털컨버전스")
						|| title.contains("오픈소스")
						|| title.contains("사물인터넷")
						|| title.contains("프로그래밍")
						|| title.contains("보안"))
				 {		 
					 AcInfoDto acInfoDto = new AcInfoDto();
					 String subtitle = util.tagTrim(datas.get(i).select("subtitle"), "subtitle");
					 String address = util.tagTrim(datas.get(i).select("address"), "address");
					 String trprid = util.tagTrim(datas.get(i).select("trprid"), "trprid");
					 String trastartdate =util.tagTrim(datas.get(i).select("trastartdate"), "trastartdate");
					
					 acInfoDto.setTitle(title)
					 		  .setSubTitle(subtitle)
					 		  .setAddress(address) 
					 		  .setTrprId(trprid) 
					 		  .setTrastartdate(trastartdate)
					 		  .setDday(util.trimDday(acInfoDto));
										 
					 // 학원 img 처리
					 if(Sserv.getImg(subtitle) != null) {
						 acInfoDto.setImg(Sserv.getImg(subtitle));						 
					 }else {	//db에 해당하는 학원의 img가 없으면 api요청해서 img를 받고 db에 저장한다.
					     org.jsoup.nodes.Document imgData=
					     Jsoup.connect("http://www.hrd.go.kr/jsp/HRDP/HRDPO00/HRDPOA40/HRDPOA40_2.jsp?authKey="+key+"&returnType=XML&outType=2&srchTrprId="+trprid+"&srchTrprDegr=1")
					 	 .timeout(80000).maxBodySize(10*1024*1024).get();
					     String img = util.tagTrim(imgData.select("filepath"), "filepath");				    
					   //요청해서 받은 이미지가 없을경우 이미지없음 사진을 저장.
					     if(img.equals("")){ 
							  acInfoDto.setImg("http://sign.kedui.net/rtimages/n_sub/no_detail_img.gif");
						 }else{
							acInfoDto.setImg(img);
						 }  
						 Sserv.addImgToDb(acInfoDto);
					 }	
					
					 // getAcInfoMap에   AcInfoDto를 저장
					 if(getAcInfoMap.containsKey(subtitle)) {
						 getAcInfoMap.get(subtitle).add(acInfoDto);					 
					 }else {
						 List<AcInfoDto> acClassList = new LinkedList<AcInfoDto>();
						 acClassList.add(acInfoDto);
						 getAcInfoMap.put(subtitle, (LinkedList<AcInfoDto>) acClassList);
					 }	 
					 list.add(acInfoDto); 
					 count++;	
				}
			}//for
			// 과정출력 갯수가 달라지면 update가 된것으로 간주하고 db에  새로운 과정 list를  받는다.
			if(dataHandleService.getAcClassNum() != count) {
				dataHandleService.insUpToDateData(list);
			}
			System.out.println("출력 과정수 : "+count);	
		} // if(
		model.addAttribute("list", list);	
		model.addAttribute("key", key);
		
		// 학원랭킹, 마감임박수업 캐시
		model.addAttribute("ranking", cacheService.showRanking());
		model.addAttribute("startclass", cacheService.showStartClass());
		return "../../index";  //controller가 아니라 signinform.jsp로 이동
	}
	
	//id 중복 ajax
	@RequestMapping(value="/idcheck.do" , method=RequestMethod.POST)
	@ResponseBody
	public Map<String,String> idCheck(Locale locale, Model model, @RequestParam String id) {
		return duplicatedCheck("id", memberService.checkIdMember(id));
	}

	//nickname 중복 ajax
	@RequestMapping(value="/nicknamecheck.do" , method=RequestMethod.POST)
	@ResponseBody
	public Map<String,String> nicknameCheck(Locale locale, Model model, @RequestParam String nickname) {
		return duplicatedCheck("nickname", memberService.checkNicknameMember(nickname));
	}	
	
	//email 중복 ajax
	@RequestMapping(value="/emailcheck.do" , method=RequestMethod.POST)
	@ResponseBody
	public Map<String,String> emailCheck(Locale locale, Model model, @RequestParam String email) {
		return duplicatedCheck("email", memberService.checkEmailMember(email));
	}
	
	private Map<String,String> duplicatedCheck(String param, boolean isS) {
		if(!isS) {
			String msg = "중복된 ";
			Map<String,String> map = new HashMap<String,String>();
			switch(param) {
				case "id" : 
					msg += " 아이디입니다";
					break;
				case "nickname":
					msg += " 닉네임입니다";
					break;
				case "email":
					msg += " 이메일입니다";
			}
			map.put("msg", msg);
			return map;
		}
		else 
			return null;

	}
	
	//학원명 찾기 ajax
		@RequestMapping(value="/searchacademyname.do" , method=RequestMethod.POST)
		@ResponseBody
		public JSONArray searchAcademyName(Locale locale, Model model, @RequestParam String searchAcName) {
			logger.info("searchAcademyName.");
			String replacedAcName = searchAcName.replaceAll(" ", "");
			if(replacedAcName.equals("")) {
				return null;
			}
			List<AcademyDto> academy = memberService.searchAcName(replacedAcName);
			JSONArray list = new JSONArray();
			JSONObject obj = null;
			if(academy != null) {
				for(int i=0; i<academy.size(); i++) {
					String ac = academy.get(i).getAcademyName().replaceAll(" ", "");
					System.out.println(ac);
					obj = new JSONObject();
					obj.put("data", ac);
					list.add(obj);
				}
				return list;
			}
			return null;
		}
	
	
	//회원가입 폼
	@RequestMapping(value="/signupform.do" , method=RequestMethod.GET)
	public String signupForm(Locale locale, Model model) {
		logger.info("signupform.", locale);
		return "signupform";
	}
	
	//회원가입
	@RequestMapping(value="/signup.do" , method=RequestMethod.POST)
	public String signup(Locale locale, Model model, MemberDto memdto, @RequestParam String academyName) {
		logger.info("signup.", locale);
		boolean isS = memberService.signupMember(memdto,academyName);

		if(isS) {
			return "redirect:signinform.do";
		} else {
			model.addAttribute("errmsg", "회원가입실패");
			return "error";
		}
	}
	
	//로그인 폼
	@RequestMapping(value = "/signinform.do", method = RequestMethod.GET)
	public String signinForm(Locale locale, Model model, HttpServletRequest request) throws InvalidKeySpecException {
		logger.info("***enter signinform {}.", locale);
		KeyPairGenerator generator;
		try {
			generator = KeyPairGenerator.getInstance("RSA");
			generator.initialize(1024);
			
			KeyPair keyPair = generator.genKeyPair();
			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
			
			PublicKey publicKey = keyPair.getPublic();
			PrivateKey privateKey = keyPair.getPrivate();
			
			HttpSession session=request.getSession();
			session.setAttribute("rsaPrivateKey", privateKey);
				
			RSAPublicKeySpec publicSpec = keyFactory.getKeySpec(publicKey,RSAPublicKeySpec.class);
			
			String publicKeyModules = publicSpec.getModulus().toString(16);
			String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
			
			model.addAttribute("publicKeyModules", publicKeyModules);
			model.addAttribute("publicKeyExponent", publicKeyExponent);			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			model.addAttribute("errmsg", "로그인실패");
			return "error";
		}
		return "signinform";
	}
	
	//로그인 및 복호화
	@RequestMapping(value = "/signin.do", method = RequestMethod.POST)
	public String signin(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("***enter signin  {}.", locale);
		
		String securedId = request.getParameter("securedId");
		String securedPassword = request.getParameter("securedPassword");

		HttpSession session = request.getSession();
		PrivateKey privateKey = (PrivateKey) session.getAttribute("rsaPrivateKey");

		if(privateKey == null) {
			throw new RuntimeException("암호화 비밀키 정보를 찾을 수 없음");
		}
		
		//복호화
		String id = decryptRsa(privateKey, securedId);
		String pw = decryptRsa(privateKey, securedPassword);

		MemberDto member = memberService.signin(id, pw);

		if (member == null) {
			response.setContentType("text/html;charset=utf-8");;
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('아이디 또는 비밀번호가 틀립니다');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return null;
		} else { 		
			session.setAttribute("member", member); 
			return "redirect:main.do";
		}
	}
	
	@RequestMapping(value = "/signout.do", method = RequestMethod.GET)
	public String signout(Locale locale, Model model, HttpSession session, HttpServletRequest response) {
		logger.info("signout.", locale);
		session.removeAttribute("member");
		return "redirect:main.do";
	}
	
	//아이디찾기 폼
	@RequestMapping(value = "/findidform.do", method = RequestMethod.GET)
	public String findIdForm(Locale locale, Model model) {
		logger.info("findidform.", locale);
		return "findidform";
	}	
	
	//아이디찾기
	@RequestMapping(value = "/findid.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,String> findId(Locale locale, Model model, @RequestParam String email) {
		logger.info("findidform.", locale);
		String id = memberService.findId(email);
		Map<String,String> map = new HashMap<String,String>();

		if(id == null) {
			String msg = "이메일과 일치하는 해당 아이디가 없습니다";
			map.put("result", msg);
		}
		else {
			map.put("result", id);
		}

		return map; 
	}	
	
	//비번찾기 폼
	@RequestMapping(value = "/findpwform.do", method = RequestMethod.GET)
	public String findPwForm(Locale locale, Model model) {
		logger.info("findpwform.", locale);
		return "findpwform";
	}	

	//마이페이지
	@RequestMapping(value = "/mypage.do", method = RequestMethod.GET)
	public String mypage(Locale locale, Model model,HttpSession session) {
		logger.info("mypage.", locale);
		
		//현재 로그인된 사용자의 아이디 가져오기
		MemberDto member = (MemberDto) session.getAttribute("member");
		String id = member.getId();
		MemberDto member2 = memberService.showMyInfo(id);
		model.addAttribute("member", member2);
		
		AuthDto memberAuth = memberService.showAuthInfo(id);
		System.out.println("auth 값" + memberAuth);
		model.addAttribute("auth", memberAuth);

		return "myinfo";
	}	
	
	//회원정보 수정
	@RequestMapping(value = "/updatemyinfo.do", method = RequestMethod.POST)
	public String updateMyInfo(Locale locale, Model model, MemberDto member, String academyName, HttpSession session,HttpServletRequest request) {
		
		boolean isPw = false;
		boolean isNickname = false;
		boolean isEmail = false;
		boolean isAuth = false;
		int errcnt = 0;
		
//		황인후 원래 닉네임과 바뀐닉네임 받아오기
		String ori_nick = request.getParameter("ori_nick");
		String m_nick = request.getParameter("nickname");
		Map<String, String> map = new HashMap<String,String>();
		map.put("ori_nick", ori_nick);
		map.put("m_nick", m_nick);		
//		추가 끝
		
		if(!member.getPw().isEmpty()) {
			isPw = memberService.updatePw(member);	 
			if(isPw==false) errcnt++; 
		}	
		if(!member.getNickname().isEmpty()) {
			isNickname = memberService.updateNickname(member);
//			황인후  닉네임 변경시 게시판,댓글 닉네임도 같이 변경
			boardService.bUpdateNick(map);
			boardService.cUpdateNick(map);
			boardService.lUpdateNick(map);
//			추가 끝
			if(isNickname==false) errcnt++; 
		}
		if(!member.getEmail().isEmpty()) {
			isEmail = memberService.updateEmail(member);	
			if(isEmail==false) errcnt++; 
		}
		if(!academyName.isEmpty()) { 
			isAuth = memberService.updateAuth(new AuthDto().setAuthId(member.getId()).setAcademyName(academyName));
			if(isAuth==false) errcnt++; 
		}
		else //학원명 인증이 안 된 일반사용자
			isAuth = true;
		
		System.out.println("pw 변경여부: " + isPw
				+ " isNickname 변경여부: " + isNickname
				+ " isEmail 변경여부: " + isEmail
				+ " isAuth 변경여부: " + isAuth);
		
		if(errcnt > 0) {
			model.addAttribute("errmsg", "수정 실패");
			return "error";
		}
		
		//세션 값 갱신
		session.setAttribute("member", member);
		System.out.println("변경후 session값 :" + session.getAttribute("member"));
		return "redirect:mypage.do";
	}
	
	//탈퇴하기 form
	@RequestMapping(value="/withdrawform.do" , method=RequestMethod.GET)
	public String withdrawForm(Locale locale, Model model) {
		logger.info("withdrawform.", locale);
		return "withdrawform";
	}
		
	//탈퇴
	@RequestMapping(value = "/withdraw.do", method = RequestMethod.POST)
	public String withdraw(Locale locale, Model model, MemberDto member, HttpSession session, HttpServletResponse response) throws IOException {
		System.out.println("탈퇴 컨트롤러 진입 멤버값"+member);
		boolean isDel = memberService.deleteMyInfo(member);
		System.out.println("삭제 여부?" + isDel);
		if (!isDel) {
			response.setContentType("text/html;charset=utf-8");;
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('비밀번호가 틀립니다');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return "redirect:withdrawform.do";
		} else {
			session.removeAttribute("member");
			return "redirect:main.do";	
		}
		
	}
	
	//찜한 학원 리스트
		@RequestMapping(value="/myacademylist.do" , method=RequestMethod.GET)
		public String myAcademyList(Locale locale, Model model, HttpSession session) {
			logger.info("myacademylist.", locale);
			MemberDto member = (MemberDto) session.getAttribute("member");
			String baskId = member.getId();
			List<BasketDto> myAcList = memberService.showMyAcList(baskId);
			model.addAttribute("myAcList", myAcList);
			return "myacademylist";
		}
		
		//찜한 학원 목록 삭제 ajax
		@RequestMapping(value="/delmyacademy.do" , method=RequestMethod.POST)
		@ResponseBody
		public Map<String,String> delMyAcademy(Locale locale, Model model, @RequestParam Integer[] myAcSeq) {
			System.out.println("myAcSeq" + myAcSeq);
			int cnt = myAcSeq.length;
			int chkdelcnt = memberService.deleteMyAc(myAcSeq);
			Map<String,String> map = new HashMap<String,String>();
			if(cnt == chkdelcnt) {
				System.out.println("삭제한 찜하기 학원 개수 일치");
				map.put("msg", "삭제 완료");
			}
			return map;
		}	
	
	
	//복호화
    private String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {        
    	Cipher cipher = Cipher.getInstance("RSA");
        byte[] encryptedBytes = hexToByteArray(securedValue);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
        return decryptedValue;
    }
    
    //16진 문자열을 byte배열로 변환
    public static byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() % 2 != 0) {
            return new byte[]{};
        }

        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte)Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
    }
    
    ////////////////	이한준 	//////////////////////////////////////////////////////////////////////////////
	
	@RequestMapping(value = "/info.do", method = RequestMethod.GET)
	public String info(Locale locale, Model model, String subTitle) throws IOException {
		InfoDto infoDto = new InfoDto();
		 org.jsoup.nodes.Document docInfo=
					Jsoup.connect("http://www.hrd.go.kr/jsp/HRDP/HRDPO00/HRDPOA40/HRDPOA40_2.jsp?authKey="+key+"&returnType=XML&outType=2&srchTrprId="+getAcInfoMap.get(subTitle).get(0).getTrprId()+"&srchTrprDegr=1")
					.timeout(80000).maxBodySize(10*1024*1024).get();

	 	infoDto.setImg(getAcInfoMap.get(subTitle).get(0).getImg())
				.setAddr1(util.tagTrim(docInfo.select("addr1"),"addr1"))
				.setAddr2(util.tagTrim(docInfo.select("addr2"),"addr2"))
				.setHpaddr(util.tagTrim(docInfo.select("hpaddr"),"hpaddr"))
				.setInonm(util.tagTrim(docInfo.select("inonm"),"inonm"))
				.setTrprchaptel(util.tagTrim(docInfo.select("trprchaptel"),"trprchaptel"))
				.setTrprnm(util.tagTrim(docInfo.select("trprnm"),"trprnm"))
				.setScore(Sserv.getScore(subTitle));
		
		model.addAttribute("infoDto", infoDto);
		// 개강일자가 빠른 순서대로 출력하기 위한 정렬
		List<AcInfoDto> aclist = getAcInfoMap.get(subTitle);
		Collections.sort(aclist);
		//
		model.addAttribute("aclist",aclist);
		List<commentDto> commentList = new ArrayList<commentDto>();
		commentList = Iserv.getComment(subTitle);
		if(!(commentList.size()==0)) {
			model.addAttribute("list", commentList);
		}else {
			model.addAttribute("list", null);
		}
		
		return "info";
	}
	
	@ResponseBody
	@RequestMapping(value = "/addComment.do", method = RequestMethod.GET)
	public Map<String,commentDto> addComment(Locale locale, Model model,commentDto dto, HttpSession session) throws IOException {
		Map<String,commentDto> map = new HashMap<String,commentDto>();
		MemberDto member = (MemberDto) session.getAttribute("member");
		String subtitle = dto.getAc_name();
		dto.setAc_name(subtitle);
		// 등록학원과 중복작성여부 체크
		if(commentAddPermit.getAuth(subtitle, dto.getM_id()) && commentAddPermit.checkDupe(member.getId())) {
				//학원평 작성시 포인트 추가
				member.setPoint(100);
				if(pointDao.addPoint(member) >= 100) {
					MessageDto mdto = new MessageDto();
					mdto.setN_sender("admin");
					mdto.setN_receiver(member.getId());
					mdto.setN_content("포인트 100점을 달성하셨습니다~ <br><br> 아래의 링크를 통해서 쿠폰을 받아보실수 있습니다~! <br><br> http://쿠폰쿠폰.com");
					mdto.setNs_state_code("e");
					messageDao.sendMessage(mdto);
				}
			Cserv.addComment(dto);
			map.put("dto", dto);
		}else {
			dto.setAc_comment("false");
			map.put("dto", dto);
		}
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/deleteComment.do", method = RequestMethod.GET)
	public void deleteComment(Locale locale, Model model, String m_id, String ac_name) throws IOException {
		logger.info("학원평 삭제", locale);
		Cserv.deleteComment(m_id);
	}
    
	
	@ResponseBody
	@RequestMapping(value = "/getList.do", method = RequestMethod.POST)
	public Map<String,Float> getList(Locale locale, Model model,String[] acTitle) throws IOException {
		Map<String,Float> map = new HashMap<String,Float>();

		if(acTitle != null) {	
			for (int i = 0; i < acTitle.length; i++) {
				map.put(acTitle[i], Sserv.getScore(acTitle[i]));
			}
		}
		model.addAttribute("map",map);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/putBasket.do", method = RequestMethod.GET)
	public Map<String,String> putBasket(Locale locale, Model model, BasketDto dto,HttpSession session) throws IOException {
	Map<String,String> map = new HashMap<String,String>();
	MemberDto mto = (MemberDto)session.getAttribute("member");
	List<StartClassDto> list = cacheService.showStartClass();
	List<BasketDto> myAcList = memberService.showMyAcList(mto.getId());
	if(myAcList != null) {	
		for(BasketDto bdto : myAcList) {
			if(bdto.getBaskAcademyName().equals(dto.getBaskAcademyName())) {
				map.put("msg", "이미 찜한 학원입니다.");
				return map;
			}
		}
	}
		for(int i =0; i<list.size(); i++) {
			StartClassDto sto = list.get(i);
			if(sto.getStartAcademyName().equals(dto.getBaskAcademyName())) {
				MessageDto mdto = new MessageDto();
				mdto.setN_sender("admin");
				mdto.setN_receiver(dto.getBaskId());
				mdto.setN_content(sto.getStartAcademyName()+"  <br><br>"+sto.getStartClassName()+" <br><br> 개강까지" + sto.getStartDDay()+"일 남았습니다!.");
				mdto.setNs_state_code("a");
				messageDao.sendMessage(mdto);
			}
		}
		System.out.println(dto.getBaskId()+" "+dto.getBaskAcademyName());
		Sserv.putBasket(dto);
		map.put("msg", "찜목록에 추가되었습니다.");
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/showBasket.do", method = RequestMethod.GET)
	public Map<String,List<String>> showBasket(Locale locale, Model model, String m_id) throws IOException {
		logger.info("장바구니 출력", locale);
		List<String> img = new ArrayList<String>();
		List<BasketDto> myAcList = memberService.showMyAcList(m_id);
		if(myAcList != null) {	
			for(int i=0; i<myAcList.size(); i++) {
				AcInfoDto dto = (AcInfoDto) getAcInfoMap.get((myAcList.get(i).getBaskAcademyName())).get(0);
				img.add(dto.getImg());
				img.add(dto.getSubTitle());
			}	
		}
		Map<String,List<String>> list = new HashMap<String,List<String>>();
		list.put("list", img);
		return list;
	}
	
	@RequestMapping(value="/getMessageForm.do" , method=RequestMethod.GET)
	public String getMessageForm(Locale locale, Model model) {
		logger.info("getMessageForm 가져오기", locale);
		return "sendmessageform";
	}
    ////////////////	이한준 	//////////////////////////////////////////////////////////////////////////////   
}
