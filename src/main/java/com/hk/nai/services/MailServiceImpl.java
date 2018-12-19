package com.hk.nai.services;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.hk.nai.dtos.MemberDto;

@Service
public class MailServiceImpl implements MailService{
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	@Autowired
	private MemberService memberservice;
	
	//이거 지우면 application-context error
/*	public void setJavaMailSender(JavaMailSender javaMailSender) {
	        this.javaMailSender = javaMailSender;
	}*/
	 
    @Override
	public boolean send(String subject, String text, String to) {
    	   MimeMessage message = javaMailSender.createMimeMessage();
    	   System.out.println("****mail send 호출****");
           try {
               // org.springframework.mail.javamail.MimeMessageHelper
               MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
               helper.setSubject(subject); //제목
               helper.setText(text, true); //내용
               helper.setFrom("leesuminn@gmail.com"); //발신자
               helper.setTo(to); //수신자
  
               javaMailSender.send(message);
               return true;
               
           } catch (MessagingException e) {
               e.printStackTrace();
           }
           return false;
	}

	@Override
	public String authMail(String email, String academyName) {
		//인증번호 생성
		int ranNum = new Random().nextInt(100000000)+10000000; //10000000 
		String authcode = String.valueOf(ranNum);
		String subject = "학원생 인증 코드 발급 안내입니다.";
		StringBuilder sb = new StringBuilder();
		sb.append(academyName+" 학원생 인증코드는" + authcode + "입니다. " + email+"이메일");
		System.out.println(sb.toString());
		boolean isSend = send(subject, sb.toString(), email);
		if(isSend) {
			return authcode;
		}
		return null;
	}
	
	@Override
	public String tempPw(MemberDto member) {
		//사용자가 입력한 아이디, 이메일과 일치하는 이메일이 있는지 확인
		String email = memberservice.findPw(member);
		String msg = "";
		if(email != null) {
			String subject = "임시 비밀번호 발급 안내입니다";

			//임시 비번 생성
			int ranNum = new Random().nextInt(1000000)+100000;
			StringBuilder sb = new StringBuilder();
			Random random = new Random();
			String[] chars = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z".split(",");
			
			for(int i=0; i<4; i++) {
				sb.append(chars[random.nextInt(chars.length)]);
			}
			
			sb.append(Integer.toString(ranNum));
			System.out.println("sb 비번 값: "+ sb.toString());
			member.setPw(sb.toString());
			System.out.println("멤버에저장한 비번 값: "+ member.getPw());
			boolean isPw = memberservice.tempPw(member);
			if(isPw) {
				boolean isSend = send(subject, sb.toString(), email);
				if(isSend) {
					msg = "임시비밀번호를 전송했습니다";
				} else {
					msg ="임시비밀번호 전송에 실패했습니다";
				}
			}
			
		} else {
			msg = "해당하는 회원이 없습니다";
		}
		return msg;
	}

    
    
}
