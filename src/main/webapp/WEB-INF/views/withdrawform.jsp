<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE>
<html>
<head>
<link rel="shortcut icon" href="./resources/images/favicon.ico">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 탈퇴</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
<form action="withdraw.do" method="post" onsubmit="return chkWithdraw();">
<table>
	<tr>
		<th>아이디</th>
		<td><input type="text" id="id" name="id" value="${sessionScope.member.id}" readonly="readonly"></td>
	</tr>
	<tr>
		<th>비번확인</th>
		<td><input type="password" id="pw" name="pw" ></td>
	</tr>
	<tr>
		<td>
		<input type="submit" id="submitBtn" value="탈퇴하기" class="btn btn-primary">
		</td>
	</tr>
</table>
</form>
<div>
<ul>
<li><a href="main.do">메인</a></li>
<li><a href="#">캘린더</a></li>
<li><a href="boardlist.do?page=1&pagelist=first">게시판</a></li>
</ul>
</div>
<br>
<div>
마이페이지
<ul>
<li><a href="mypage.do">마이페이지</a></li>
<li><a href="myacademylist.do">찜한 학원 보기</a></li>
<li><a href="withdrawform.do">회원 탈퇴</a></li>
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