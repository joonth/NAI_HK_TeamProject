<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/signin.css">	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="resources/js/jsa/jsbn.js"></script>
<script type="text/javascript" src="resources/js/jsa/rsa.js"></script>
<script type="text/javascript" src="resources/js/jsa/prng4.js"></script>
<script type="text/javascript" src="resources/js/jsa/rng.js"></script>
</head>
<body>
<div id="signin-container" class="container">
	<form>
		<h1><img src="./resources/images/detective.png">국과수</h1>
		<div class="input-group">
			<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
			<input type="text" id="id" name="id" class="form-control" placeholder="아이디">
		</div>
		<span id="idChk"></span>
		<div class="input-group">
			<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
			<input type="password" id="pw" name="pw" class="form-control" placeholder="비밀번호">
		</div>
		<span id="pwChk"></span>
	</form>
	
	<!-- 암호화 form -->
	<input type="hidden" id="rsaPublicKeyModulus" value="${publicKeyModules}" />
	<input type="hidden" id="rsaPublicKeyExponent" value="${publicKeyExponent}" />
	<form id="securedLoginForm" name="securedLoginForm" action="signin.do" method="post" style="display: none;">
		<input type="hidden" name="securedId" id="securedId" />
		<input type="hidden" name="securedPassword" id="securedPassword" />
	</form>
	<p><button type="button" id="signinBtn" class="btn btn-primary" >로그인</button></p>
	<p><a href="#" id="findidBtn">아이디찾기</a>
	<a href="#" id="findpwdBtn">비밀번호찾기</a></p>
	<p><a href="signupform.do">국과수에 처음이신가요? 회원가입</a></p>
</div>

<script type="text/javascript">
	$("#findidBtn").click(function(){
		location.href="findidform.do";
	});
	
	$("#findpwdBtn").click(function(){
		location.href="findpwform.do";
	});
	
	$("#signinBtn").click(function(){
	    
		var id =$("#id").val();
	    var pw = $("#pw").val();
	    
	    console.log("id:" + id + " pw: " + pw);
	    
	    if (id == "") {
	    	$("#idChk").html("아이디 입력해주세요");
	    	$("#id").focus();
	        return false;
	    }
	    
	    if (pw == "") {
	    	$("#pwChk").html("비번 입력해주세요");
	    	$("#pw").focus();
	        return false;
	    }
	    
	    try {
	        var rsaPublicKeyModulus = $("#rsaPublicKeyModulus").val();
	        var rsaPublicKeyExponent = $("#rsaPublicKeyExponent").val();
	        submitEncryptedForm(id,pw, rsaPublicKeyModulus, rsaPublicKeyExponent);
	    
	    } catch(err) {
	        alert(err +" 에러!!!!!");
	    }
	    return false;		
	});

function submitEncryptedForm(id, pw, rsaPublicKeyModulus, rsaPpublicKeyExponent) {
    
	var rsa = new RSAKey();
    rsa.setPublic(rsaPublicKeyModulus, rsaPpublicKeyExponent);
    // 사용자ID와 비밀번호를 RSA로 암호화한다.
    var securedId = rsa.encrypt(id);
    var securedPassword = rsa.encrypt(pw);
    
    // POST 로그인 폼에 값을 설정하고 발행(submit) 한다.
    $("#securedId").val(securedId);
    $("#securedPassword").val(securedPassword);
    $("#securedLoginForm").submit();
}
</script>
</body>
</html>