package com.hk.nai.services;

import java.util.HashMap;
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
	public CalDto getCalDetail(CalDto dto) {
		return calDao.getCalDetail(dto);
	}
	
	
	@Override
	public List<CalDto> getCartAcademy(String ac_name) {
		return calDao.getCartAcademy(ac_name);
	}
	
	@Override
	public CalDto getCalAcImg(String ac_name) {
		return calDao.getCalAcImg(ac_name);
	
	}

	
}
