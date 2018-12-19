<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>아이디 찾기</title>
</head>
<body>
<h3>아이디 찾기</h3>
<table>
		<tr>
			<th>이메일</th>
			<td><input type="text" id="email" name="email"></td>
			<td><span id="emailChk"></span></td>
		</tr>
		<tr>
			<td><input type="button" id="emailBtn" value="아이디찾기"></td>
		</tr>
</table>
<a href="#" id="signinBtn">로그인하기</a>
<a href="#" id="findpwdBtn">비밀번호찾기</a>
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