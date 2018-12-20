package com.hk.nai.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.nai.daos.InfoDao;
import com.hk.nai.dtos.commentDto;

@Service
public class InfoService {

	@Autowired
	InfoDao dao;
	
	public List<commentDto> getComment(String subTitle) {
		return dao.getComment(subTitle);
	}
	
}
