package com.hk.nai.dtos;

import org.springframework.stereotype.Component;

@Component
public class AddImgDto {
	
	private String ac_name;
	private String img;
	
	public String getAc_name() {
		return ac_name;
	}
	public AddImgDto setAc_name(String ac_name) {
		this.ac_name = ac_name; return this;
	}
	public String getImg() {
		return img;
	}
	public AddImgDto setImg(String img) {
		this.img = img; return this;
	}
	
	@Override
	public String toString() {
		return "AddImgDto [ac_name=" + ac_name + ", img=" + img + "]";
	}
	
	
}
