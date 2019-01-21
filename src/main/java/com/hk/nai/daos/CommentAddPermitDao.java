package com.hk.nai.daos;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.hk.nai.dtos.AuthDto;
import com.hk.nai.dtos.commentDto;


@Repository
public class CommentAddPermitDao {
	
	@Autowired
	private SqlSessionTemplate sst;
	private String ns = "com.hk.nai.";
	
	public List<AuthDto> checkAuth() {
		return sst.selectList(ns+"checkAuth");
	}
	
	public String checkDupe(String id) {
		return sst.selectOne(ns+"checkDupe", id);
	}
	
}
