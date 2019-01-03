package com.hk.nai.daos;

import java.util.List;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.nai.dtos.MemberDto;

@Repository  
public class AdminDaoImpl implements AdminDao{

	@Autowired
	private SqlSessionTemplate sqlSession;
	private String namespace="com.hk.nai.";
	//페이징처리
/*	@Override
	public List<Dto> selectPaging(PagingVo paging){
		return sqlSession.selectList(namespace+"selectPaging", paging);
	}*/
	
	//총페이지개수
	@Override
	public int selectTotalPaging() {
		return sqlSession.selectOne("selectTotalPaging");
	}
	
	//회원목록
	@Override
	public List<MemberDto> getUserList(){
		return sqlSession.selectList(namespace+"getUserList");
	}
	
	//회원 상세정보
	@Override
	public MemberDto getUser(int seq){
		return sqlSession.selectOne(namespace+"getUser", seq);
	}
	
	//회원정보 바꾸기
	@Override
	public boolean userUpdate(MemberDto dto){
		int count=0;
		count= sqlSession.update(namespace+"userUpdate", dto);
		return count>0?true:false;
	}
	
	//회원 등급바꾸기
	@Override
	public boolean updateGrade(MemberDto dto){
		int count=0;
		count= sqlSession.update(namespace+"updateGrade", dto);
		return count>0?true:false;
	}

	//체크된 회원 삭제하기
	@Override
	public int checkDel(String id) {
		return sqlSession.update(namespace+"checkDel", id);
	}
	
	//회원 삭제하기
	@Override
	public boolean delUser(int seq){
		int count=0;
		count= sqlSession.update(namespace+"delUser", seq);
		return count>0?true:false;
	}

	@Override
	public String checkNickname(String nickname) {
		return  sqlSession.selectOne(namespace+"checknickname", nickname);
	}

	@Override
	public String checkEmail(String email) {
		return sqlSession.selectOne(namespace+"checkemail", email);
	}

}
