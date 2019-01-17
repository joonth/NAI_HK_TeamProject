<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="shortcut icon" href="./resources/images/favicon.ico">
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/hj/main_message.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/userList.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/userList.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/adminpage.css">
	<!-- 폰트추가 -->
	  <link href="http://fonts.googleapis.com/earlyaccess/nanumgothiccoding.css" rel="stylesheet">
</head>
<body>
	<%@include file="header.jsp" %>
	<!-- 사이드 메뉴 -->
	<div id="myinfo-sidemenu-bar">
		<ul class="nav nav-pills nav-stacked">
			<li><a href="userList.do">회원관리</a></li>
			<li class="active"><a href="getMessageForm.do">Message 전송</a></li>
		</ul>
	</div>
	<!--  -->
	<div id="myinfo-container" class="container">
		<h1 id="title">Message 전송</h1>
		<!-- Message part 시작부분  -->
		<div class="container">
			<div class="jumbotron">
				<div class="box">
					<h4 class="sectionTitle p-01">ID 입력해서 Message 보내기</h4>
					<form id="messageForm" class="form-inline" action="sendMessage.do" method="post">
						<div class="form-group">
							<input type="hidden" name="n_sender" value="admin">
						    <label>받는이</label>
							<input id="n_receiver" type="text" name="n_receiver" >
						</div>
						<div class="form-group">
						    <label>내용</label>
							<input id="n_content" type="text" name="n_content" >
					    </div>
					 	<div class="radio">
							<input type="radio" name="ns_state_code" checked="checked" value="a"> 공지사항
						  	<input type="radio" name="ns_state_code" value="e"> 이벤트		  
						</div>
						<input type="submit" class="btn btn-default" value="전송">
					</form>
				</div>
				<div class="box">
					<h4 class="sectionTitle p-01">ID 선택해서 Message 보내기</h4>
					<form id="messageAllForm" class="form-inline" action="sendMessage.do" method="post">
						<div class="form-group">
							<input type="hidden" name="n_sender" value="admin">
							<label>내용</label>
							<input id="allContent" type="text" name="n_content">
						</div>
						<div class="form-group">
							<input class="pick" type="radio" name="ns_state_code" checked="checked" value="a"> 공지사항
						  	<input class="pick" type="radio" name="ns_state_code" value="e"> 이벤트
						</div>
						<input type="submit" class="btn btn-default" value="전송">
					</form>
					<div class="box">
						<div class="col-sm-5">
							<h5 class="sectionTitle p-01"> User </h5>
							<div id="a" class="box" style="border:1px solid black;"></div>
						</div>
						<div id="c" class="col-sm-2">
							<button id="passAll" class="btn btn-default" onclick="stateClick('all')">전체선택 →</button>
						</div>
						<div class="col-sm-5">
							<h5 class="sectionTitle p-01">Message를 받을 User</h5>
							<div id="b" class="box" style="border:1px solid black;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>