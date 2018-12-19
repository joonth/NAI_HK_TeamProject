package com.hk.nai.dtos;

public class MemberDto {
	private int seq;
	private String id;
	private String pw;
	private String nickname;
	private String email;
	private String grade;
	private int point;
	private String writeCheck;
	
	public MemberDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MemberDto(String id, String email) {
		super();
		this.id = id;
		this.email = email;
	}

	public MemberDto(int seq, String id, String pw, String nickname, String email, String grade, int point,
			String writeCheck) {
		this.seq = seq;
		this.id = id;
		this.pw = pw;
		this.nickname = nickname;
		this.email = email;
		this.grade = grade;
		this.point = point;
		this.writeCheck = writeCheck;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getWriteCheck() {
		return writeCheck;
	}

	public void setWriteCheck(String writeCheck) {
		this.writeCheck = writeCheck;
	}

	@Override
	public String toString() {
		return "MemberDto [seq=" + seq + ", id=" + id + ", pw=" + pw + ", nickname=" + nickname + ", email=" + email
				+ ", grade=" + grade + ", point=" + point + ", writeCheck=" + writeCheck + "]";
	}
	
	
	
}
