package com.hk.nai.services;

import java.util.List;

import com.hk.nai.dtos.CalDto;

public interface ICalService {
	
	public List<CalDto> getCalList();
	public List<CalDto> getCalRk();
	public CalDto getCalDetail(int ac_seq);


}
