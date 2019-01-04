package com.hk.nai.services;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.nai.daos.BoardLikeDao;
import com.hk.nai.dtos.LikeDto;

@Service
public class BoardLikeService implements IBoardLikeService{

	@Autowired
	private BoardLikeDao boardLikeDao;


	@Override
	public int countbyLike(LikeDto ldto) {
		int count = boardLikeDao.countbyLike(ldto);		
		return count;
	}
	@Override
	public boolean create(LikeDto ldto) {
		return boardLikeDao.create(ldto);
	}

	@Override
	public boolean like_check(LikeDto ldto) {
		return boardLikeDao.like_check(ldto);
	}

	@Override
	public boolean like_check_cancle(LikeDto ldto) {
		return boardLikeDao.like_check_cancle(ldto);
	}
	@Override
	public LikeDto read(LikeDto ldto) {
		return boardLikeDao.read(ldto);
	}
	@Override
	public int like_check_read(LikeDto ldto) {
		int count = boardLikeDao.like_check_read(ldto);
		return count;
	}

	
	

	

}
