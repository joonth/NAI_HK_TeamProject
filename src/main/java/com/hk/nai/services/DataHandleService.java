package com.hk.nai.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.nai.daos.DataHandleDao;
import com.hk.nai.dtos.AcInfoDto;

@Service
public class DataHandleService {

	@Autowired
	DataHandleDao dao;
	
	public void delOutOfDateData() {
		dao.delOutOfDateData();
	}
	
	public void insUpToDateData(List<AcInfoDto> list) {
		for(AcInfoDto dto : list) {
			dao.insUpToDateData(dto);			
		}
	}
	
	public int getAcClassNum() {
		return dao.getAcClassNum();
	}
}
