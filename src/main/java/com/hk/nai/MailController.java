package com.hk.nai;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hk.nai.dtos.MemberDto;
import com.hk.nai.services.MailService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class MailController {
		
		@Autowired
		private MailService mailService;
		
		private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

		public void setMailService(MailService mailService) {
			this.mailService = mailService;
		}
		
		//학원생 이메일 인증 ajax 받음
		@RequestMapping(value = "/sendauthmail.do", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, String> sendAuthMail(Locale locale, Model model, @RequestParam String email, @RequestParam String academyName) {
			logger.info("sendauthmail 호출.", locale);

			String authcode = mailService.authMail(email, academyName);
			
			Map<String,String> map = new HashMap<String,String>();
			map.put("authcode", authcode);

			return map;
		}
		
		@RequestMapping(value = "/sendpwmail.do", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, String> sendPwMail(Locale locale, Model model, MemberDto member) {
			logger.info("sendauthmail 호출.", locale);
			String msg = mailService.tempPw(member);
			System.out.println(msg);
			Map<String, String> map = new HashMap<String, String>();
			map.put("msg", msg);
			return map;
		}
		

		
		
		
		

}
