package com.hk.nai.dtos;

import java.io.Serializable;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component
public class AcInfoDto implements Serializable ,Comparable<AcInfoDto> {
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
	public AcInfoDto setDday(long dday) {
		this.dday = dday; return this;
	}
	public String getTrastartdate() {
		return trastartdate;
	}
	public AcInfoDto setTrastartdate(String trastartdate) {
		this.trastartdate = trastartdate; return this;
	}
	public String getTrprId() {
		return trprId;
	}
	public AcInfoDto setTrprId(String trprId) {
		this.trprId = trprId; return this;
	}
	private String trprId;
	
	public Float getScore() {
		return score;
	}
	public AcInfoDto setScore(Float score) {
		this.score = score; return this;
	}
	public String getImg() {
		return img;
	}
	public AcInfoDto setImg(String img) {
		this.img = img; return this;
	}
	public String getTitle() {
		return title;
	}
	public AcInfoDto setTitle(String title) {
		this.title = title; return this;
	}
	public String getSubTitle() {
		return subTitle;
	}
	public AcInfoDto setSubTitle(String subTitle) {
		this.subTitle = subTitle; return this;
	}
	public String getAddress() {
		return address;
	}
	public AcInfoDto setAddress(String address) {
		this.address = address; return this;
	}
	
	
	@Override
	public int compareTo(AcInfoDto d1) {
		if(d1.getDday() > dday) {
			return -1;
		}else if(d1.getDday() < dday) {
			return 1;
		}else {
			return 0;
		}
	}
	@Override
	public String toString() {
		return "AcInfoDto [img=" + img + ", title=" + title + ", subTitle=" + subTitle + ", address=" + address
				+ ", score=" + score + ", trastartdate=" + trastartdate + ", dday=" + dday + ", trprId=" + trprId + "]";
	}

	

	
}
