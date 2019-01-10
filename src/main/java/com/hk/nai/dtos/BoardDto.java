package com.hk.nai.dtos;

import java.io.Serializable;

import java.util.Date;

public class BoardDto implements Serializable{
	
private static final long serialVersionUID = 1L;
	
	private int b_seq;
	private String m_nick;
	private String b_title;
	private String b_content;
	private Date b_regdate;
	private int b_readcount;
	private int b_like;
	private String pagelist;
	private int like_check;
	private int cmt_count;
	private int pointcheck;
//	private String my_board;
	public BoardDto() {
		
	}
	
	
	public BoardDto(int b_seq, String m_nick) {
		super();
		this.b_seq = b_seq;
		this.m_nick = m_nick;
	}

	

	public BoardDto(int b_seq) {
		super();
		this.b_seq = b_seq;
	}


	public int getB_seq() {
		return b_seq;
	}
	public void setB_seq(int b_seq) {
		this.b_seq = b_seq;
	}
	public String getM_nick() {
		return m_nick;
	}
	public void setM_nick(String m_nick) {
		this.m_nick = m_nick;
	}
	public String getB_title() {
		return b_title;
	}
	public void setB_title(String b_title) {
		this.b_title = b_title;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
	public Date getB_regdate() {
		return b_regdate;
	}
	public void setB_regdate(Date b_regdate) {
		this.b_regdate = b_regdate;
	}
	public int getB_readcount() {
		return b_readcount;
	}
	public void setB_readcount(int b_readcount) {
		this.b_readcount = b_readcount;
	}
	
	public int getB_like() {
		return b_like;
	}
	public void setB_like(int b_like) {
		this.b_like = b_like;
	}
	public String getPagelist() {
		return pagelist;
	}
	public void setPagelist(String pagelist) {
		this.pagelist = pagelist;
	}
	
	public int getLike_check() {
		return like_check;
	}
	public void setLike_check(int like_check) {
		this.like_check = like_check;
	}
		
	public int getCmt_count() {
		return cmt_count;
	}
	public void setCmt_count(int cmt_count) {
		this.cmt_count = cmt_count;
	}


	public int getPointcheck() {
		return pointcheck;
	}


	public void setPointcheck(int pointcheck) {
		this.pointcheck = pointcheck;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	@Override
	public String toString() {
		return "BoardDto [b_seq=" + b_seq + ", m_nick=" + m_nick + ", b_title=" + b_title + ", b_content=" + b_content
				+ ", b_regdate=" + b_regdate + ", b_readcount=" + b_readcount + ", b_like=" + b_like + ", pagelist="
				+ pagelist + ", like_check=" + like_check + "]";
	}
	
	

}
