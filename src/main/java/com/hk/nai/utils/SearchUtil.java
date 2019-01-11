package com.hk.nai.utils;



import java.util.Calendar;

import org.jsoup.select.Elements;
import org.springframework.stereotype.Component;

import com.hk.nai.dtos.AcInfoDto;


@Component
public class SearchUtil {
	
	public String tagTrim(Elements text,String tagName) {
		String tmpText = text.toString();
		String result = "";
		if(tmpText.equals("")) {
			return result;
		}
		return tmpText.substring(tmpText.indexOf("<"+tagName+">")+tagName.length()+2, tmpText.indexOf("</"+tagName+">")).trim();
		//return result;
	}
	
	public String tagTrim_str(String text,String tagName) {
		String result = "";
		if(text.equals("")) {
			return result;
		}
		return text.substring(text.indexOf("<"+tagName+">")+tagName.length()+2, text.indexOf("</"+tagName+">")).trim();
	}
	
	public long trimDday(AcInfoDto acInfoDto) {
	
		Calendar c1 = Calendar.getInstance();
		long today = c1.getTimeInMillis();
		String[] strdate =acInfoDto.getTrastartdate().split("-");
		 c1.set(Integer.parseInt(strdate[0]), Integer.parseInt(strdate[1])-1, Integer.parseInt(strdate[2]));
		 long eventDay = c1.getTimeInMillis();
		 long dday = (eventDay-today)/(60*60*24*1000);
		 return dday;
	}
}
