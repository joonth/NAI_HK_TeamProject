package com.hk.nai.daos;

import java.util.HashMap;
import java.util.List;

import com.hk.nai.dtos.LikeDto;

public interface IBoardLikeDao {
	

	// 게시판의 좋아요 번호가 있는지 카운트 
	public int countbyLike(LikeDto ldto);
	// 좋아요 번호 등록 
	public boolean create(LikeDto ldto);
	// 좋아요 체크 여부 (0 -> 1)
	public boolean like_check(LikeDto ldto);
	//좋아요 체크 여부 (1 -> 0)
	public boolean like_check_cancle(LikeDto ldto);
	 /* 조회 */
	public LikeDto read(LikeDto ldto);
	//like_check값 확인
	public int like_check_read(LikeDto ldto);
	
	
	


}
