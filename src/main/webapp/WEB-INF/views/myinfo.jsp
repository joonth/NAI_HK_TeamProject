<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<%@include file="header.jsp" %>
<link rel="shortcut icon" href="./resources/images/favicon.ico">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myinfo.css">	
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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
<form action="updatemyinfo.do" method="post" onsubmit="return checkRegx();">
	<!-- Modal -->
	<div class="modal fade" id="yourModal" role="dialog">
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
	
<!-- 	황인후 추가 -->
	<input type="hidden" name="ori_nick" value="${member.nickname}" />
<!-- 	추가끝 -->
	<div class="input-group">
		<span class="input-group-addon"></span>
		<input type="text" id="id" name="id" value="${member.id}" class="form-control" readonly="readonly">
	</div>
	<span id="idChk"></span>
	<div class="input-group">
		<span class="input-group-addon"></span>
		<input type="password" id="pw" name="pw" value="" class="form-control" placeholder="비밀번호">
	</div>
		<span id="pwChk"></span>
	<div class="input-group">
		<span class="input-group-addon"></span>
		<input type="password" id="pw2" name="pw2" value="" class="form-control" placeholder="비밀번호 확인" >
	</div>
	<span id="pw2Chk"></span>
	<div class="input-group">
		<span class="input-group-addon"></span>
		<input type="text" id="nickname" name="nickname" value="${member.nickname}" class="form-control">
	</div>	
	<span id="nicknameChk"></span>
	<div class="input-group">
		<span class="input-group-addon"></span>
		<input type="text" id="email" name="email" value="${member.email}" class="form-control">
	</div>	
	<span id="emailChk"></span>
	<div class="input-group">
		<span class="input-group-addon"></span>
		<input type="text" id="academyName" name="academyName" value="${auth.academyName}">	
		<button type="button" id="searchBtn" data-toggle="modal" data-target="#yourModal" class="btn btn-primary">검색</button>	
	</div>
	<span style="font-size:12px;">학원생 인증시 이메일로 전송된 인증코드를 등록해야합니다</span>
	<button type="button" id="authBtn" class="btn btn-primary">인증코드 받기</button>
	<div class="input-group">
		<span class="input-group-addon"></span>
		<input type="text" id="authcode" name="authcode" class="form-control" placeholder="인증코드 입력">
		<button type="button" id="authBtn2" class="btn btn-primary">확인</button>
	</div>
	<div class="input-group">
		<label class="radio-inline">
			<c:choose>
				<c:when test="${member.grade == 'C'}">
					<input type="radio" id="c" name="grade" value="C" checked="checked" onclick="return false;"> 일반
				</c:when>
				<c:when test="${member.grade == 'B'}">
					<input type="radio" id="b" name="grade" value="B" checked="checked" onclick="return false;"> 학원생
				</c:when>
			</c:choose>
		</label>			
	</div>
	<div class="input-group">
		<span class="input-group-addon"></span>
		<input type="text" id="point" class="form-control" readonly="readonly" placeholder="포인트  ${member.point}">
	</div>
	<p><input type="submit" id="submitBtn" value="수정하기" class="btn btn-primary" ></p>
</form>
</div>
<!-- 사이드 메뉴 -->
<div id="myinfo-sidemenu-bar">
	<ul class="nav nav-pills nav-stacked">
		<li class="active"><a href="mypage.do">마이페이지</a></li>
		<li><a href="myacademylist.do">찜한 학원</a></li>
		<li><a href="withdrawform.do">회원 탈퇴</a></li>
	</ul>
</div>

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
 				$("#email").focus();
				return false; 
			} else {
				$("#emailChk").html("");
			}
			return true; 
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
$("#searchAcName").autocomplete("option", "appendTo","#yourModal");
//검색버튼 눌러서 학원명 검색
$("#searchBtn2").click(
	function (){
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
						console.log("in" + +obj[i].data);
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
		$("#yourModal").modal("hide");
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

		
	if($("#pw").val().length > 0) {
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
	} else if($("#pw").val().length == 0) {
		console.log("val"+$("#pw").val());
		console.log($("#pw").val().length);
		console.log("비번 변경x");
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