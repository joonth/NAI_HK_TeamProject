<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE>
<html>
<head>
<!-- 이한준 -->
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/hj/main_search.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/hj/main_message.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/search.css">	
<!-- 이한준 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>국과수 국비과정수업정보</title>
<%
	if(session.getAttribute("member") == null){
		response.sendRedirect("signinform.do");
	}
%>
<style>
.sticker{
height:50px;
overflow:hidden;
margin:0;
padding:0;
list-style:none;
}

.sticker li{
height:40px;
padding:5px;
margin: 0px 5px;
}
</style>

</head>
<body>
	<%@include file="WEB-INF/views/header.jsp" %>
	<a href="main.do">메인</a>
	<a href="#">캘린더</a>
	<a href="boardlist.do?page=1&pagelist=first">게시판</a>
	<a href="userList.do">회원목록</a>
	<hr>
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
		내용 <input id="n_content" type="text" name="n_content" >
		<input type="radio" name="ns_state_code" checked="checked" value="a"> 공지사항
	  	<input type="radio" name="ns_state_code" value="e"> 이벤트
		<input type="submit" value="전송">
	</form>
	<button id="passAll" onclick="stateClick('all')">전체선택</button>
	<div id="a" style="border:1px solid black;"></div>
	<div id="b" style="border:1px solid black;"></div>
	<form id="messageAllForm" action="sendMessage.do" method="post">
		<input type="hidden" name="n_sender" value="admin">
		내용 <input id="allContent" type="text" name="n_content">
		<input type="radio" name="ns_state_code" checked="checked" value="a"> 공지사항
	  	<input type="radio" name="ns_state_code" value="e"> 이벤트
		<input type="submit" value="전송">
	</form>

<p>---학원랭킹---</p>
	<table border="1">
	<c:choose>
		<c:when test="${ranking != null}">
			<c:forEach items="${ranking}" var="rk" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${rk.rankAcademyName}</td>
					<td>${rk.rankScoreAverage}</td>
				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td>ranking 비어있음</td>
			</tr>
		</c:otherwise>
	</c:choose>
	</table>
<div>
<p>----개강임박과정----</p>
	<ul id="startClass" class="sticker">
		<c:choose>
			<c:when test="${startclass != null}">
				<c:forEach items="${startclass}" var="sc" varStatus="status">
					<li>${sc.startAcademyName} ${sc.startClassName} D - ${sc.startDDay}</li>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<li>startclass 비어있음</li>
			</c:otherwise>
		</c:choose>
	</ul>
</div>
<script type="text/javascript">
	function rollingSticker(){
		$("#startClass li:first").slideUp(
				function() {
					$(this).appendTo($(startClass)).slideDown();
				});
		};	
	setInterval(function(){rollingSticker()},4000);
</script>
</body>
</html>