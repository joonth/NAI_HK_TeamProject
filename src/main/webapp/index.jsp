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
height:40px;
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
	<%@include file="WEB-INF/views/header.jsp" %>
	<a href="main.do">메인</a>
	<a href="calendar.do">캘린더</a>
	<a href="boardlist.do?page=1&pagelist=first">게시판</a>
	<a href="userList.do">회원목록</a>
	<hr>

<body>

	<%@include file="WEB-INF/views/header.jsp" %>


<!-- 이한준 -->

<div class="content">
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
	<div class="bgImg">
	</div>
	
	<div class="ranking">
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
	</div>


	<div class="startClass">
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
</div>
<div class="app-footer">
	<p> Copyright ©2018 NAI, Inc. </p>
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