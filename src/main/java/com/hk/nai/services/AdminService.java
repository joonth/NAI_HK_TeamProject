package com.hk.nai.services;

import java.util.List;

import com.hk.nai.dtos.MemberDto;


public interface AdminService {

	public List<MemberDto> getUserList();
	public MemberDto getUser(int seq);
	public boolean userUpdate(MemberDto dto);
	public boolean delUser(int seq);
	public boolean updateGrade(MemberDto dto);
	public int checkDel(String id);
	public int selectTotalPaging();
	//회원정보수정할때 이메일,닉네임 중복검사
	public boolean checkNicknameMember(String nickname);
	public boolean checkEmailMember(String email);
	
}
