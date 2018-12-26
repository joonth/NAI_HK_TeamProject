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
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<!-- 이한준 -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/search.js"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/search.css">
			
<!-- 이한준 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>국과수 국비과정수업정보</title>
<%
	if(session.getAttribute("member") == null){
		response.sendRedirect("signinform.do");
	}
%>
<script type="text/javascript">

$(document).ready(function(){
	
var frm = $('#messageForm');

frm.submit(function (e) {
console.log(frm);
    e.preventDefault();
    $.ajax({
        type: frm.attr('method'),
        url: frm.attr('action'),
        data: frm.serialize(),
        success: function (data) {
            console.log('Submission was successful.');
       
        },
        error: function (data) {
            console.log('An error occurred.');
       
        },
    });
});
});
</script>


</head>
<body>
<%@include file="WEB-INF/views/header.jsp" %>

<a href="main.do">메인</a>
<a href="#">캘린더</a>
<a href="#">게시판</a>
<hr>
<!-- 이한준 -->
${list1}
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
				<c:forEach var = "dto" items="${list}" >
					<tr onclick="window.location='info.do?subTitle=${dto.subTitle}'">
						<td><img alt="img" width="150" height="90" src="${dto.img}"></td>	
						<td>${dto.title}</td>
						<td>${dto.subTitle}</td>
						<td>${dto.address}</td>
						<td class="score">${dto.score}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
<!-- 이한준 -->
<hr>
<form id="messageForm" action="sendMessage.do" method="post">
	<input type="hidden" name="n_sender" value="admin">
	받는이 <input id="n_receiver" type="text" name="n_receiver" >
	내용 <input type="text" name="n_content" >
	<input type="hidden" name="ns_state_code" value="a">
	<input type="submit" value="전송">
</form>

<p>---학원랭킹---</p>

<p>----마감임박학원----</p>
</body>
</html>