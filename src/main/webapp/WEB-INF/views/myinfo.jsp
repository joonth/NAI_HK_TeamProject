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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui
.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>

<body>
<form action="updatemyinfo.do" method="post" onsubmit="return checkRegx();">
<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog">  
	<!-- Modal content-->
		<div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">학원명 검색</h4>
        </div>
		<div class="modal-body">
			<input type="text" autofocus="autofocus" id="searchAcName" name="searchAcName" placeholder="학원명">      
			<button type="button" id="searchBtn2" class="btn btn-default" >검색</button>
        </div>
        <div class="modal-footer">
			<div id="searchAcNmResult" style="float: left;"></div>
			<div id="searchBtns" style="float: right;">
			<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
        	<button type="button" id="searchSubmitBtn" class="btn btn-default">확인</button>
        	</div>
        </div> 
		</div>
	</div>
</div>
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
			<button type="button" id="searchBtn" data-toggle="modal" data-target="#myModal">검색</button></td>	
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
<a href="myacademylist.do">찜한 학원 보기</a>
<a href="withdrawform.do">회원 탈퇴</a>
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
/* --------------------학원명 검색----------------------------  */

//입력폼에서 검색 버튼 누를 때 input 값 초기화
$("#searchBtn").click(function(){
	$("#searchAcName").val("");
	$("#searchAcNmResult").text(""); //검색결과 초기화
});

//학원명 검색  자동완성 ajax
$("#searchAcName").autocomplete({
	source:function (request, response){
		$.ajax({
			url : "searchacademyname.do",
			data : {
				"searchAcName" : $("#searchAcName").val()
			},
			datatype : "json",
			method : "post",
			success : function(obj) {
				$("#searchAcNmResult").text("");
				response(
					$.map(obj, function(item){ //item에 obj가 바인딩
							return{
								//label : 화면에 보여지는 텍스트 
								//value : 실제 text태그에 들어갈 값 
								//본인은 둘다 똑같이 줬음 
								//화면에 보여지는 text가 즉, value가 되기때문 
								label: item.data,
								value: item.data
							}
						})//map	
				);
			},
			error : function() {
				alert("서버 통신 실패");
			}
		}) //ajax 
	}, //source
	minLength: 2, //2글자 이상 입력해야 autocomplete 작동
	focus:function(event,ui){ 
		$("#searchAcName").val(ui.item.label);
		return false; 
	},
	select:function(event,ui){
		 // 자동완성 선택되었을 때 이벤트 콜백 함수
		 //ui(object)=>item(object)는 label과 value 속성으로 구성
	 	$("#searchAcName").val(ui.item.label);
	 	return false;
	}
});
//modal 창에 보이게
$("#searchAcName").autocomplete("option", "appendTo","#myModal");

//검색버튼 눌러서 학원명 검색
$("#searchBtn2").click(
	function(){
		$.ajax({
			url : "searchacademyname.do",
			data : {
				"searchAcName" : $("#searchAcName").val()
			},
			datatype : "json",
			method : "post",
			success : function(obj) {
				$("#searchAcNmResult").text("");
				if(obj == ""){
					$("#searchAcNmResult").text("검색결과가 없습니다");
				} else{
					for(var i in obj){
						$("#searchAcNmResult").append("<label><input type='radio' name='radioAcNames' " 
								+" value='"+obj[i].data+"' style='display: none;'>"
								+obj[i].data
								+"</label><br>");
					}
				}						
			},
			error : function() {
				alert("서버 통신 실패");
			}
		}) //ajax 
	});

//모달창 확인 눌렀을 때

	$("#searchSubmitBtn").click(function() {
		console.log($("input[name='radioAcNames']:checked").val());
		$("#academyName").val($("input[name='radioAcNames']:checked").val());
		$("#myModal").modal("hide");
	});


	var cnt = 0;
	$("body").on("click", "label", function() {
		$("label").css("background-color", "transparent");
		console.log(this);
		cnt++;
		if (cnt == 1) {
			$(this).css("background-color", "#E0F8F1");
			cnt--;
		}
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