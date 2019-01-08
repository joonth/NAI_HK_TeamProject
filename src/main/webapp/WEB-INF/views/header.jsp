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
 	body {margin:0;height:100%;}

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

 </style>
</head>
<body>
<div id="icon-bar">
<span>내가 찜한 학원</span>
</div>
 	<input id="session" type="hidden" value="${sessionScope.member.id}" >
	<!-- 세션이 있을 때만 = 로그인되어있을 때만  -->
	<c:if test="${sessionScope.member!=null}">
		<span>${sessionScope.member.nickname} 님 환영합니다</span>
		<span id="count" onclick="changeUrl('getMessageList.do?n_receiver=${sessionScope.member.id}')" class="glyphicon glyphicon-bell" data-toggle="modal" data-target="#myModal" >message</span>
		<a href="signout.do">로그아웃</a>
		<a href="mypage.do">마이페이지</a>
	</c:if>
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
		</div >
		</div>
		
</body>
</html>