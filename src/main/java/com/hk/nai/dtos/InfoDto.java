package com.hk.nai.dtos;

import java.io.Serializable;

import org.springframework.stereotype.Component;

@Component
public class InfoDto implements Serializable {

	private String addr1;
	private String addr2;
	private String hpaddr;
	private String inonm;
	private String trprchaptel;
	private String trprnm;
	private String img;
	private Float score;
	
	public Float getScore() {
		return score;
	}
	public  InfoDto setScore(Float score) {
		this.score = score; return this;
	}
	public String getImg() {
		return img;
	}
	public  InfoDto setImg(String img) {
		this.img = img; return this;
	}

	public String getAddr1() {
		return addr1;
	}
	public  InfoDto setAddr1(String addr1) {
		this.addr1 = addr1; return this;
	}
	public String getAddr2() {
		return addr2;
	}
	public  InfoDto setAddr2(String addr2) {
		this.addr2 = addr2; return this;
	}
	public String getHpaddr() {
		return hpaddr;
	}
	public  InfoDto setHpaddr(String hpaddr) {
		this.hpaddr = hpaddr; return this;
	}
	public String getInonm() {
		return inonm;
	}
	public  InfoDto setInonm(String inonm) {
		this.inonm = inonm; return this;
	}
	public String getTrprchaptel() {
		return trprchaptel;
	}
	public  InfoDto setTrprchaptel(String trprchaptel) {
		this.trprchaptel = trprchaptel; return this;
	}
	public String getTrprnm() {
		return trprnm;
	}
	public  InfoDto setTrprnm(String trprnm) {
		this.trprnm = trprnm; return this;
	}
	
	@Override
	public String toString() {
		return "InfoDto [addr1=" + addr1 + ", addr2=" + addr2 + ", hpaddr=" + hpaddr + ", inonm=" + inonm
				+ ", trprchaptel=" + trprchaptel + ", trprnm=" + trprnm + ", img=" + img + "]";
	}
	
	
	
	
	
}
