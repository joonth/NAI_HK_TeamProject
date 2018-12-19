<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<!-- 
1.이메일인증 누르면 email 정보 받아옴
2.email 값 전달
3.사용자가 입력한 authcode 값 받아옴
4컨트롤러에서 세션에 담은 authcode값과 비교
틀릴경우 번호가 다릅니다 alert
맞을경우 인증되엇습니다 alert ->학원생 checked

*학원명..? 모달창 새로 띄워서 학원명 검색 , 학원(캘린더) 테이블에서 학원명만 가져오기
 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

</head>
<body>
<form action="signup.do" method="post" onsubmit="return checkRegx();">
<table>
		<tr>
			<th>아이디</th>
			<td><input type="text" id="id" name="id"></td>
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
			<td><input type="text" id="nickname" name="nickname"></td>		
			<td><span id="nicknameChk"></span></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" id="email" name="email"></td>	
			<td><span id="emailChk"></span></td>
		</tr>
		<tr>
			<th>학원명</th>
			<td><input type="text" id="academyName" name="academyName"></td>		
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
			<input type="radio" id="c" name="grade" value="C" checked="checked" onclick="return false;"> 일반
			<input type="radio" id="b" name="grade" value="B" onclick="return false;"> 학원생
			</td>		
		</tr>				
		<tr>
			<td colspan="2">
			<!-- 여러번못하게 하려면? -->
				<input type="submit" id="submitBtn" value="확인" class="btn btn-primary">
			</td>
		</tr>
</table>
</form>
<script type="text/javascript">

//아이디 중복 체크 ajax
$("#id").focusout(function(e){

	$.ajax({
			url : "idcheck.do",
			data : {
				"id" : $("#id").val()
			},
			datatype : "json",
			method : "post",
			success : function(obj) {
				var msg = obj["msg"];
				if (msg != null) {
					$("#idChk").html(msg);
					$("#id").focus();
					return false;
				} else {
					$("#idChk").html("");
				}
				return true;
			},
			error : function() {
				alert("서버 통신 실패");
			}
		})

	});

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

	// ajax 메일값 받아서 메일 보내기 
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

	//유효성검사
	function checkRegx() {
		//인증생이 아닐 경우(=일반) 학원명을 적었어도 submit 전에 없애줌
		var gradeChk = $("input:radio[name=grade]:checked").val(); 
		if(gradeChk === 'C' && $("#academyName").val() != ""){ //일반
			$("#academyName").val("");
		}
		
		var RegxId = /^[a-z0-9_]{6,16}$/;
		var RegxPw = /^(?=.*[A-Za-z])(?=.*\d)[a-zA-Z\d]{6,20}$/;
		var RegxEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

		if (!RegxId.test($.trim($("#id").val()))) {
			$("#idChk").html("아이디는 6~16자 알파벳,숫자,특수문자_");
			$("#id").focus();
			return false;
		} else {
			$("#idChk").html("");
		}

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