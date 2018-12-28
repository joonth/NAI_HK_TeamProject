package com.hk.nai.daos;

import java.util.List;

import com.hk.nai.dtos.AuthDto;
import com.hk.nai.dtos.MemberDto;
import com.hk.nai.dtos.AcademyDto;
import com.hk.nai.dtos.BasketDto;

public interface MemberDao {
	
	public MemberDto signIn(String id);
	public String checkId(String id);
	public String checkNickname(String nickname);
	public String checkEmail(String email);
	public boolean insertMember(MemberDto member);
	public boolean insertAuth(AuthDto authdto);
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
	public boolean deleteAuthInfo(AuthDto authdto);
	public List<BasketDto> showMyAcList(String baskId);
	public int deleteMyAc(Integer[] myAcSeq);
	public List<AcademyDto> searchAcName(String academyName);
}
