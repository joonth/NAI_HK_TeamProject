package com.hk.nai.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.nai.daos.AdminDao;
import com.hk.nai.dtos.MemberDto;

@Service
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	private AdminDao Dao;

	@Override
	public int selectTotalPaging() {
		return Dao.selectTotalPaging();
	}
	
	@Override
	public List<MemberDto> getUserList(){
		return Dao.getUserList();
	}
	
	@Override
	public MemberDto getUser(int seq){
		return Dao.getUser(seq);
	}
	
	@Override
	public boolean userUpdate(MemberDto dto){
		return Dao.userUpdate(dto);
	}
	
	@Override
	public boolean updateGrade(MemberDto dto){
		return Dao.updateGrade(dto);
	}
	
	@Override
	public int checkDel(String id) {
		return Dao.checkDel(id);
	}
	
	@Override
	public boolean delUser(int seq) {
		return Dao.delUser(seq);
	}

	@Override
	public boolean checkNicknameMember(String nickname) {
		String checkNickname = Dao.checkNickname(nickname);
		if(checkNickname != null) return false;
		return true;
	}

	@Override
	public boolean checkEmailMember(String email) {
		String checkEmail = Dao.checkEmail(email);
		if(checkEmail != null) return false;
		return true;
	}
	
	
	
}
