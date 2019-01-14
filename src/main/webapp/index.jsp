<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE>
<html>
<head>
<!-- 이한준 -->
	<link rel="shortcut icon" href="./resources/images/favicon.ico">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/search.css">
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/hj/main_search.js"></script>
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
<%@include file="WEB-INF/views/header.jsp" %>
<div class="content">
	<div class="start-class">
		<div class="start-class-title">개강임박과정</div>
		<div class="start-class-content">
			<ul id="start-class-ul" class="sticker">
				<c:choose>
					<c:when test="${startclass != null}">
						<c:forEach items="${startclass}" var="sc" varStatus="status">
							<li onclick="window.open('info.do?subTitle=${sc.startAcademyName}','${rk.rankAcademyName}','width=640px, height=720px, left=600, top=100px, menubar=no, scrollbars=no'); return false;">
								<span class="dday">D-${sc.startDDay}</span>${sc.startClassName}
							</li>
						</c:forEach>
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>
	
	<!-- 이한준 -->
	<input type="text" id="myInput" onkeyup="myFunction(this.value)" placeholder="학원,과정,주소로 검색 가능합니다." title="Type in a name">
	<div class="myInput-underline"></div>
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
	<div class="ranking">
		<span  class="ranking-title" style="font-weight:bold; float:left; color:#3572b0;">실시간 학원 순위: </span>
		<ul id="ranking-ul" class="ranking-sticker">
			<c:choose>
				<c:when test="${ranking != null}">
					<c:forEach items="${ranking}" var="rk" varStatus="status">
						<li onclick="window.open('info.do?subTitle=${rk.rankAcademyName}','${rk.rankAcademyName}','width=640px, height=720px, left=600px, top=100px, menubar=no, scrollbars=no'); return false;">
					<%-- 	<li onclick="location.href='info.do?subTitle=${rk.rankAcademyName}'"> --%>
							<span style="font-weight:bold; color:navy;">${status.count}</span><span style="color:dimgrey;"> ${rk.rankAcademyName}  ${rk.rankScoreAverage}</span>
						</li>
					</c:forEach>
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		</ul>
		<span id="show-table-btn" style="position: absolute; right: 0px; display: block; margin:8px 0 0 0; cursor:pointer;">
			<img src="./resources/images/srch_btn.gif" alt="펼치기" >
		</span>
	</div>
	<div class="ranking-table" style="display:none;" >
		<strong style="color:#3572b0;">실시간 학원 순위</strong>
		<table>
		<c:choose>
			<c:when test="${ranking != null}">
				<c:forEach items="${ranking}" var="rk" varStatus="status">
					<tr>
						<td class="ranking-table-fir-td">${status.count}</td>
						<td onclick="window.open('info.do?subTitle=${rk.rankAcademyName}','${rk.rankAcademyName}','width=640px, height=720px, left=600px, top=100px, menubar=no, scrollbars=no'); return false;" 
							class="ranking-table-sec-td"><span style="color:dimgrey;">${rk.rankAcademyName}</span></td>
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
	
	<div class="bgImg">
	</div>

</div>

<div class="app-footer">
		<div class="banner">
			<ul>
				<li><a href="http://www.moel.go.kr" target="_blank"
													title="새창" tabindex="-1"><img src="./resources/images/site_b1.png"
														alt=""> 고용노동부</a></li>
				<li><a href="http://work.go.kr" target="_blank"
													title="새창" tabindex="-1"><img src="./resources/images/site_b2.png"
														alt=""> 워크넷</a></li>
				<li><a href="http://www.kcomwel.or.kr" target="_blank"
													title="새창" tabindex="-1"><img src="./resources/images/site_b3.png"
														alt=""> 근로복지공단</a></li>
				<li><a href="http://www.keis.or.kr" target="_blank"
													title="새창" tabindex="-1"><img src="./resources/images/site_b4.png"
														alt=""> 한국고용정보원</a></li>
				<li><a href="https://www.eps.go.kr" target="_blank"
													title="새창" tabindex="0"><img src="./resources/images/site_b5.png"
														alt=""> 외국인고용 </a></li>
				<li><a href="https://www.ei.go.kr" target="_blank"
													title="새창" tabindex="-1"><img src="./resources/images/site_b6.png"
														alt=""> 고용보험</a></li>
				<li><a href="https://www.ncs.go.kr" target="_blank"
													title="새창" tabindex="-1"><img src="./resources/images/site_b7.png"
														alt=""> 직무능력표준</a></li>
				<li><a href="https://c.q-net.or.kr/cont/bbs/wldsBbsList.do"
													target="_blank" title="새창" tabindex="-1"><img
														src="./resources/images/site_b8.png" alt=""> CQ넷</a></li>
				<li><a href="http://www.hrdkorea.or.kr" target="_blank"
													title="새창" tabindex="-1"><img src="./resources/images/site_b9.png"
													alt=""> 한국산업인력공단</a></li>
			</ul>					
		</div>
	<div> Copyright ©2018 NAI, Inc. All Rights Reserved.</div>
</div>

<script>
	
	$("#show-table-btn").on('click', function(){
		$(".ranking-table").show();
	});
 	
	$(".ranking-table").on('mouseleave', function(){
		$(".ranking-table").hide();
	});

	
	function rollingSticker(){
		$("#start-class-ul li:first").slideUp(
				function() {
					$(this).appendTo($("#start-class-ul")).slideDown();
				});
		};	
	
	setInterval(function(){rollingSticker()},3000);
	
	
	function rollingStickerRanking(){
		$("#ranking-ul li:first").slideUp(
				function() {
					$(this).appendTo($("#ranking-ul")).slideDown();
				});
	};	
	
	setInterval(function(){rollingStickerRanking()},4000);
	
</script>
</body>
</html>