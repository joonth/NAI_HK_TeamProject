package com.hk.nai.services;

import java.util.List;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.nai.daos.ICalDao;
import com.hk.nai.dtos.CalDto;


@Service
public class CalService implements ICalService{

	@Autowired
	private ICalDao calDao;

	@Override
	public List<CalDto> getCalList() {
		return calDao.getCalList();
	}
	
	@Override
	public List<CalDto> getCalRk(){
		return calDao.getCalRk();
	}

	@Override
	public CalDto getCalDetail(int ac_seq) {
		return calDao.getCalDetail(ac_seq);
	}
	
}
