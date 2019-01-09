package com.hk.nai.dtos;

import java.io.Serializable;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component
public class SearchDto implements Serializable ,Comparable<SearchDto> {
	private String img;
	private String title;
	private String subTitle;
	private String address;
	private Float score;
	private String trastartdate;
	private long dday;
	
	public long getDday() {
		return dday;
	}
	public void setDday(long dday) {
		this.dday = dday;
	}
	public String getTrastartdate() {
		return trastartdate;
	}
	public void setTrastartdate(String trastartdate) {
		this.trastartdate = trastartdate;
	}
	public String getTrprId() {
		return trprId;
	}
	public void setTrprId(String trprId) {
		this.trprId = trprId;
	}
	private String trprId;
	
	public Float getScore() {
		return score;
	}
	public void setScore(Float score) {
		this.score = score;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSubTitle() {
		return subTitle;
	}
	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	@Override
	public String toString() {
		return "SearchDto [img=" + img + ", title=" + title + ", subTitle=" + subTitle + ", address=" + address
				+ ", score=" + score + ", trprId=" + trprId + "]";
	}
	
	@Override
	public int compareTo(SearchDto d1) {
		if(d1.getDday() > dday) {
			return -1;
		}else if(d1.getDday() < dday) {
			return 1;
		}else {
			return 0;
		}
	}

	

	
}
