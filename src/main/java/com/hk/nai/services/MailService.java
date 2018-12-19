package com.hk.nai.services;

import com.hk.nai.dtos.MemberDto;

public interface MailService {

	public boolean send(String subject, String text, String to);
	public String authMail(String email, String academyName);
	public String tempPw(MemberDto member);
}
