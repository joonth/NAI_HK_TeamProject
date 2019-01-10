<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 찾기</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/signin.css">	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
<div id="signin-container" class="container">
	<form>
			<h3>아이디 찾기<img src="./resources/images/magnifying-glass.png"></h3>
			<div class="input-group">
				<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
				<input type="text" id="email" name="email" class="form-control" placeholder="이메일">
			</div>
			<span id="emailChk"></span>
	</form>
	<p><button type="button" id="emailBtn" class="btn btn-primary">확인</button></p>
	<p><a href="#" id="signinBtn">로그인하기</a></p>
	<p><a href="#" id="findpwdBtn">비밀번호 찾기</a></p>
</div>
<script type="text/javascript">

$("#signinBtn").click(function(){
	location.href="signinform.do";
});
$("#findpwdBtn").click(function(){
	location.href="findpwform.do";
});
$("#emailBtn").click(function(){
	
	$.ajax({
		url : "findid.do",
		data : {
			"email" : $("#email").val()
		},
		datatype : "json",
		method : "post",
		success : function(obj) {
			var result = obj["result"];
			$("#emailChk").html(result);
		},
		error : function() {
			alert("서버 통신 실패");
		}
	})
	
});

</script>
</body>
</html>