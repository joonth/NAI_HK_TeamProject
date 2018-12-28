package com.hk.nai.daos;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import com.hk.nai.HomeController;
import com.hk.nai.dtos.RankingDto;
import com.hk.nai.dtos.StartClassDto;

@Repository
public class CacheDaoImpl implements CacheDao{
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private SqlSessionTemplate sqlSession;
	private String namespace = "com.hk.nai.";
	
	@Cacheable(value="rankingCache")
	@Override
	public List<RankingDto> showRanking() {
		// 캐시가 존재할 경우 이 로직은 실행되지 않고 캐시가 바로 반환
		logger.info("####check ##ranking## cache process####");
		return sqlSession.selectList(namespace+"ranking");
	}

	@Cacheable(value="startClassCache")
	@Override
	public List<StartClassDto> showStartClass() {
		logger.info("####check ##startclass## cache process####");
		return sqlSession.selectList(namespace+"startclass");
	}

}
