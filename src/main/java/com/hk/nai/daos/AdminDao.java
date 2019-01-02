package com.hk.nai.daos;

import java.util.List;

import com.hk.nai.dtos.MemberDto;


public interface AdminDao {

	public List<MemberDto> getUserList();
	public MemberDto getUser(int seq);
	public boolean userUpdate(MemberDto dto);
	public boolean delUser(int seq);
	public boolean updateGrade(MemberDto dto);
	public int checkDel(String id);
/*	public List<Dto> selectPaging(PagingVo paging);*/
	public int selectTotalPaging();
	public String checkNickname(String nickname);
	public String checkEmail(String email);

}
