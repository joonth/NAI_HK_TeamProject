<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
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

<p>---학원랭킹---</p>

<p>----마감임박학원----</p>
</body>
</html>