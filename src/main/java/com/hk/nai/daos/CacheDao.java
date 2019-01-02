package com.hk.nai.daos;

import java.util.List;

import com.hk.nai.dtos.RankingDto;
import com.hk.nai.dtos.StartClassDto;

public interface CacheDao {
	public List<RankingDto> showRanking();
	public List<StartClassDto> showStartClass();
}
