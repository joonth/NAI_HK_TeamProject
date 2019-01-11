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
	
	public int addPoint(MemberDto dto) {
		sst.update(ns+"addPoint", dto);
		return  sst.selectOne(ns+"checkPoint",dto.getId());		
	}
	public int addPoint1(MemberDto dto) {
		sst.update(ns+"addPoint1",dto);
		return sst.selectOne(ns+"checkPoint1", dto.getNickname());
	}
	public void pointCheckUp(int b_seq) {
		sst.update(ns+"pointCheckUp",b_seq);
	}
	
}

