package com.hk.nai;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import com.hk.nai.daos.MessageDao;
import com.hk.nai.dtos.MemberDto;

@Controller
public class EchoHandler extends TextWebSocketHandler {
	  
	@Autowired
	MessageDao dao;
	private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	Map<String,String> map = new HashMap<String,String>();
	Map<String,Object> smap;
	  
	  // 서버에 연결한 사용자들을 저장하는 리스트
	  private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	  
	  // 클라이언트와 연결 이후에 실행되는 메서드
	  @Override
	  public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		  sessionList.add(session);
		  smap =session.getAttributes();
		  //	HttpSessionHandShakeInterceptor 설정을 통해서 httpsession 정보를 받아옴
		  MemberDto dto = (MemberDto) smap.get("member");
		  map.put(session.getId(), dto.getId());
	    logger.info("{} 연결됨", session.getId());
	  }
	 
	  // 클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
	  @Override
	  protected void handleTextMessage(WebSocketSession session, TextMessage message) {
	   try {
		  logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
	    for(WebSocketSession ss : sessionList) {
	    	if(map.get(ss.getId()).equals(message.getPayload())) {
	    		ss.sendMessage(new TextMessage(dao.getMsgNum(message.getPayload())));
	    	}
	    }
	   }catch(Exception e) {
		   e.printStackTrace();
	   }
	  }
	 
	  // 클라이언트와 연결을 끊었을 때 실행되는 메소드
	  @Override
	  public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	    map.remove(session.getId());
	    sessionList.remove(session);
	    logger.info("{} 연결 끊김", session.getId());
	  }
}


