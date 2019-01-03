package com.hk.nai.utils;

import org.jsoup.select.Elements;
import org.springframework.stereotype.Component;

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
}
