<%@page import="com.hk.nai.dtos.MemberDto" %>
<%@page import="java.util.List"%>
<%@page import="com.hk.nai.daos.AdminDaoImpl"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%	request.setCharacterEncoding("utf-8");%>
<%response.setContentType("text/html; charset=utf-8");%>
<!DOCTYPE html>
<html>
<head>
	<link rel="shortcut icon" href="./resources/images/favicon.ico">
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/hj/main_message.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/userList.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/userList.css">
	<!-- 폰트추가 -->
	  <link href="http://fonts.googleapis.com/earlyaccess/nanumgothiccoding.css" rel="stylesheet">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<style type="text/css">

body{
  	margin-right: auto;
    margin-left: auto;
	
} 

#centerContent{	
	
}

#userListbar{
	
	}

hr{
	border: solid 10px black;
}
	
#title{
	font-family: 'Nanum Gothic Coding', serif;
	font-weight: 700;
	color: black;
	font-size: 24px;
	text-align: left;
    padding-left: 20%;
	margin-right: auto;
    margin-left: auto;
    
}

.table{
	max-width: 1023px;
	border-color: black;
	background-color: white;
	text-align: center;
}

#Thbar{
	font-family: 'Nanum Gothic Coding', serif;
	font-weight: 700;
	font-size: 15px;
	max-width: 1023px;
	border-radius: 8px;
	margin-right: auto;
    margin-left: auto;
	color: white;
	background-color: #4866a9;
	height: 60px;
	
}

#Thbar >th{
	text-align: center;	
	padding-top: 30px;
}

#Thbar >th>td{
	padding: 11px;
	padding-top: 70%;
}

@media (min-width: 980px)
#centerContent {
    width: 66.66666667%;
}

@media (min-width: 992px)
.container {
    width: 970px;
}

.container {
    padding-right: 15px;
    padding-left: 15px;
    margin-right: auto;
    margin-left: auto;
}

.text-center {
    text-align: center;
}

#allChk{
	margin: 4px 0 0;
	line-height: normal;
	box-sizing: border-box;
    padding: 0;
}

/* 셀렉트박스   */
.selectGrade {
	display: block;
    width: 65%;
    height: 34px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.gradeChangeBtn{
	color: #333;
    background-color: #f7f6f9;
    border-color: #ccc;
    display: inline-block;
    padding: 6px 12px;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    touch-action: manipulation;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;
}

.btn{
	border: 0;
	background-color: white;
}

#grade{
	display: -webkit-inline-box;
}
 
.chkDeleteBtn{
	-webkit-appearance: button;
    cursor: pointer;
    color: #333;
    background-color: #d7d9e4;
    border-color: #ccc;
    display: inline-block;
    padding: 6px 12px;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.42857143;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;
    text-align: center;
    margin-right:96%; 
}
 
</style>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>회원관리페이지</title>
</head>
<body>
	<%@include file="header.jsp" %>
	<%
		AdminDaoImpl dao = new AdminDaoImpl();
	%>]
	<h1 id="title">회원목록</h1>
	<div id="centerContent" class="container text-center">
		<!-- 체크박스의 회원번호를 submit할 폼 -->
		<form action="checkDel.do" method="post" onsubmit="return confirmChk()"> 
			<table class ="table">
				<col width="80px">
				<col width="80px">
				<col width="100px">
				<col width="100px">
				<col width="150px">
				<col width="90px">
				<col width="140px">
				<col width="120px">
				<tr id="Thbar">
					<th><input type="checkbox" id="allChk" name="all" onclick="allSel(this.checked)" /></th>
					<th>아이디</th>
					<th>닉네임</th>
					<th>이메일</th>
					<th>회원등급</th>
					<th>포인트</th>
					<th>수강평작성여부</th>
					<th>옵션</th>
				</tr>
				<c:choose>
					<c:when test="${empty getUserList}">
						<tr><td colspan="10">------------가입한 회원이 없습니다.-------------</td></tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${getUserList}" var="memberdto">
							<tr>
								<td>
									<input type="checkbox" name="chk" value="${memberdto.id}"/>
								</td>
								<td>${memberdto.id}</td>
								<td>${memberdto.nickname}</td>
								<td>${memberdto.email}</td>
								<td>
									<!-- 회원 등급 변경후 submit하는 폼-->
									<form name="gradeChange" method="post" action="updateGrade.do" >
										<input type="hidden" name="seq" value="${memberdto.seq}" >
										<div id="grade">
											<select name="grade" class="selectGrade">
												<option value="A" id="adminChk" <c:if test="${memberdto.grade eq 'A'}" >selected</c:if>>관리자</option>
												<option value="C" <c:if test="${memberdto.grade eq 'C'}" >selected</c:if>>일반회원</option>
												<option value="B" <c:if test="${memberdto.grade eq 'B'}" >selected</c:if>>학원생</option>
											</select>
											<!-- 회원의 등급을 바꿔줌 -->
											<a><input type="submit" value="변경" class="gradeChangeBtn" onclick="confirmChangeGrade();"></a>
										</div>
									</form> <!-- 등급변경 폼 -->
								</td> 
								<td>${memberdto.point}</td>
								<td>${memberdto.writeCheck}</td>
								<td>
									<button type ="button" class="btn" id="modifi" onclick="location.href='userDetail.do?seq='+'${memberdto.seq}'"><img class="btn-img" src="./resources/images/gear.png"></button>
									<button type ="button" class="btn" onclick="location.href='userDelete.do?seq='+'${memberdto.seq}'"><img class="btn-img" src="./resources/images/trash.png"></button>		
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
			<input type="submit" class="chkDeleteBtn" value="선택삭제"/>
		</form>
	<!-- 체크박스 삭제 폼  -->
	</div>
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
</body>
</html>