package com.hk.nai;

import java.io.IOException;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.jsoup.Jsoup;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hk.nai.daos.CalDao;
import com.hk.nai.dtos.BasketDto;
import com.hk.nai.dtos.CalDto;
import com.hk.nai.dtos.InfoDto;
import com.hk.nai.dtos.MemberDto;
import com.hk.nai.services.CalService;
import com.hk.nai.services.ICalService;
import com.hk.nai.services.MemberService;
import com.sun.prism.Image;



/**
 * Handles requests for the application home page.
 */
@Controller
public class CalController {
	
	private static final Logger logger = LoggerFactory.getLogger(CalController.class);
	
	@Autowired
	private ICalService calService;
	
	@Autowired
	private MemberService memberService;

	//캘린더 기본페이지
	@RequestMapping(value = "/calendar.do", method = RequestMethod.GET)
	public String Calendar(HttpServletRequest request, Locale locale, Model model) {
		logger.info("캘린더보기", locale);	
		List<CalDto> javaList = new ArrayList<CalDto>();
		List<CalDto> calViewList = calService.getCalList();
		model.addAttribute("calViewList", calViewList);

		return "calendar";
		
	}
	
	//캘린더 검색 리스트
	@RequestMapping(value = "/calSearchform.do", method = RequestMethod.GET)
	public String CalSearch(HttpServletRequest request, Locale locale, Model model, String search) throws UnsupportedEncodingException {
		logger.info("캘린더검색", locale);	
		request.setCharacterEncoding("utf-8");
	
		List<CalDto> selectList = new ArrayList<CalDto>();
		List<CalDto> calViewList = calService.getCalList();
					
		if(search!=null) {
			request.getSession().setAttribute("search", search);

		}else {
			search=(String)request.getSession().getAttribute("search");
		}
			System.out.println(search);
			
			for(int i=0; i<calViewList.size(); i++) {
				CalDto dto =calViewList.get(i);	

				if(dto.getAc_class().contains(search)
						|| dto.getAc_location().contains(search)
						|| dto.getAc_name().contains(search)) {
					selectList.add(dto);
				} else {
				}
			}		
			
			for(int i=0; i<selectList.size(); i++) {
				System.out.println("selectlist"+i+"번째"+selectList.get(i));
			}
			model.addAttribute("calViewList", selectList);
			
			return "calSearchResult";    //검색결과페이지로 이동
		}
		
	
	//캘린더 상세페이지
	@RequestMapping(value = "/calDetail.do", method = RequestMethod.GET)
	public String CalDetail(HttpServletRequest request, Locale locale, Model model, int ac_seq,  @RequestParam String ac_name) throws UnsupportedEncodingException {
		logger.info("캘린더상세보기", locale);
		request.setCharacterEncoding("utf-8");
		String ac_sseq=request.getParameter("ac_seq");
		int ac_seqq=Integer.parseInt(ac_sseq);
		CalDto dto = new CalDto();
		dto.setAc_seq(ac_seqq);
		dto.setAc_name(ac_name);
		model.addAttribute("calDto", calService.getCalDetail(dto));
		
		return "calDetail";
	}
	
	//캘린더 일별랭킹페이지
	@RequestMapping(value = "/acDayRank.do", method = RequestMethod.GET)
		public String acDayRank(HttpServletRequest request, Locale locale, Model model) throws UnsupportedEncodingException {
			logger.info("캘린더일별랭킹 보기", locale);
			List<CalDto> getCalRk = calService.getCalRk();
			model.addAttribute("calViewList", getCalRk);
			System.out.println(getCalRk.size());
			
			return "calendar";
		}
	
	//장바구니 페이지
		@RequestMapping(value = "/cartAcademyCal.do", method = RequestMethod.GET)
			public String cartAcademyCal(Locale locale, Model model, HttpSession session) throws UnsupportedEncodingException {
				logger.info("찜한 학원일정 보기", locale);
				MemberDto member = (MemberDto) session.getAttribute("member");
				String baskId = member.getId();
				List<BasketDto> myAcList = memberService.showMyAcList(baskId);
				List<CalDto> BaskAcaList = new ArrayList<CalDto>();
				
				for(int i=0; i<myAcList.size(); i++) {
					String baskAcName=myAcList.get(i).getBaskAcademyName();
					System.out.println("장바구니 학원명: " +baskAcName);
					BaskAcaList.addAll(calService.getCartAcademy(baskAcName));			
				}
				for(int j=0; j<BaskAcaList.size(); j++) {
				System.out.println("찜한학원강좌목록" + BaskAcaList.get(j));
				}
				model.addAttribute("calViewList", BaskAcaList);
				return "calendar";
			}
	
}
