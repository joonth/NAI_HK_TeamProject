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
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
 <style type="text/css">
 
*{
	font-family: 'Noto Sans KR', sans-serif;
}

body {	
	margin:0 auto;
	height:100%;
	background-color: #f6f6f6;
	font-weight: 400;
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
  background-color: #a9a9a9;
}

#icon-bar h4{
	text-align:center;
}

.ac {
  color: black;
}

.f-left {
    float: left;
}

.navbar-brand {
    color: rgba(255,255,255,.699);
    float: left;
    height: 50px;
    padding: 15px 15px;
    line-height: 32px;
    display:inline-block;
}

.nav-logo-img{
	width: 33px;
    margin: -5px 0px 0px -5px;
    float: left;
}

.nav-content{
    font-size: 18px;
    padding: 8px 15px 10px 15px ;
    display:inline-block;
    font-weight: 100;
}

.nav-title{
	font-size: 26px;
	padding: 0 20px;
	border-right: 2px solid white;
	color: white;
	font-family: 'Do Hyeon', sans-serif;
}

.nav-content a{
	text-decoration:none;
}

/* .nav-right{
    font-size: 18px;
    margin-top: 14px;
    margin-right: 10px;
    text-decoration: none;
    text-align: right;
    float: right;
} */

.nav-image{
    width: 33px;
    margin: -5px -10px 5px -5px;
}

.navbar{
	background:linear-gradient(to right,#369,#885195);
	max-height: 55px;
    overflow: hidden;
    margin-bottom: 0;
	font-weight: 100;
}

a{
	color: rgba(255,255,255,.699);
}

#if{
	max-width: -webkit-fill-available;
}

.container-fluid{
	text-align:center;
	margin:0;
	padding:0;
} 

.info-bar{
	font-weight: bold;
	font-size: 14px;
	color: white;
}

</style>
</head>

<body>
	<div class="navbar">
		<div class="container-fluid">
				<div class="nav-content">
				<a  href="main.do" >
				<img class="nav-image" alt="logo" src="./resources/images/detective.png">
					<span class="nav-title">국비과정수사 NAI</span>
				</a>
				</div>
				<div class="nav-content">
			 	<input id="session" type="hidden" value="${sessionScope.member.id}" >
				<!-- 세션이 있을 때만 = 로그인되어있을 때만  -->
				<c:if test="${sessionScope.member!=null}">
<!-- 					<a href="mypage.do">마이페이지</a> -->
					<a href="main.do">메인</a>
					<a href="calendar.do">캘린더</a>
					<a href="boardlist.do?page=1&pagelist=first">게시판</a>
					<a href="userList.do">회원목록</a>
				</c:if>
				</div>
			<div class="nav-content" style="width:280px; text-align:right; padding: 0 5px 0 0;">
					<span class="info-bar">${sessionScope.member.nickname} 님</span>
					<span style="color:white" id="count" onclick="changeUrl('getMessageList.do?n_receiver=${sessionScope.member.id}')" class="glyphicon glyphicon-envelope" data-toggle="modal" data-target="#myModal" ></span>
			</div>
			<div class="nav-content" style=" padding: 0 5px 0 5px; ">
					<span class="info-bar" style="font-weight: 100;"><a href="mypage.do">마이페이지</a></span>
			</div>
			<div class="nav-content" style="padding: 0 0 0 5px;">
					<span class="info-bar" style="font-weight: 100;"><a href="signout.do">로그아웃</a></span>
			</div>
		</div>
	</div>
		
	
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