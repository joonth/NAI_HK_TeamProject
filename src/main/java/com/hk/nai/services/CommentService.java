package com.hk.nai.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hk.nai.daos.CommentDao;
import com.hk.nai.dtos.MemberDto;
import com.hk.nai.dtos.commentDto;

@Service
public class CommentService {

	@Autowired
	CommentDao dao;
	
	@Transactional
	public void addComment(commentDto dto) {
		MemberDto mdto = new MemberDto();
		mdto.setId(dto.getM_id());
		mdto.setWriteCheck("Y");
		dao.addComment(dto);
		dao.updateCheck(mdto);
	}
	
	@Transactional
	public void deleteComment(String m_id) {
		MemberDto mdto = new MemberDto();
		mdto.setId(m_id);
		mdto.setWriteCheck("N");
		dao.deleteComment(m_id);
		dao.updateCheck(mdto);
	}
	
}
