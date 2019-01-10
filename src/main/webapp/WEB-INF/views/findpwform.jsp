<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE>
<html>
<head>
<link rel="shortcut icon" href="./resources/images/favicon.ico">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비번 찾기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
<h3>비번 찾기</h3>
<table>
		<tr>
			<th>아이디</th>
			<td><input type="text" id="id" name="id"></td>
			<td><span id="idChk"></span></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" id="email" name="email"></td>
			<td><span id="emailChk"></span></td>
		</tr>
		<tr>
			<th>이메일로 임시 비밀번호 전송</th>
			<td><input type="button" id="emailBtn" value="전송"></td>
		</tr>
</table>
<a href="#" id="signinBtn">로그인하기</a>
<a href="#" id="findiddBtn">아이디찾기</a>
<script type="text/javascript">

$("#signinBtn").click(function(){
	location.href="signinform.do";
});

$("#findidBtn").click(function(){
	location.href="findidform.do";
});

$("#emailBtn").click(function(){
	
	$.ajax({
		url : "sendpwmail.do",
		data : {
			"id" : $("#id").val(),
			"email" : $("#email").val()
		},
		datatype : "json",
		method : "post",
		success : function(obj) {
			var msg = obj["msg"];
			alert(msg);
		},
		error : function() {
			alert("서버 통신 실패");
		}
	})
	
});

</script>
</body>
</html>