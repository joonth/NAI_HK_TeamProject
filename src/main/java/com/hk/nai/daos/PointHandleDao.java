package com.hk.nai.daos;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.nai.dtos.BoardDto;
import com.hk.nai.dtos.MemberDto;

@Repository
public class PointHandleDao {

	@Autowired
	SqlSessionTemplate sst;
	
	String ns = "com.hk.nai.";
	
	// ID로 포인트 추가
	public int addPoint(MemberDto dto) {
		sst.update(ns+"addPoint", dto);
		return  sst.selectOne(ns+"checkPoint",dto.getId());		
	}
	
	// Nickname으로 포인트 추가
	public int addPoint1(MemberDto dto) {
		sst.update(ns+"addPoint1",dto);
		return sst.selectOne(ns+"checkPoint1", dto.getNickname());
	}
	
	// 포인트를 추가한 게시글 
	public void pointCheckUp(int b_seq) {
		sst.update(ns+"pointCheckUp",b_seq);
	}
	
}

