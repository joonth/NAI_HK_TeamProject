package com.hk.nai.daos;


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
	@Override
	public LikeDto read(LikeDto ldto) {
		return sqlSession.selectOne(namespace+"read", ldto);
	}

	@Override
	public int like_check_read(LikeDto ldto) {
		String count = sqlSession.selectOne(namespace+"like_check_read", ldto);
		return count==null?0:Integer.parseInt(count);
	}
	



	

}
