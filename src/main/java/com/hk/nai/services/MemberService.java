package com.hk.nai.services;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.hk.nai.dtos.AuthDto;
import com.hk.nai.dtos.MemberDto;
import com.hk.nai.dtos.AcademyDto;
import com.hk.nai.dtos.BasketDto;

public interface MemberService {
	public MemberDto signin(String id, String pw);
	public boolean signout(HttpServletResponse response);
	public boolean signupMember(MemberDto member,String academyName);
	public boolean checkIdMember(String id);
	public boolean checkNicknameMember(String nickname);
	public boolean checkEmailMember(String email);
	public String findId(String email);
	public String findPw(MemberDto member);
	public boolean tempPw(MemberDto member);
	public MemberDto showMyInfo(String id);
	public AuthDto showAuthInfo(String id);
	public boolean updatePw(MemberDto member);
	public boolean updateNickname(MemberDto member);
	public boolean updateEmail(MemberDto member);
	public boolean updateAuth(AuthDto authdto);
	public boolean deleteMyInfo(MemberDto member);
	public List<BasketDto> showMyAcList(String baskId);
	public int deleteMyAc(Integer[] myAcSeq);
	public List<AcademyDto> searchAcName(String academyName);
	
}
