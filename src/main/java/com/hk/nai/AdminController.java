package com.hk.nai;

import java.text.DateFormat;


import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.hk.nai.daos.AdminDaoImpl;
import com.hk.nai.dtos.MemberDto;

/**
 * Handles requests for the application home page.
 */
@Controller
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private com.hk.nai.services.AdminService adminService;
	
	/*private BoardServiceImpl boardService;*/
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	//회원목록페이지
	@RequestMapping(value = "/userList.do", method = RequestMethod.GET)
	public String UserList(Locale locale, Model model) {
		logger.info("유저목록", locale);	
		List<MemberDto> getUserList = adminService.getUserList();
		model.addAttribute("getUserList", getUserList);
		return "userList";
	}

	//회원 상세보기페이지
	@RequestMapping(value = "/userDetail.do", method = RequestMethod.GET)
	public String UserDetail(HttpServletRequest request, Locale locale, Model model, MemberDto dto) {
		logger.info("회원상세보기", locale);
		MemberDto udto = adminService.getUser(dto.getSeq());
		model.addAttribute("dto", udto); 
		return "userDetail";
	}
	
	//회원정보 수정 업데이트폼
	@RequestMapping(value="/userUpdateform.do" , method=RequestMethod.POST)
	public String updateForm(HttpServletRequest request, Locale locale, Model model, MemberDto dto) {
		logger.info("회원수정폼 {}.", locale);
		String sseq =request.getParameter("seq");
		String nickname = request.getParameter("nickname");
		String email = request.getParameter("email");
		int seq=Integer.parseInt(sseq);
		String grade=request.getParameter("grade");
		
		boolean isS=adminService.userUpdate(new MemberDto(seq,nickname,email,grade));
		if(isS) {
			return "redirect:userList.do";			
		} else {
			model.addAttribute("msg", "회원정보업데이트실패");
			return "error";
		}
	} 
	
	//사용자 등급 변경기능
	@RequestMapping(value="/updateGrade.do" , method=RequestMethod.POST)
	public String updateGrade(HttpServletRequest request, Locale locale, Model model) {
		logger.info("회원등급변경", locale);
		String sseq=request.getParameter("seq"); 
		int seq=Integer.parseInt(sseq);
		String grade = request.getParameter("grade"); 
		
		boolean isS=adminService.updateGrade(new MemberDto(seq,grade));
		if(isS) {
			return "redirect:userList.do";			
		} else {
			model.addAttribute("msg", "회원등급변경실패");
			return "error";
		}
	} 
	
	//체크박스로 회원 삭제
	@RequestMapping(value = "/checkDel.do", method = RequestMethod.POST)
	public String checkDel(@RequestParam(value="chk") String [] chk, ModelMap modelMap)throws Exception {
		for (String id : chk) {
			System.out.println("회원체크박스 삭제: = " + id);
			int delete_count = adminService.checkDel(id);
		}
			return "redirect:userList.do";	
	}
	
	//회원 삭제버튼
	@RequestMapping(value = "/userDelete.do", method = RequestMethod.GET)
	public String UserDelete(HttpServletRequest request, Locale locale, Model model, String seq) {
		logger.info("회원삭제", locale);
		String m_sseq=request.getParameter("seq");
		int sseq=Integer.parseInt(m_sseq);
		
		boolean isS=adminService.delUser(sseq);
		if(isS) {
			return "redirect:userList.do";			
		} else {
			model.addAttribute("msg", "회원삭제실패");
			return "error";
		}
	}

	
}
