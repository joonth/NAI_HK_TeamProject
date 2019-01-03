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
//	public int read(LikeDto ldto);
	public LikeDto read(LikeDto ldto);
	
	
	
	
//	public List<Integer> countbyLike();

//	public List<Integer> countbyLike();
	  
	  
//	  public int create(HashMap hashMap);
	  
	  
	  	   
//	  public int like_check(HashMap hashMap);
	  
	  
	  	  
//	  public int like_check_cancel(HashMap hashMap);
	  
	 
//	  public LikeDto read(HashMap hashMap);
	  
	  //게시판 좋아요 삭제
//	  public int deletebyB_seq(int b_seq);
	  
	  /* 회원의 좋아요 삭제 */
//	  public boolean deletebyM_nick(String m_nick);

}
