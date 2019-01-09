package com.hk.nai.daos;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.nai.dtos.MemberDto;
import com.hk.nai.dtos.commentDto;

@Repository
public class CommentDao {

	@Autowired
	private SqlSessionTemplate sst;
	private String ns = "com.hk.nai.";
	
	public void addComment(commentDto dto) {
		sst.insert(ns+"addComment", dto);
	}
	
	public void deleteComment(String m_id) {
		sst.delete(ns+"deleteComment", m_id);
	}
	
	public void updateCheck(MemberDto dto) {
		sst.update(ns+"updateCheck", dto);
	}
	
}
