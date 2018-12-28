<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

</head>

<body>
<form action="updatemyinfo.do" method="post" onsubmit="return checkRegx();">
<h1>마이페이지</h1>
<table>
		<tr>
			<th>아이디</th>
			<td><input type="text" id="id" name="id" value="${member.id}" readonly="readonly"></td>
			<td><span id="idChk"></span></td>
		</tr>
		<tr>
			<th>비번</th>
			<td><input type="password" id="pw" name="pw" ></td>
			<td><span id="pwChk"></span></td>
		</tr>
		<tr>
			<th>비번 확인</th>
			<td><input type="password" id="pw2" name="pw2" ></td>
			<td><span id="pw2Chk"></span></td>
		</tr>		
		<tr>
			<th>닉네임</th>
			<td><input type="text" id="nickname" name="nickname" value="${member.nickname}"></td>		
			<td><span id="nicknameChk"></span></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" id="email" name="email" value="${member.email}"></td>	
			<td><span id="emailChk"></span></td>
		</tr>
		<tr>
			<th>학원명</th>
			<td>
					<input type="text" id="academyName" name="academyName" value="${auth.academyName}">	
			</td>	
		</tr>
		<tr>
			<th>(학원생 인증을 원할 경우 전송된 인증코드를 등록해야합니다)</th>
			<td><a href="#" id="authBtn">인증코드 받기</a></td>
		</tr>
		<tr>
			<th>인증코드</th>
			<td><input type="text" id="authcode" name="authcode" placeholder="인증코드 입력"></td> 		
		</tr>
		<tr>
			<th>인증코드 확인</th>
			<td><a href="#" id="authBtn2">인증 확인</a></td> 		
		</tr>
		<tr>
			<th>등급</th>
			<td>
			
			<c:choose>
				<c:when test="${member.grade == 'C'}">
					<input type="radio" id="c" name="grade" value="C" checked="checked" onclick="return false;"> 일반
				</c:when>
				<c:when test="${member.grade == 'B'}">
					<input type="radio" id="b" name="grade" value="B" checked="checked" onclick="return false;"> 학원생
				</c:when>
			</c:choose>
			</td>		
		</tr>				
		<tr>
			<td colspan="2">
			<!-- 여러번못하게 하려면? -->
				<input type="submit" id="submitBtn" value="수정하기" class="btn btn-primary">
			</td>
		</tr>
</table>
</form>
<a href="main.do">메인</a>
<a href="#">캘린더</a>
<a href="boardlist.do?page=1&pagelist=b_regdate">게시판</a>
<br>
마이페이지
<a href="mypage.do">마이페이지</a>
<a href="#">찜한 학원 보기</a>
<a href="#">회원 탈퇴</a>
<script type="text/javascript">
//닉네임 중복 체크 ajax
$("#nickname").focusout(function() {
	$.ajax({
		url : "nicknamecheck.do",
		data : {
			"nickname" : $("#nickname").val()
		},
		datatype : "json",
		method : "post",
		success : function(obj) {
			var msg = obj["msg"];
			if (msg != null) {
				$("#nicknameChk").html(msg);
				$("#nickname").focus();
				return false;
			} else {
				$("#nicknameChk").html("");
			}
			return true;
		},
		error : function() {
			alert("서버 통신 실패");
		}
	})
});

//이메일 중복 체크 ajax
$("#email").focusout(function() {
	$.ajax({
		url : "emailcheck.do",
		data : {
			"email" : $("#email").val()
		},
		datatype : "json",
		method : "post",
		success : function(obj) {
			var msg = obj["msg"];
			if (msg != null) {
				$("#emailChk").html(msg);
				/* 프로토에서는 중복 가능하게 */
/* 				$("#email").focus();
				return false; */
			} else {
				$("#emailChk").html("");
			}
/* 				return true; */
		},
		error : function() {
			alert("서버 통신 실패");
		}
	})
});

//ajax 메일값 받아서 메일 보내기 
$("#authBtn").click(
		function() {

			//중복된이메일이면 인증메일 못보냄 
			var email = $("#email").val();
			var academyName = $("#academyName").val();
			console.log("타입"+typeof(academyName));
			if(academyName != ""){
				alert("인증메일 전송");
				$.ajax({
					url : "sendauthmail.do",
					data : {
						"email" : email,
						"academyName" : academyName
					},
					datatype : "json",
					method : "post",
					success : function(obj) {
						var authcode = obj["authcode"];

						$("#authBtn2").click(
								function() {
									var userAuthcode = $("#authcode").val();
									if (userAuthcode == authcode) {
										alert("인증 성공");
										/* 학원생 체크, 학원명 disabled */
										$("input:radio[id=c]").attr(
												"checked", false);
										$("input:radio[id=b]").attr(
												"checked", true);
									} else {
										alert("인증 실패 이메일을 확인하시고 다시 전송을 누르세요");
									}
								})

					},
					error : function() {
						alert("서버 통신 실패");
					}
				})
				
			} else{
				alert("학원명을 입력하세요!");
			}

});

function checkRegx() {
	//인증생이 아닐 경우(=일반) 학원명을 적었어도 submit 전에 없애줌
	var gradeChk = $("input:radio[name=grade]:checked").val(); 
	if(gradeChk === 'C' && $("#academyName").val() != ""){ //일반
		$("#academyName").val("");
	}
	
	var RegxPw = /^(?=.*[A-Za-z])(?=.*\d)[a-zA-Z\d]{6,20}$/;
	var RegxEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

	if($("#pw").length > 0) {
		console.log("pw 진입");
		if (!RegxPw.test($.trim($("#pw").val()))) {
			$("#pwChk").html("비밀번호는 6~20자 알파벳과 숫자 조합");
			$("#pw").focus();
			return false;
		} else {
			$("#pwChk").html("");
		}
		
		if($("#pw").val() != $("#pw2").val()){
			$("#pw2Chk").html("비밀번호 재확인");
			$("#pw2").focus();
			return false;
		} else {
			$("#pw2Chk").html("");
		}
		console.log("pw 마지막");
	}

	if (!RegxEmail.test($.trim($("#email").val()))) {
		$("#emailChk").html("이메일 형식이 아닙니다");
		$("#email").focus();
		return false;
	} else {
		$("#emailChk").html("");
	}
	
	return true;

}
</script>
</body>
</html>