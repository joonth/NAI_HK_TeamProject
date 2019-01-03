package com.hk.nai.dtos;

public class StartClassDto {
	private String startAcademyName;
	private String startClassName;
	private String startDDay;
	public StartClassDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getStartAcademyName() {
		return startAcademyName;
	}
	public void setStartAcademyName(String startAcademyName) {
		this.startAcademyName = startAcademyName;
	}
	public String getStartClassName() {
		return startClassName;
	}
	public void setStartClassName(String startClassName) {
		this.startClassName = startClassName;
	}
	public String getStartDDay() {
		return startDDay;
	}
	public void setStartDDay(String startDDay) {
		this.startDDay = startDDay;
	}
	@Override
	public String toString() {
		return "StartClassDto [startAcademyName=" + startAcademyName + ", startClassName=" + startClassName
				+ ", startDDay=" + startDDay + "]";
	}
	
}
