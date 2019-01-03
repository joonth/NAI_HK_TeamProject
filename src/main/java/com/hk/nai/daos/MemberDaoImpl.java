package com.hk.nai.daos;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.nai.dtos.AuthDto;
import com.hk.nai.dtos.MemberDto;
import com.hk.nai.dtos.AcademyDto;
import com.hk.nai.dtos.BasketDto;

@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private String namespace = "com.hk.nai.";
	
	@Override
	public boolean insertMember(MemberDto member) {
		// TODO Auto-generated method stub
		int count=0;
		count = sqlSession.insert(namespace+"insertmember",member);
		return count>0? true:false;
	}

	@Override
	public boolean insertAuth(AuthDto authdto) {
		// TODO Auto-generated method stub
		int count=0;
		count =sqlSession.insert(namespace+"insertauth",authdto);
		return count>0? true:false;
	}

	@Override
	public String checkId(String id) {
		return sqlSession.selectOne(namespace+"checkid", id);
	}

	@Override
	public String checkNickname(String nickname) {
		return  sqlSession.selectOne(namespace+"checknickname", nickname);
	}

	@Override
	public String checkEmail(String email) {
		return sqlSession.selectOne(namespace+"checkemail", email);
	}

	@Override
	public MemberDto signIn(String id) {
		return sqlSession.selectOne(namespace+"signin",id);
	}

	@Override
	public String findId(String email) {
		return sqlSession.selectOne(namespace+"findid",email);
	}

	@Override
	public String findPw(MemberDto member) {
		return sqlSession.selectOne(namespace+"findpw", member);

	}

	@Override
	public boolean tempPw(MemberDto member) {
		int count=0;
		count = sqlSession.update(namespace+"temppw", member);
		return count > 0 ? true: false;
	}

	@Override
	public MemberDto showMyInfo(String id) {
		return sqlSession.selectOne(namespace+"showmyinfo",id);

	}
	
	@Override
	public AuthDto showAuthInfo(String id) {
		return sqlSession.selectOne(namespace+"showauthinfo",id);
	}
	
	@Override
	public boolean updatePw(MemberDto member) {
		int count=0;
		count = sqlSession.update(namespace+"updatepw", member);
		return count > 0 ? true: false;
	}

	@Override
	public boolean updateNickname(MemberDto member) {
		int count=0;
		count = sqlSession.update(namespace+"updatenickname", member);
		return count > 0 ? true: false;
	}

	@Override
	public boolean updateEmail(MemberDto member) {
		int count=0;
		count = sqlSession.update(namespace+"updateemail", member);
		return count > 0 ? true: false;
	}
	
	@Override
	public boolean updateAuth(AuthDto authdto) {
		int count=0;
		count =sqlSession.update(namespace+"updateauth",authdto);
		return count>0? true:false;
	}
	
	@Override
	public boolean deleteMyInfo(MemberDto member) {
		int count=0;
		count = sqlSession.update(namespace+"deletemember", member);
		return count > 0 ? true: false;
	}

	@Override
	public boolean deleteAuthInfo(AuthDto authdto) {
		int count=0;
		count = sqlSession.delete(namespace+"deleteauth", authdto);
		return count > 0 ? true: false;
	}

	@Override
	public List<BasketDto> showMyAcList(String baskId) {
		return sqlSession.selectList(namespace+"showmyaclist", baskId);
	}

	@Override
	public int deleteMyAc(Integer[] myAcSeq) {
		return sqlSession.delete(namespace+"delmyac", myAcSeq);
	}

	@Override
	public List<AcademyDto> searchAcName(String academyName) {
		return sqlSession.selectList(namespace+"searchacname", academyName);
	}
}
