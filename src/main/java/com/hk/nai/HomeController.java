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

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.hk.nai.daos.CommentDao;
import com.hk.nai.dtos.InfoDto;
import com.hk.nai.dtos.SearchDto;
import com.hk.nai.services.InfoService;
import com.hk.nai.services.SearchService;
import com.hk.nai.utils.SearchUtil;
import com.hk.nai.dtos.MessageDto;
import com.hk.nai.daos.MessageDao;
import com.hk.nai.dtos.commentDto;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/////////////////////	이한준	///////////////////////
		
	Map<String,Integer> acListNum = new HashMap<String,Integer>();
	@Autowired		//api로 얻어온 xml data의 tag를 없애는 util.
	SearchUtil util;
	@Autowired
	MessageDao messageDao;
	@Autowired
	CommentDao commentDao;
	@Autowired
	InfoDto infoDto;
	@Autowired
	SearchService Sserv;
	@Autowired
	InfoService Iserv;
	
	@Value("#{apiKey['key']}")	//github에 apikey를 올리지 않기 위해서 key를 따로 저장후 받아옴.
	private String key;
	
	@Autowired
	private MemberService memberService;
	
	/////////////////////	이한준	///////////////////////
	List<SearchDto> list = new ArrayList<SearchDto>();
	int count = 0;	//출력되는 과정수를 나타내기 위한 변수.
	
	
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model ) throws IOException {
		logger.info("main {}.", locale);
		//////////////////////////////////// 이한준 /////////////////////////////////////
		if(list.size() ==0) {		// 과정정보 list를 구하는 for문을 한번만 돌리기 위한 if문.		
			logger.info("학원리스트 출력",locale);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");	
		    Calendar c1 = Calendar.getInstance();
		    String strToday = sdf.format(c1.getTime());
			
			org.jsoup.nodes.Document doc=
			Jsoup.connect("http://www.hrd.go.kr/hrdp/api/apieo/APIEO0101T.do?srchTraEndDt=20191231&pageSize=1500&srchTraStDt="+strToday+"&sortCol=TOT_FXNUM&authKey="+key+"&sort=ASC&returnType=XML&outType=1&pageNum=1&srchTraPattern=2&srchPart=-99&apiRequstPageUrlAdres=/jsp/HRDP/HRDPO00/HRDPOA11/HRDPOA11_1.jsp&apiRequstIp=112.221.224.124")
			.timeout(60000).maxBodySize(10*1024*1024).get();
			Elements datas = doc.select("scn_list");
			
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
					 SearchDto searchDto = new SearchDto();
					 String subtitle = util.tagTrim(datas.get(i).select("subtitle"), "subtitle");
					 String address = util.tagTrim(datas.get(i).select("address"), "address");
					 String trprid = util.tagTrim(datas.get(i).select("trprid"), "trprid");
					 
					 searchDto.setTitle(title);
					 searchDto.setSubTitle(subtitle);
					 searchDto.setAddress(address);
					// searchDto.setScore(Sserv.getScore(subtitle));
					 searchDto.setTrprId(trprid);
					 searchDto.setImg(Sserv.getImg(subtitle));
					
					 acListNum.put(subtitle, count);
					 list.add(searchDto);
					 
					 
					 count++;	

				}
			}//for
			System.out.println("출력 과정수 : "+count);	
		} // if(
		model.addAttribute("list", list);	
		model.addAttribute("key", key);
		
		//////////////////////////////////// 이한준 /////////////////////////////////////
		return "../../index";  //controller가 아니라 signinform.jsp로 이동
	}
	
	//나중에 이거 어떻게 합칠 수 있을 거 같다
	//id 중복 ajax
	@RequestMapping(value="/idcheck.do" , method=RequestMethod.POST)
	@ResponseBody
	public Map<String,String> idCheck(Locale locale, Model model, @RequestParam String id) {
		boolean isS = memberService.checkIdMember(id);
		if(!isS) {
			Map<String,String> map = new HashMap<String,String>();
			String msg = "중복된 아이디입니다";
			map.put("msg", msg);
			System.out.println(msg);
			return map;
		}
		return null; 
	}
	
	//nickname 중복 ajax
	@RequestMapping(value="/nicknamecheck.do" , method=RequestMethod.POST)
	@ResponseBody
	public Map<String,String> nicknameCheck(Locale locale, Model model, @RequestParam String nickname) {
		boolean isS = memberService.checkNicknameMember(nickname);
		if(!isS) {
			Map<String,String> map = new HashMap<String,String>();
			String msg = "중복된 닉네임입니다";
			map.put("msg", msg);
			System.out.println(msg);
			return map;
		}
		return null; 
	}	
	
	//email 중복 ajax
	@RequestMapping(value="/emailcheck.do" , method=RequestMethod.POST)
	@ResponseBody
	public Map<String,String> emailCheck(Locale locale, Model model, @RequestParam String email) {
		boolean isS = memberService.checkEmailMember(email);
		if(!isS) {
			Map<String,String> map = new HashMap<String,String>();
			String msg = "중복된 이메일입니다";
			map.put("msg", msg);
			System.out.println(msg);
			return map;
		}
		return null; 
	}
	
	@RequestMapping(value="/signupform.do" , method=RequestMethod.GET)
	public String signupForm(Locale locale, Model model) {
		logger.info("signupform.", locale);
		return "signupform";
	}
	
	@RequestMapping(value="/signup.do" , method=RequestMethod.POST)
	public String signup(Locale locale, Model model, MemberDto memdto, @RequestParam String academyName) {
		logger.info("signup.", locale);
		System.out.println(memdto.toString());
		System.out.println("academyName: "+academyName);
		boolean isS = memberService.signupMember(memdto,academyName);
		System.out.println("isS: "+isS);
		if(isS) {
			return "redirect:signinform.do";
		} else {
			model.addAttribute("errmsg", "회원가입실패");
			return "error";
		}
	}
	
	//로그인폼
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
			//세션에 공개키의 문자열을 키로하여 개인키를 저장한다
			session.setAttribute("rsaPrivateKey", privateKey);
			
			//공개키 문자열로 변환하여 js rsa 라이브러리 넘겨줌
			
			RSAPublicKeySpec publicSpec = keyFactory.getKeySpec(publicKey,RSAPublicKeySpec.class);
			
			String publicKeyModules = publicSpec.getModulus().toString(16);
			String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
			
			model.addAttribute("publicKeyModules", publicKeyModules);
			model.addAttribute("publicKeyExponent", publicKeyExponent);			
			
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			model.addAttribute("errmsg", "로그인실패");
			return "error";
		}
		return "signinform";
	}
	
	//로그인, 복호화
	
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
		
//		session.removeAttribute("rsaPrivateKey");  //키의 재사용 막음
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
		}
		
		//세션에 로그인 정보 저장
		session.setAttribute("member", member);
		return "redirect:main.do";
	}
	
	@RequestMapping(value = "/signout.do", method = RequestMethod.GET)
	public String signout(Locale locale, Model model, HttpSession session, HttpServletRequest response) {
		logger.info("signout.", locale);
		session.removeAttribute("member");
		return "redirect:main.do";
	}
	
	//아이디찾기폼
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
	
	//비번찾기폼
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
	
	@RequestMapping(value = "/updatemyinfo.do", method = RequestMethod.POST)
	public String updateMyInfo(Locale locale, Model model, MemberDto member, String academyName) {
		System.out.println(member.getPw());
		boolean isPw = memberService.updatePw(member);		
		boolean isNickname = memberService.updateNickname(member);
		boolean isEmail = memberService.updateEmail(member);
		boolean isAuth = memberService.updateAuth(new AuthDto().setAuthId(member.getId()).setAcademyName(academyName));
		System.out.println("pw 성공여부:" + isPw
				+ "isNickname 여부: " + isNickname
				+ "isEmail 여부: " + isEmail
				+ "isAuth 여부: " + isAuth);
		
		if(!isPw && !isNickname && !isEmail && !isAuth) {
			model.addAttribute("errmsg", "수정 실패");
			return "error";
		}
		return "redirect:mypage.do";
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
  
 
	
	@RequestMapping(value = "/getMessageList.do", method = RequestMethod.GET)
	public String getAllBoard(Locale locale, Model model, String n_receiver) {
		logger.info("메시지 리스트 출력", locale);
		List<MessageDto> list = messageDao.getMessageList(n_receiver);
		model.addAttribute("list", list);
		return "messagelist";
	}
	
	@RequestMapping(value = "/getMessage.do", method = RequestMethod.GET)
	public String getMessage(Locale locale, Model model, MessageDto dto) {
		logger.info("메시지 내용 출력", locale);
		MessageDto  mdto = messageDao.getMessage(dto.getN_seq());
		model.addAttribute("dto",mdto);
		return "messagecontent";
	}
	

	@RequestMapping(value = "/sendMessage.do", method = RequestMethod.POST)
	public String sendMessage(Locale locale, Model model, MessageDto dto) {
		logger.info("메시지 전송", locale);
		messageDao.sendMessage(dto);
		
		return "../../index";
	}
	
	@RequestMapping(value = "/deleteMessage.do", method = RequestMethod.GET)
	public String deleteMessage(Locale locale, Model model, MessageDto dto, String n_receiver) {
		logger.info("메시지 삭제", locale);
		messageDao.deleteMessage(dto.getN_seq());
		List<MessageDto> list = messageDao.getMessageList(n_receiver);
		model.addAttribute("list", list);
		return "messagelist";
	}
	
	@RequestMapping(value = "/info.do", method = RequestMethod.GET)
	public String info(Locale locale, Model model, String subTitle) throws IOException {
		
		 org.jsoup.nodes.Document docInfo=
					Jsoup.connect("http://www.hrd.go.kr/jsp/HRDP/HRDPO00/HRDPOA40/HRDPOA40_2.jsp?authKey="+key+"&returnType=XML&outType=2&srchTrprId="+list.get(acListNum.get(subTitle)).getTrprId()+"&srchTrprDegr=1")
					.timeout(80000).maxBodySize(10*1024*1024).get();
		infoDto.setImg(list.get(acListNum.get(subTitle)).getImg());
		infoDto.setAddr1(docInfo.select("addr1").toString());
		infoDto.setAddr2(docInfo.select("addr2").toString());
		infoDto.setHpaddr(docInfo.select("hpAddr").toString());
		infoDto.setInonm(docInfo.select("inoNm").toString());
		infoDto.setTrprchaptel(docInfo.select("trprChapTel").toString());
		infoDto.setTrprnm(docInfo.select("trprNm").toString());
		model.addAttribute("infoDto", infoDto);
		
		List<commentDto> commentList = new ArrayList<commentDto>();
		commentList = Iserv.getComment(subTitle);
		if(!(commentList.size()==0)) {
			model.addAttribute("list", commentList);
		}else {
			model.addAttribute("list", null);
		}
		
		return "info";
	}
	//CommentDao
	
	@ResponseBody
	@RequestMapping(value = "/addComment.do", method = RequestMethod.GET)
	public Map<String,commentDto> addComment(Locale locale, Model model,commentDto dto) throws IOException {
		String subtitle = util.tagTrim_str(dto.getAc_name(), "inonm");
		//학원평 작성시 평점 반영.
		list.get(acListNum.get(subtitle)).setScore(Sserv.getScore(subtitle));
		dto.setAc_name(subtitle);
		commentDao.addComment(dto);

		Map<String,commentDto> map = new HashMap<String,commentDto>();
		map.put("dto", dto);
		return map;
	}
    
	@ResponseBody
	@RequestMapping(value = "/getList.do", method = RequestMethod.POST)
	public Map<String,Float> getList(Locale locale, Model model,String[] acTitle) throws IOException {
		Map<String,Float> map = new HashMap<String,Float>();

		for (int i = 0; i < acTitle.length; i++) {
			list.get(acListNum.get(acTitle[i])).setScore(Sserv.getScore(acTitle[i]));
			map.put(acTitle[i], Sserv.getScore(acTitle[i]));
		}
		model.addAttribute("map",map);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getMemberList.do", method = RequestMethod.POST)
	public Map<String,List<MemberDto>> getMemberList(Locale locale, Model model) throws IOException {
		Map<String,List<MemberDto>> map = new HashMap<String,List<MemberDto>>();
		map.put("list", Sserv.getMemberList());
		return map;
	}
	

	@ResponseBody
	@RequestMapping(value = "/changeState.do", method = RequestMethod.GET)
	public Map<String,String> changeState(Locale locale, Model model,String value,String section) throws IOException {
		Map<String,String> map = new HashMap<String,String>();	
		section = (section.equals("a")) ? "b": "a";
		map.put("value", value);
		map.put("section", section);
		return map;
	}
	
    ////////////////	이한준 	//////////////////////////////////////////////////////////////////////////////
    
    
    
    
}
