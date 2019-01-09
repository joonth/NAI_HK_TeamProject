package com.hk.nai.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.hk.nai.daos.IBoardDao;
import com.hk.nai.dtos.BoardDto;
import com.hk.nai.dtos.CommentDto1;

@Service
public class BoardService implements IBoardService {
	
	@Autowired
	private IBoardDao boardDao;
	
	//------------------------게시판--------------------------	
		@Override
		public List<BoardDto> getAllList() {
			return boardDao.getAllList();
		}

		@Override
		public boolean insertBoard(BoardDto dto) {
			return boardDao.insertBoard(dto);
		}

		@Override
		public BoardDto getBoard(BoardDto dto) {
			return boardDao.getBoard(dto);
		}

		@Override
		public boolean updateBoard(BoardDto dto) {
			return boardDao.updateBoard(dto);
		}

		@Override
		public boolean b_readCount(int b_seq) {
			return boardDao.b_readCount(b_seq);
		}

		@Override
		public boolean b_like_up(int b_seq) {
			return boardDao.b_like_up(b_seq);
		}

		@Override
		public boolean b_like_down(int b_seq) {
			return boardDao.b_like_down(b_seq);
		}
		
		@Override
		public boolean delBoard(int b_seq) {
			return boardDao.delBoard(b_seq);
		}
		
	//---------------------------페이징------------------------------------
		@Override
		public List<BoardDto> listCriteria(String page) throws Exception {
			return boardDao.listCriteria(page);
		}
		@Override
		public List<BoardDto> listCriteria1(String page) throws Exception {
			return boardDao.listCriteria1(page);
		}
		@Override
		public List<BoardDto> listCriteria2(String page) throws Exception {
			return boardDao.listCriteria2(page);
		}		
	//------------------게시글 전체 수 구하기---------------------------------

		@Override
		public Integer totalCount() throws Exception {
			return boardDao.TotalCount();
		}
	//-----------------------------댓글------------------------------------
		@Override
		public List<CommentDto1> commentList(int b_seq) {
			return boardDao.commentList(b_seq);
		}

		@Override
		public boolean insertComment(CommentDto1 dto) {
			return boardDao.insertComment(dto);
		}

		@Override
		public boolean replyBoardUpdate(CommentDto1 dto) {
			return boardDao.replyBoardUpdate(dto);
		}

		@Override
		public boolean delComment(int r_seq) {
			return boardDao.delComment(r_seq);
		}

		@Override
		public CommentDto1 readComment(int r_seq) {
			return boardDao.readComment(r_seq);
		}


		@Override
		public boolean upComment(int b_seq) {
			return boardDao.upComment(b_seq);
		}

		@Override
		public boolean downComment(int b_seq) {
			return boardDao.downComment(b_seq);
		}

		
		

		

}
