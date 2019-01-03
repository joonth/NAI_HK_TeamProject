package com.hk.nai.daos;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.nai.dtos.LikeDto;

@Repository
public class BoardLikeDao implements IBoardLikeDao{

	@Autowired
	private SqlSessionTemplate sqlSession;
	private String namespace="com.hk.nai.";

	@Override
	public int countbyLike(LikeDto ldto) {
		int count = sqlSession.selectOne(namespace+"countbyLike", ldto);
		return count;
	}

	@Override
	public boolean create(LikeDto ldto) {
		int count = 0;
		count = sqlSession.insert(namespace+"create" ,ldto);
		return count>0?true:false;
	}
	@Override
	public boolean like_check(LikeDto ldto) {
		int count=0;
		count = sqlSession.update(namespace+"like_check", ldto);
		return count>0?true:false;
	}
	@Override
	public boolean like_check_cancle(LikeDto ldto) {
		int count=0;
		count = sqlSession.update(namespace+"like_check_cancle", ldto);
		return count>0?true:false;
	}
//	@Override
//	public int read(LikeDto ldto) {		
//		return sqlSession.selectOne(namespace+"read");
//	}

	@Override
	public LikeDto read(LikeDto ldto) {
		return sqlSession.selectOne(namespace+"read", ldto);
	}
	

	
	
//	@Override
//	public List<Integer> countbyLike() {
//		return sqlSession.selectList(namespace+"countbyLike");
//	}
	
//	@Override
//	public List<Integer> countbyLike() {
//		return sqlSession.selectList(namespace+"countbyLike");
//	}
//
//	
//	@Override
//	public int create(HashMap hashMap) {
//		int count = sqlSession.insert(namespace+"create", hashMap);
//		return count;
//	}
//
//	@Override
//	public int like_check(HashMap hashMap) {
//		int count = sqlSession.update(namespace+"like_check", hashMap);
//		return count;
//	}
//
//	@Override
//	public int like_check_cancel(HashMap hashMap) {
//		int count = sqlSession.update(namespace+"like_check_cancle", hashMap);
//		return count;
//	}
//
//	@Override
//	public LikeDto read(HashMap hashMap) {
//		LikeDto ldto = sqlSession.selectOne(namespace+"read",hashMap);
//		return ldto;
//	}
//
//	@Override
//	public int deletebyB_seq(int b_seq) {
//		int count = sqlSession.delete(namespace+"deletebyB_seq", b_seq);
//		return count;
//	}
//
//	@Override
//	public boolean deletebyM_nick(String m_nick) {
//		int count = 0;
//		count = sqlSession.delete(namespace+"deletebyM_nick", m_nick);
//		return count>0?true:false;
//	}
//
//	


	

}
