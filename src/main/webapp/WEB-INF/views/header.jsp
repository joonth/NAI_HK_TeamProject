<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
	<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100|Noto+Sans+KR:400|Do+Hyeon" rel="stylesheet">	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/hj/header.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<!-- header  -->
	<div class="navbar">
		<div class="container-fluid">
			<div class="nav-content">
				<a href="main.do" >
					<img class="nav-image" alt="logo" src="./resources/images/detective.png">
					<span class="nav-title">국비과정수업정보 NAI</span>
				</a>
			</div>
			<div class="nav-content">
			 	<input id="session" type="hidden" value="${sessionScope.member.id}" >
				<!-- 세션이 있을 때만 = 로그인되어있을 때만  -->
				<c:if test="${sessionScope.member!=null}">
					<a href="main.do">메인</a>
					<a href="calendar.do">캘린더</a>
					<a href="boardlist.do?page=1&pagelist=first">게시판</a>
					<c:if test="${sessionScope.member.grade == 'A'}">
						<a href="userList.do">회원관리</a>
					</c:if>
				</c:if>
			</div>
			<div class="nav-content" style="width:280px; text-align:right; padding: 0 5px 0 0;">
				<c:choose>
					<c:when test="${sessionScope.member.grade == 'A'}">
						<span class="info-bar" >
							<a style="color:#fffa29;">관리자</a> 
							${sessionScope.member.nickname} 님
						</span>
					</c:when>
					<c:otherwise>	
					<span class="info-bar">
						${sessionScope.member.nickname} 님
					</span>
					<span style="color:white" id="count" onclick="changeUrl('getMessageList.do?n_receiver=${sessionScope.member.id}')" class="glyphicon glyphicon-envelope" data-toggle="modal" data-target="#myModal" ></span>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="nav-content" style=" padding: 0 5px 0 5px; ">
				<span class="info-bar" style="font-weight: 100;">
					<a href="mypage.do">마이페이지</a>
				</span>
			</div>
			<div class="nav-content" style="padding: 0 0 0 5px;">
				<span class="info-bar" style="font-weight: 100;">
					<a href="signout.do">로그아웃</a>
				</span>
			</div>
			<div class="nav-content" style="padding: 0 0 0 70px;">
				<span class="info-bar" style="font-weight: 100;">
					<a href="https://github.com/joonth/NAI_HK_TeamProject" target="_blank">
						<img src="./resources/images/github-menu-item.svg">
						&nbsp; GitHub
					</a>
				</span>
			</div>
		</div>
	</div>
	<!-- header  -->
	
	<!-- 찜한 학원  -->
	<div id="icon-bar" >
	</div>
	<!-- 찜한 학원 -->

	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
		  <div class="modal-content">
		    <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		    </div>
		    <div class="modal-body">
				<iframe id="if" src="" width="600" height="380" frameborder="0" allowtransparency="true"></iframe>  
		    </div> 
		  </div>
		</div>
	</div>	
	<!-- Modal -->
</body>
</html>