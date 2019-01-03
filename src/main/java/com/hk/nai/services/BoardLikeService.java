package com.hk.nai.services;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.nai.daos.BoardLikeDao;
import com.hk.nai.daos.IBoardLikeDao;
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

	
	
//	@Override
//	public int read(LikeDto ldto) {
//		System.out.println(boardLikeDao.read(ldto));
//		return boardLikeDao.read(ldto);
//	}

	
	
//	@Override
//	public List<Integer> countbyLike() {
//		return boardLikeService.countbyLike();
//	}

	
//	@Override
//	public List<Integer> countbyLike() {
//		return boardLikeService.countbyLike();
//	}
//
//
//	@Override
//	public int create(HashMap hashMap) {
//		int count = boardLikeService.create(hashMap);
//		return count;
//	}
//
//	@Override
//	public int like_check(HashMap hashMap) {
//		int count = boardLikeService.like_check(hashMap);
//		return count;
//	}
//
//	@Override
//	public int like_check_cancel(HashMap hashMap) {
//		int count = boardLikeService.like_check_cancel(hashMap);
//		return count;
//	}
//
//	@Override
//	public LikeDto read(HashMap hashMap) {
//		System.out.println("$$");
//		LikeDto ldto = boardLikeService.read(hashMap);
//		return ldto;
//	}
//
//	@Override
//	public int deletebyB_seq(int b_seq) {
//		int count = boardLikeService.deletebyB_seq(b_seq);
//		return count;
//	}
//
//	@Override
//	public boolean deletebyM_nick(String m_nick) {
//		return boardLikeService.deletebyM_nick(m_nick);
//	}
//
//	
	

}
