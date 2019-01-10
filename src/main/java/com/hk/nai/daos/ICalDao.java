package com.hk.nai.daos;

import java.util.HashMap;
import java.util.List;

import com.hk.nai.dtos.CalDto;

public interface ICalDao {
	public List<CalDto> getCalList();
	public List<CalDto> getCalRk();
	public List<CalDto> getCartAcademy(String ac_name);
	public CalDto getCalAcImg(String ac_name);
	public CalDto getCalDetail(CalDto dto);
	
}
