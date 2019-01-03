package com.hk.nai.services;

import java.util.HashMap;
import java.util.List;

import com.hk.nai.dtos.LikeDto;

public interface IBoardLikeService {
	

	


	
	public int countbyLike(LikeDto ldto);
	
	public boolean create(LikeDto ldto);
	
	public boolean like_check(LikeDto ldto);
	
	public boolean like_check_cancle(LikeDto ldto);
	
//	public int read(LikeDto ldto);	 
	
	public LikeDto read(LikeDto ldto);
	
	
	
		// 게시판의 좋아요 번호가 있는지 카운트 
//	  public int countbyLike(LikeDto lldto);
//		public List<Integer> countbyLike();

	
	  
	  // 좋아요 번호 등록 
//	  public int create(HashMap hashMap);
	  	 
	  //좋아요 체크 여부 (0 -> 1)	   
//	  public int like_check(HashMap hashMap);
	 
	  //좋아요 체크 여부 (1 -> 0)	  
//	  public int like_check_cancel(HashMap hashMap);
	  
	  //조회 
//	  public LikeDto read(HashMap hashMap);
	 
	  /* 게시판의 좋아요 삭제 */
//	  public int deletebyB_seq(int b_seq);
	  
	  /* 회원의 좋아요 삭제 */
//	  public boolean deletebyM_nick(String m_nick);

}
