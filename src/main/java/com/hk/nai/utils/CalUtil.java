package com.hk.nai.utils;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.util.List;

import org.slf4j.spi.MDCAdapter;

import com.hk.nai.dtos.CalDto;

public class CalUtil {
	
	//action 태그에 usebean태그는 객체를 담고 가져오는 기능을 구현--> dto객체
	private String toDates;
	
	public static String getCalViewList(int i, List<CalDto> clist) {
		String day=(i+"").substring(8, 10);
		String calList=""; 
		for(CalDto calDto : clist) {
			if(calDto.getAc_cre_date().subSequence(6, 8).equals(day)) {
				calList+="<p>"
						+(calDto.getAc_name().length()>6?calDto.getAc_name()
								.substring(0, 5)+"..":calDto.getAc_name())
							+"</p>";
			}	
		}
		return calList;
	}
	//DB에서 받아온 varchar2타입 ac_cre_date(개강일)을 jsp에서 쓸수 있게 DByear,DBmonth,DBday로 쪼개기
	public void setToDates(String ac_cre_date, String m) {
		//날짜형식: yyyy-MM-dd
		int DByear=Integer.parseInt(ac_cre_date.substring(0, 4));
		int DBmonth=Integer.parseInt(ac_cre_date.substring(6, 8));
		int DBday=Integer.parseInt(ac_cre_date.substring(8, 10));
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy년MM월dd일 ");
		Timestamp tm=Timestamp.valueOf(m);//문자열을 Date타입으로 변환
		this.toDates=sdf.format(tm);
	}
	
	//한자릿수를 두자릿수로 반환하는 기능
		public static String isTwo(String msg) {
			return msg.length()<2?"0"+msg:msg;// "3"---> "03"
		}

	public String getToDates() {
		return toDates;
	}
	
	//토, 일 폰트색상 지정
	public static String fontColor(int date, int dayOfWeek) {
		// 해당일과 공백수 합친 다음 % 7 ==0 -> 토 , ==1 -> 일
		String color = "";
		if((dayOfWeek-1+date)%7==0)
			color = "blue";
		else if((dayOfWeek-1+date)%7==1)
			color = "red";
		else
			color="black";
		return color;
	}
}
