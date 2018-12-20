<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 이한준 -->
<%@page import="java.util.List"%>
<%@page import="com.hk.nai.dtos.SearchDto"%>
<%@page import="java.util.Map"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.select.Elements"%>

<!-- 이한준 -->

<!DOCTYPE>
<html>
<head>

<!-- 이한준 -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/search.js"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/search.css">
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>		
<!-- 이한준 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>국과수 국비과정수업정보</title>
<%
	if(session.getAttribute("member") == null){
		response.sendRedirect("signinform.do");
	}
%>
</head>
<body>

<!-- 세션이 있을 때만 = 로그인되어있을 때만  -->
<c:if test="${sessionScope.member!=null}">
	<p>${sessionScope.member.nickname} 님 환영합니다</p><br>
	<a href="signout.do">로그아웃</a>
	<a href="mypage.do">마이페이지</a>
</c:if>

<a href="main.do">메인</a>
<a href="#">캘린더</a>
<a href="#">게시판</a>

<!-- 이한준 -->
	
		<input type="text" id="myInput" onkeypress="if(event.keyCode==13) {myFunction(this.value); return false;}" placeholder="학원,과정,주소로 검색 가능합니다." title="Type in a name">
		<div id="none">
			<table id="myTable">
				<tr class="header">
					<th style="width:20%;">사진</th>
					<th style="width:40%;">과정명</th>
					<th style="width:25%;">학원명</th>
					<th style="width:10%;">주소</th>
					<th style="width:5%;">평점</th>
									
				</tr>
		 
				<c:forEach var = "dto" items="${list}">
					<tr onclick="window.location='info.do?subTitle=${dto.subTitle}'">
						
			
					<c:set var="test" value="한경닷컴IT교육센터"/>
						<c:choose>
						    <c:when test="${test eq dto.subTitle}">
						        <td class="img">1</td>	
						    </c:when>
						    <c:otherwise>
					    	  <td>2</td>
						    </c:otherwise>
						</c:choose>
						<td>${dto.title}</td>
						<td>${dto.subTitle}</td>
						<td>${dto.address}</td>
						<td>${dto.score}</td>
					
					</tr>
				</c:forEach>
			</table>
		</div>
<!-- 이한준 -->

<p>---학원랭킹---</p>

<p>----마감임박학원----</p>
</body>
</html>