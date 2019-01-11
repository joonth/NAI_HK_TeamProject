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
	public SearchDto setDday(long dday) {
		this.dday = dday; return this;
	}
	public String getTrastartdate() {
		return trastartdate;
	}
	public SearchDto setTrastartdate(String trastartdate) {
		this.trastartdate = trastartdate; return this;
	}
	public String getTrprId() {
		return trprId;
	}
	public SearchDto setTrprId(String trprId) {
		this.trprId = trprId; return this;
	}
	private String trprId;
	
	public Float getScore() {
		return score;
	}
	public SearchDto setScore(Float score) {
		this.score = score; return this;
	}
	public String getImg() {
		return img;
	}
	public SearchDto setImg(String img) {
		this.img = img; return this;
	}
	public String getTitle() {
		return title;
	}
	public SearchDto setTitle(String title) {
		this.title = title; return this;
	}
	public String getSubTitle() {
		return subTitle;
	}
	public SearchDto setSubTitle(String subTitle) {
		this.subTitle = subTitle; return this;
	}
	public String getAddress() {
		return address;
	}
	public SearchDto setAddress(String address) {
		this.address = address; return this;
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
