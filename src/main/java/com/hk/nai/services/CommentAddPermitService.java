package com.hk.nai.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.nai.daos.CommentAddPermitDao;
import com.hk.nai.dtos.AuthDto;
import com.hk.nai.dtos.commentDto;



@Service
public class CommentAddPermitService {

	@Autowired
	CommentAddPermitDao dao;
	
	List<AuthDto> list = new ArrayList<AuthDto>(); 
	
	public boolean getAuth(String subTitle, String m_id) {
		list =dao.checkAuth();
		for(AuthDto dto : list) {
			//본인이 등록된 학원에만 학원평 작성가능
			if(dto.getAcademyName().equals(subTitle) && dto.getAuthId().equals(m_id)) {
				return true;
			}
		}
		return false;
	}
	
	public boolean checkDupe(String id) {
		String mCheck  = dao.checkDupe(id);
		if(mCheck.equals("N")) {
			return true;
		}else {
			return false;
		}
	}
	
}
