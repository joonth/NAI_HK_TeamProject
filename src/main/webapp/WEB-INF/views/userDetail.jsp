<%@page import="com.hk.nai.dtos.MemberDto" %>
<%@page import="com.hk.nai.daos.AdminDaoImpl"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%response.setContentType("text/html; charset=utf-8");%>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="./resources/images/favicon.ico">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 조회/상세보기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 <link href="http://fonts.googleapis.com/earlyaccess/nanumgothiccoding.css" rel="stylesheet">
<style type="text/css">

body{
  	margin-right: auto;
    margin-left: auto;
	
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

#table{
	max-width: 1023px;
	border-color: black;
	background-color: white;
	text-align: center;
	width: 100%;
    max-width: 100%;
    margin-bottom: 20px;
	
}

@media (min-width: 980px)
#table {
    width: 66.66666667%;
}


</style>
</head>
<body>
<%@include file="header.jsp" %>
<%
	AdminDaoImpl dao = new AdminDaoImpl();
%>
<h1 id="title">회원정보 조회/수정</h1>
<script type="text/javascript">
	function updateUser(){
		alert("회원정보가 변경되었습니다.");
	}
</script>

<div id="container">
<form action="userUpdateform.do" method="post" onsubmit="return checkRegx();">
<input type="hidden"  name="seq" value="${dto.seq}"/>
<table id="table">	
	<col width="80px">
	<col width="80px">
	<col width="100px">
	<col width="100px">
	<col width="130px">
	<col width="200px">
	<tr>
		<th>아이디</th>
		<td><input type="text" name ="id" value="${dto.id}" readonly="readonly" style="background-color: #dad4d4;"></td>
	</tr>
	<tr>
		<th>닉네임</th>
		<td><input type="text"  id="nickname" name="nickname" value="${dto.nickname}"></td>
		<td><span id="nicknameChk"></span></td>
	</tr>
	<tr>
		<th>이메일</th>
		<td><input type="text" name="email" id="email" value="${dto.email}"></td>
		<td><span id="emailChk" ></span></td>
	</tr>
	<tr>
		<th width="150px">회원등급</th>
		<td>
			<select name="grade">
				<option value="A" id="adminChk" <c:if test="${dto.grade eq 'A'}" >selected</c:if>>관리자</option>
				<option value="C" <c:if test="${dto.grade eq 'C'}" >selected</c:if>>일반회원</option>
				<option value="B" <c:if test="${dto.grade eq 'B'}" >selected</c:if>>학원생</option>
			</select>
		</td>
	</tr>
	<tr>
		<th>포인트</th>
		<td>${dto.point}</td>
	</tr>
	<tr>
		<th>학원생인증여부</th>
		<td>${dto.writeCheck}</td>
	</tr>
	</table>
			<input type="submit" id="submitBtn" value="저장하기" onclick="updateUser();">
			<button type="button" onclick="userList()">취소</button>
	
<script type="text/javascript">
	//회원목록으로 이동
	function userList(){
		location.href="userList.do";
	}
	
	//닉네임 중복 체크 ajax
		$("#nickname").focusout(function() {
			$.ajax({
				url : "nicknamecheck.do",
				data : {
					"nickname" : $("#nickname").val()
				},
				datatype : "json",
				method : "post",
				success : function(obj) {
					var msg = obj["msg"];
					if (msg != null) {
						$("#nicknameChk").html(msg);
						$("#nickname").focus();
						return false;
					} else {
						$("#nicknameChk").html("");
					}
					return true;
				},
				error : function() {
					alert("서버 통신 실패");
				}
			})
		});

		//이메일 중복 체크 ajax
		$("#email").focusout(function() {
			$.ajax({
				url : "emailcheck.do",
				data : {
					"email" : $("#email").val()
				},
				datatype : "json",
				method : "post",
				success : function(obj) {
					var msg = obj["msg"];
					if (msg != null) {
						$("#emailChk").html(msg);
						/* 프로토에서는 중복 가능하게 */
		/* 				$("#email").focus();
						return false; */
					} else {
						$("#emailChk").html("");
					}
	/* 				return true; */
				},
				error : function() {
					alert("서버 통신 실패");
				}
			})
		});

		//유효성검사
		function checkRegx() {
			var RegxEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;	
			if (!RegxEmail.test($.trim($("#email").val()))) {
				$("#emailChk").html("이메일 형식이 아닙니다");
				$("#email").focus();
				return false;
			} else {
				$("#emailChk").html("");
			}
			return true;
					
		}
		
</script>
</form>
</div>
</body>
</html>