package com.hk.nai.services;


import com.hk.nai.dtos.LikeDto;

public interface IBoardLikeService {
	

	


	
	public int countbyLike(LikeDto ldto);
	
	public boolean create(LikeDto ldto);
	
	public boolean like_check(LikeDto ldto);
	
	public boolean like_check_cancle(LikeDto ldto);
	 	
	public LikeDto read(LikeDto ldto);
	
	public int like_check_read(LikeDto ldto);
	
	


}
