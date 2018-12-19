package com.hk.nai.services;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.nai.daos.MemberDao;
import com.hk.nai.dtos.AuthDto;
import com.hk.nai.dtos.MemberDto;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDao memdao;
	
	@Override
	public boolean signupMember(MemberDto member, String academyName) {
		System.out.println("다른서비스:" + memdao);
		boolean isS = memdao.insertMember(member);
		String grade = member.getGrade();
		System.out.println("isS: " + isS + " grade: " + grade);
		
		if(isS==true && grade.equals("B")) { //인증된 학원생
			String id = member.getId();

			//auth 테이블에도 추가
			boolean isS2 = memdao.insertAuth(new AuthDto().setAuthId(id).setAcademyName(academyName));
			
			if(isS2==true) {
				return true;
			}
			return false;
			
		} else if (isS==true && grade.equals("C")) { //일반인
			return true;
		}
		return false;
	}

	@Override
	public boolean checkIdMember(String id) {
		// TODO Auto-generated method stub
		String checkId = memdao.checkId(id);
		if(checkId != null) return false;
		return true;
	}

	@Override
	public boolean checkNicknameMember(String nickname) {
		String checkNickname = memdao.checkNickname(nickname);
		if(checkNickname != null) return false;
		return true;
	}

	@Override
	public boolean checkEmailMember(String email) {
		String checkEmail = memdao.checkEmail(email);
		if(checkEmail != null) return false;
		return true;
	}

	@Override
	public MemberDto signin(String id, String pw) {
		MemberDto member = memdao.signIn(id);
		if(member == null || !member.getPw().equals(pw)) {
			return null;	
		}
		else{
			return member;
		}
	}
	
	@Override
	public boolean signout(HttpServletResponse response) {
		// TODO Auto-generated method stub
		return false;
	}
	
	@Override
	public String findId(String email) {
		String id = memdao.findId(email);
		
		if( id != null) {
			StringBuilder sb = new StringBuilder(id);
			for(int i=3; i<sb.length(); i++) {
				sb.setCharAt(i, '*');
			}
			return sb.toString();
		}
		return null;
	}

	@Override
	public String findPw(MemberDto member) {
		return memdao.findPw(member);
	}

	@Override
	public boolean tempPw(MemberDto member) {
		return memdao.tempPw(member);
	}

/*	마이페이지  */
	@Override
	public MemberDto showMyInfo(String id) {
		return memdao.showMyInfo(id);
	}
	
	@Override
	public AuthDto showAuthInfo(String id) {
		return memdao.showAuthInfo(id);
	}
	@Override
	public boolean updatePw(MemberDto member) {
		return memdao.updatePw(member);
	}

	@Override
	public boolean updateNickname(MemberDto member) {
		return memdao.updateNickname(member);
	}

	@Override
	public boolean updateEmail(MemberDto member) {
		return memdao.updateEmail(member);
	}
	
	@Override
	public boolean updateAuth(AuthDto authdto) {
		return memdao.updateAuth(authdto);
	}
	
	@Override
	public boolean deleteMyInfo(MemberDto member) {
		return memdao.deleteMyInfo(member);
	}






	

}
