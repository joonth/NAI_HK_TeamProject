package com.hk.nai.services;

import java.util.List;

import com.hk.nai.dtos.RankingDto;
import com.hk.nai.dtos.StartClassDto;

public interface CacheService {
	public List<RankingDto> showRanking();
	public List<StartClassDto> showStartClass();
}
