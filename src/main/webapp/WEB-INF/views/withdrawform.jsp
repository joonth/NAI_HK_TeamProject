<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 탈퇴</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myinfo.css">	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" >
/* 모바일 메뉴 드롭다운 */
$(function(){
	$("#mobile-myinfo-sidemenu-bar ul.mobile-myinfo-sidemenu-sub").hide();
	$("#mobile-myinfo-sidemenu-bar ul.mobile-myinfo-sidemenu-menu li").click(function(){
		$("ul",this).slideToggle("fast");
	});
});
</script>
</head>
<body>
<%@include file="header.jsp" %>
<div id="myinfo-container" class="container">
<!-- 모바일용 사이드메뉴 -->
<div id="mobile-myinfo-sidemenu-bar">
	<ul class="mobile-myinfo-sidemenu-menu">
		<li><a href="mypage.do">마이페이지</a> <a id="mobile-myinfo-dropdown">▼</a>
			<ul class="mobile-myinfo-sidemenu-sub">
				<li><a href="myacademylist.do">찜한 학원 보기</a></li>
				<li><a href="withdrawform.do">회원 탈퇴</a></li>
			</ul>
		</li>
	</ul>
</div>
<form action="withdraw.do" method="post" onsubmit="return chkWithdraw();">
	<h1>회원 탈퇴</h1>
	<div class="input-group">
		<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
		<input type="text" id="id" name="id" value="${sessionScope.member.id}" readonly="readonly">
	</div>
	<div class="input-group">
		<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
		<input type="password" id="pw" name="pw" placeholder="Password" >
	</div>
	<div class="input-group">
		<input type="submit" id="submitBtn" value="탈퇴하기" class="btn btn-primary">
	</div>
</form>
</div>
<!-- 사이드 메뉴 -->
<div id="myinfo-sidemenu-bar">
	<ul class="nav nav-pills nav-stacked">
		<li><a href="mypage.do">마이페이지</a></li>
		<li><a href="myacademylist.do">찜한 학원</a></li>
		<li class="active"><a href="withdrawform.do">회원 탈퇴</a></li>
	</ul>
</div>
<script type="text/javascript">
	function chkWithdraw(){
		console.log("withdraw 진입 ");
		console.log("아디: " + $("#id").val() + "비번: " + $("#pw").val());
		var chk = confirm("탈퇴하시겠습니까?");
		if(chk == false){
			return false;
		}
		return true;
	};
</script>
</body>
</html>