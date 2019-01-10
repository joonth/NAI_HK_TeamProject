package com.hk.nai.services;

import java.util.List;


import com.hk.nai.dtos.BoardDto;
import com.hk.nai.dtos.CommentDto1;


public interface IBoardService {
	
	//---------------------게시판---------------------
		public List<BoardDto> getAllList();
		
		public boolean insertBoard(BoardDto dto);
		
		public BoardDto getBoard(BoardDto dto);
		
		public boolean updateBoard(BoardDto dto);
		
		public boolean b_readCount(int b_seq);
		
		public boolean b_like_up(int b_seq);
		
		public boolean b_like_down(int b_seq);
		
		public boolean delBoard(int b_seq);
		
		public int getB_like(int b_seq);
		// ---------------페이징 처리 서비스 메서드----------------------
	    public List<BoardDto> listCriteria(String page) throws Exception;//최신순
		public List<BoardDto> listCriteria1(String page) throws Exception;//조회순
		public List<BoardDto> listCriteria2(String page) throws Exception;//추천순
	    // 전체 게시글 수 구하기
	    public Integer totalCount() throws Exception;
	//-----------------------댓글--------------------------    
	  //댓글목록
	  	public List<CommentDto1> commentList(int b_seq);
	  		
	  	//댓글작성
	  	public boolean insertComment(CommentDto1 dto);
	  		
	  	//댓글수정
	  	public boolean replyBoardUpdate(CommentDto1 dto);
	  		
	  	//댓글삭제
	  	public boolean delComment(int r_seq);

	  	//댓글보기
	  	public CommentDto1 readComment(int r_seq);


	  	//댓글개수 증가
	  	public boolean upComment(int b_seq);
	  	
	  	//댓글개수 감소
	  	public boolean downComment(int b_seq);
}
