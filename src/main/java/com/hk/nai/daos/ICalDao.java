package com.hk.nai.daos;

import java.util.List;

import com.hk.nai.dtos.CalDto;

public interface ICalDao {
	public List<CalDto> getCalList();
	public List<CalDto> getCalRk();
	public CalDto getCalDetail(int ac_seq);
	
	
}
