<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/hj/header.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

 <style type="text/css">
 	body {
 	margin:0;
 	height:100%;
 	background-color: #f6f6f6;
 	}

#icon-bar {
  right: 1px;
  position: fixed;
  top: 40%;
  -webkit-transform: translateY(-50%);
  -ms-transform: translateY(-50%);
  transform: translateY(-50%);
}

#icon-bar a {
  display: block;
  text-align: center;
  padding: 16px;
  transition: all 0.3s ease;
  color: black;
  font-size: 20px;
}

#icon-bar a:hover {
  background-color: #343;
}

.ac {
  color: black;
}
.f-left {
    float: left;
}

.navbar-brand {
    font-size: 25px;
    font-weight: bolder;
    color: rgba(255,255,255,.699);
    float: left;
    height: 50px;
    padding: 15px 15px;
    line-height: 32px;
}

.nav-logo-img{
	   width: 33px;
    margin: -5px 0px 0px -5px;
    float: left;
}

.nav-content{
    font-size: 20px;
    font-weight: bolder;
    padding: 18px 15px;
    position:absolute;
}

.nav-right{
    font-family: 'Godo', sans-serif;
    font-size: 18px;
    font-weight: bold;
    margin-top: 14px;
    margin-right: 10px;
    text-decoration: none;
    text-align: right;
    float: right;
}
.navbar{
	background:linear-gradient(to right,#369,#885195);
}
a{
	    color: rgba(255,255,255,.699);
}

#if{
	max-width: -webkit-fill-available;
}
 </style>
</head>

<body>
	<div class="navbar">
		<div class="container-fluid">
			<div class="f-left nav-logo">
				<a class="navbar-brand" href="main.do">
					<img class="nav-logo-img" alt="logo" src="./resources/images/logo.png">
					<span class="f-left">&nbsp; NAI</span>
				</a>
			</div>
			
			<div class="col-sm-10">
				<div class="nav-content">
			 	<input id="session" type="hidden" value="${sessionScope.member.id}" >
				<!-- 세션이 있을 때만 = 로그인되어있을 때만  -->
				<c:if test="${sessionScope.member!=null}">
					<a href="mypage.do">마이페이지</a>
					<a href="main.do">메인</a>
					<a href="calendar.do">캘린더</a>
					<a href="boardlist.do?page=1&pagelist=first">게시판</a>
					<a href="userList.do">회원목록</a>
				</c:if>
				</div>
			</div>
			<div class="nav-right">
					<span>${sessionScope.member.nickname} 님 환영합니다</span>
					<a href="signout.do">로그아웃</a>
					<span id="count" onclick="changeUrl('getMessageList.do?n_receiver=${sessionScope.member.id}')" class="glyphicon glyphicon-envelope" data-toggle="modal" data-target="#myModal" >message</span>
			</div>
		</div>
	</div>
		
	
	<!-- 찜한 학원  -->
	<div id="icon-bar">
		<span>내가 찜한 학원</span>
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