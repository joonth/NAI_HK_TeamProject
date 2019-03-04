package com.hk.nai.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hk.nai.daos.DataHandleDao;
import com.hk.nai.dtos.AcInfoDto;

@Service
public class DataHandleService {

	@Autowired
	DataHandleDao dao;
	
	// 기존 학원 data delete , 갱신된 data insert
	@Transactional
	public void insUpToDateData(List<AcInfoDto> list) {
		dao.delOutOfDateData();
		for(AcInfoDto dto : list) {
			dao.insUpToDateData(dto);			
		}
	}
	
	// DB에 있는 학원의 수 구하기.
	public int getAcClassNum() {
		return dao.getAcClassNum();
	}
}
