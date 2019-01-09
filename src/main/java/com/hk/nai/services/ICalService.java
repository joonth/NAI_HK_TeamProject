package com.hk.nai.services;

import java.util.HashMap;
import java.util.List;

import com.hk.nai.dtos.CalDto;

public interface ICalService {
	
	public List<CalDto> getCalList();
	public List<CalDto> getCalRk();
	public List<CalDto> getCartAcademy(String ac_name);
	public CalDto getCalAcImg(String ac_name);
	public CalDto getCalDetail(CalDto dto);


}
