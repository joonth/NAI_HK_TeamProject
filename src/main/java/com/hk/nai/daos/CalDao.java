package com.hk.nai.daos;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.nai.dtos.CalDto;

@Repository
public class CalDao implements ICalDao{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private String namespace="com.hk.nai.";
	
	//달력에 평점 3순위의 학원명을 3개까지 출력하기
	@Override
	public List<CalDto> getCalList(){
		return sqlSession.selectList(namespace+"getCalList");
	}
	
	//학원 일별랭킹
	@Override
	public List<CalDto> getCalRk() {
		return sqlSession.selectList(namespace+"getCalRK");
	}
			
	//찜한학원 강좌 가져오기
	public List<CalDto> getCartAcademy(String ac_name){
		return sqlSession.selectList(namespace+"getCartAcademy", ac_name);
	}
	
	@Override
	public CalDto getCalDetail(CalDto dto) {
		return sqlSession.selectOne(namespace+"getCalDetail", dto);
	}
	
	//학원 이미지 가져오기
	public CalDto getCalAcImg(String ac_name) {
		return sqlSession.selectOne(namespace+"getCalAcImg", ac_name);
	}






	
	



}
