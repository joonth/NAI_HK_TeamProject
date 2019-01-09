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
	<!-- 이한준 -->
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/hj/main_message.js"></script>
	<!-- 이한준 -->	
	  <link href="http://fonts.googleapis.com/earlyaccess/nanumgothiccoding.css" rel="stylesheet">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<style type="text/css">

 body{
	
} 

#centerContent{
	background-color: yellow;
	
}

#userListbar{
	max-width: 1023px;
	background-color: darkturquoise;
	border-radius: 7px;
	height: 60px;
	}
	
#title{
	font-family: 'Nanum Gothic Coding', serif;
	font-weight: 700;
	color: white;
	font-size: 24px;
	padding-top: 27px;
	padding-left: 0.2%;
}

.table{
	max-width: 1023px;
	border-color: black;
}

th{
	color: #6e6e77;
}

footer {
      background-color: #555;
      color: white;
      padding: 15px;
    }
    
.sidenav {
      padding-top: 20px;
      background-color: #f1f1f1;
      height: 100%;
      float: right;
    }

@media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      
@media (min-width: 768px)
.col-sm-8 {
    width: 66.66666667%;
}

@media (min-width: 768px)
.col-sm-2 {
    width: 16.66666667%;
}

@media (min-width: 768px)
#centerContent {
    width: 16.66666667%;
}

	 
	 
</style>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>회원관리페이지</title>
</head>
<body>
<%@include file="header.jsp" %>
<script type="text/javascript">
	//전체 선택 체크박스 
	function allSel(bool){
		var chks=document.getElementsByName("chk");//배열로 반환[chk,chk,chk...]
		for (var i = 0; i < chks.length; i++) {
			chks[i].checked=bool;
		}
	}
	//선택 체크박스
	function confirmChk(){
		var chks=document.getElementsByName("chk");//[chk,chk,chk..]
		var count=0;
		for (var i = 0; i < chks.length; i++) {
			if(chks[i].checked){ //체크되어 있으면 true, 아니면 false
				count++;  //체크 되어 있으면 카운트 증가
			}
		}
		if(count==0){// 체크를 안했을 경우
			alert("삭제할 멤버를 선택해주세요.");
		}else if(count>0){
			if(confirm("정말 삭제하시겠습니까?")!=0){
				return count>0?true:false;//true이면 submit실행, false이면 취소
			}else {               
				return false;
			}
		}  
	}	
	
	function confirmChangeGrade(){
		alert("등급이 변경되었습니다.");		
		}

</script>
<%
	AdminDaoImpl dao = new AdminDaoImpl();
%>


<h1 id="title">회원목록</h1>
<div id="userListbar" class="col-sm-8 text-left"> 
<div id="centerContent">
<!-- 체크박스의 회원번호를 submit할 폼 -->
<form action="checkDel.do" method="post" onsubmit="return confirmChk()"> 
<table class ="table">
	<col width="80px">
	<col width="80px">
	<col width="80px">
	<col width="100px">
	<col width="100px">
	<col width="150px">
	<col width="90px">
	<col width="140px">
	<col width="120px">
	<tr>
		<th><input type="checkbox" name="all" onclick="allSel(this.checked)" /></th>
		<th>회원번호</th>
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
				<td>${memberdto.seq}</td>
				<td>${memberdto.id}</td>
				<td>${memberdto.nickname}</td>
				<td>${memberdto.email}</td>
				<td>
				<!-- 회원 등급 변경후 submit하는 폼-->
			<form name="gradeChange" method="post" action="updateGrade.do" >
				<input type="hidden" name="seq" value="${memberdto.seq}" >
					<select name="grade">
						<option value="A" id="adminChk" <c:if test="${memberdto.grade eq 'A'}" >selected</c:if>>관리자</option>
				 		<option value="C" <c:if test="${memberdto.grade eq 'C'}" >selected</c:if>>일반회원</option>
				 		<option value="B" <c:if test="${memberdto.grade eq 'B'}" >selected</c:if>>학원생</option>
					</select>
					<!-- 회원의 등급을 바꿔줌 -->
				<input type="submit" value="변경" onclick="confirmChangeGrade();">
				</td>
				<td>${memberdto.point}</td>
				<td>${memberdto.writeCheck}</td>
				<td>
					<button type="button" onclick="location.href='userDetail.do?seq='+'${memberdto.seq}'">수정</button>
					<button type="button" onclick="location.href='userDelete.do?seq='+'${memberdto.seq}'">삭제</button>		
				</form>		
				</td>
				</tr>
		</c:forEach>
	</c:otherwise>
	</c:choose>
</table>
</div>
	<input type="submit" value="선택삭제"/>
</form>

<script type="text/javascript">
	function userDetail(){
	location.href="userDetail.do";
}

</script>

<div id="회원선택">
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
		<input class="pick" type="radio" name="ns_state_code" checked="checked" value="a"> 공지사항
	  	<input class="pick" type="radio" name="ns_state_code" value="e"> 이벤트
		<input type="submit" value="전송">
	</form>
</div>


</div>
<!-- 이한준 -->
  <div class="col-sm-2 sidenav">
  	<p>LeftsideBar</p>
  </div>

<div class="col-sm-2 sidenav">
	<p>RightsideBar</p>
</div>

<footer class="container-fluid text-center">
	<p>footer</p>
</footer>
</body>
</html>