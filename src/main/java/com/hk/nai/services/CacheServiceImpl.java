package com.hk.nai.services;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.nai.HomeController;
import com.hk.nai.daos.CacheDao;
import com.hk.nai.dtos.RankingDto;
import com.hk.nai.dtos.StartClassDto;

@Service
public class CacheServiceImpl implements CacheService{

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private CacheDao cachedao;
	
	@Override
	public List<RankingDto> showRanking() {
		logger.info("####ranking service####");
		return cachedao.showRanking();
	}

	@Override
	public List<StartClassDto> showStartClass() {
		logger.info("####showStartClass service####");
		return cachedao.showStartClass();
	}

}
