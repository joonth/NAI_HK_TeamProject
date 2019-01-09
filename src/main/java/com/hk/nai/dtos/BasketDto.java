package com.hk.nai.dtos;

public class BasketDto {
	private int baskSeq;
	private String baskId;
	private String baskAcademyName;

	public BasketDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BasketDto(int baskSeq, String baskId, String baskAcademyName) {
		super();
		this.baskSeq = baskSeq;
		this.baskId = baskId;
		this.baskAcademyName = baskAcademyName;
	}
	public int getBaskSeq() {
		return baskSeq;
	}
	public void setBaskSeq(int baskSeq) {
		this.baskSeq = baskSeq;
	}
	public String getBaskId() {
		return baskId;
	}
	public void setBaskId(String baskId) {
		this.baskId = baskId;
	}
	public String getBaskAcademyName() {
		return baskAcademyName;
	}
	public void setBaskAcademyName(String baskAcademyName) {
		this.baskAcademyName = baskAcademyName;
	}
	@Override
	public String toString() {
		return "BasketDto [baskSeq=" + baskSeq + ", baskId=" + baskId + ", baskAcademyName=" + baskAcademyName + "]";
	}

}
