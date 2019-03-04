package com.hk.nai;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hk.nai.daos.MessageDao;
import com.hk.nai.dtos.MemberDto;
import com.hk.nai.dtos.MessageDto;
import com.hk.nai.services.SearchService;

@Controller
public class MessageController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	MessageDao messageDao;
	@Autowired
	SearchService Sserv;

	@RequestMapping(value = "/getMessageList.do", method = RequestMethod.GET)
	public String getAllBoard(Locale locale, Model model, String n_receiver) {
		logger.info("메시지 리스트 출력", locale);
		List<MessageDto> list = messageDao.getMessageList(n_receiver);
		Collections.sort(list);
		model.addAttribute("list", list);
		return "messagelist";
	}
	
	@RequestMapping(value = "/getMessage.do", method = RequestMethod.GET)
	public String getMessage(Locale locale, Model model, MessageDto dto) {
		logger.info("메시지 내용 출력", locale);
		MessageDto  mdto = messageDao.getMessage(dto.getN_seq());
		model.addAttribute("dto",mdto);
		return "messagecontent";
	}
	

	@RequestMapping(value = "/sendMessage.do", method = RequestMethod.POST)
	public String sendMessage(Locale locale, Model model, MessageDto dto) {
		logger.info("메시지 전송", locale);
		messageDao.sendMessage(dto);	
		return "../../index";
	}
	
	@RequestMapping(value = "/deleteMessage.do", method = RequestMethod.GET)
	public String deleteMessage(Locale locale, Model model, MessageDto dto, String n_receiver) {
		logger.info("메시지 삭제", locale);
		messageDao.deleteMessage(dto.getN_seq());
		List<MessageDto> list = messageDao.getMessageList(n_receiver);
		model.addAttribute("n_receiver", n_receiver);	
		model.addAttribute("list", list);
		return "messagelist";
	}
	
	// 회원관리 page : 회원리스트 출력.
	@ResponseBody
	@RequestMapping(value = "/getMemberList.do", method = RequestMethod.POST)
	public Map<String,List<MemberDto>> getMemberList(Locale locale, Model model) throws IOException {
		Map<String,List<MemberDto>> map = new HashMap<String,List<MemberDto>>();
		map.put("list", Sserv.getMemberList());
		return map;
	}
	
	// 회원관리 page : 회원 클릭시 반대편 box로 
	@ResponseBody
	@RequestMapping(value = "/changeState.do", method = RequestMethod.GET)
	public Map<String,String> changeState(Locale locale, Model model,String value,String section) throws IOException {
		Map<String,String> map = new HashMap<String,String>();	
		section = (section.equals("a")) ? "b": "a";
		map.put("value", value);
		map.put("section", section);
		return map;
	}
}
