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
			
	//학원 상세조회
	@Override
	public CalDto getCalDetail(int ac_seq) {
		return sqlSession.selectOne(namespace+"getCalDetail", ac_seq);
	}
	
	



}
