package com.hk.nai.dtos;

import org.springframework.stereotype.Component;

@Component
public class AuthDto {
	private String academyName;
	private String authId;
	
	public AuthDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AuthDto(String academyName, String authId) {
		super();
		this.academyName = academyName;
		this.authId = authId;
	}

	public String getAcademyName() {
		return academyName;
	}

	public AuthDto setAcademyName(String academyName) {
		this.academyName = academyName;
		return this;
	}

	public String getAuthId() {
		return authId;
	}

	public AuthDto setAuthId(String authId) {
		this.authId = authId;
		return this;
	}

	@Override
	public String toString() {
		return "AuthDto [academyName=" + academyName + ", authId=" + authId + "]";
	}
	
	
}
