package com.hk.nai.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.nai.daos.SearchDao;
import com.hk.nai.dtos.BasketDto;
import com.hk.nai.dtos.MemberDto;
import com.hk.nai.dtos.AcInfoDto;

@Service
public class SearchService {
	
	@Autowired
	SearchDao dao;
	
	public Float getScore(String subTitle) {
		List<Integer> list = new ArrayList<Integer>();
		list = dao.getScore(subTitle);
		Float answer = 0f;
		if(list.size()==0) {
			return 0f;
		}else {
			for(int score : list) {
				answer += score;
			}
			return (float) (Math.round((answer/list.size())*100)/100.0);
		}
	}

	
	public String getImg(String subtitle) {
		return dao.getImg(subtitle);	
	}
	
	// 모든 회원 가져오기 : message 보내는 관리자 페이지
	public List<MemberDto> getMemberList(){
		return dao.getMemberList();
	}
	
	public void addImgToDb(AcInfoDto dto) {
		dao.addImgToDb(dto);
	}
	
	public void putBasket(BasketDto dto) {
		dao.putBasket(dto);
	}
	
	// 해당 학원을 찜한 id 구하기
	public List<BasketDto> getBasketMname(String AC_NAME){
		return dao.getBasketMname(AC_NAME);
	}
}
