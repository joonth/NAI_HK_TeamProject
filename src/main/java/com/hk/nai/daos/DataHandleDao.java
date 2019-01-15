package com.hk.nai.daos;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.nai.dtos.AcInfoDto;

@Repository
public class DataHandleDao {

	@Autowired
	private SqlSessionTemplate sst;
	private String ns = "com.hk.nai.";
	
	public void delOutOfDateData() {
		sst.delete(ns+"delOutOfDateData");
	}
	
	public void insUpToDateData(AcInfoDto dto) {
		sst.insert(ns+"insUpToDateData", dto);
	}
	
	public int getAcClassNum() {
		return sst.selectOne(ns+"getAcClassNum");
	}
	
}
