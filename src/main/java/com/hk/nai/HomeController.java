package com.hk.nai;

import java.io.PrintWriter;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.RSAPublicKeySpec;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hk.nai.dtos.AuthDto;
import com.hk.nai.dtos.MemberDto;
import com.hk.nai.services.MemberService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	//locale model 뭐지?
	public String home(Locale locale, Model model, HttpServletRequest request, HttpSession session) {
		logger.info("main {}.", locale);
		
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
}
