<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/signup.css">	
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui
.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<form action="signup.do" method="post" onsubmit="return checkRegx();">
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
<div id="signup-container" class="container">
	<h3>회원 가입</h3>
	<div class="input-group">
		<span class="input-group-addon"></span>
		<input type="text" id="id" name="id"class="form-control" placeholder="아이디" >
	</div>
	<span id="idChk"></span>
	<div class="input-group">
		<span class="input-group-addon"></span>
		<input type="password" id="pw" name="pw" class="form-control" placeholder="비밀번호">
	</div>
	<span id="pwChk"></span>
	<div class="input-group">
		<span class="input-group-addon"></span>
		<input type="password" id="pw2" name="pw2" class="form-control" placeholder="비밀번호 확인" >
	</div>
	<span id="pw2Chk"></span>		
	<div class="input-group">
		<span class="input-group-addon"></span>
		<input type="text" id="nickname" name="nickname" class="form-control" placeholder="닉네임">
	</div>	
	<span id="nicknameChk"></span>
	<div class="input-group">
		<span class="input-group-addon"></span>
		<input type="text" id="email" name="email" class="form-control" placeholder="이메일">	
	</div>	
	<span id="emailChk"></span>
	<div class="input-group">
		<span class="input-group-addon"></span>
		<input type="text" id="academyName" name="academyName" class="form-control" placeholder="학원명">		
		<button type="button" id="searchBtn" data-toggle="modal" data-target="#myModal" class="btn btn-primary">검색</button>
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
			<input type="radio" id="c" name="grade" value="C" checked="checked" onclick="return false;"> 일반
		</label>
		<label class="radio-inline">
			<input type="radio" id="b" name="grade" value="B" onclick="return false;"> 학원생
		</label>	
	</div>				
	<p><input type="submit" id="submitBtn" value="가입하기" class="btn btn-primary"></p>
</div>
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
 	$("#searchSubmitBtn").click(	
		function(){
			console.log($("input[name='radioAcNames']:checked").val());
			$("#academyName").val($("input[name='radioAcNames']:checked").val());
			$("#myModal").modal("hide");
		}		
	); 

	//학원명 선택시 배경색 변경
	var cnt =0;
	$("body").on("click","label",function(){
		$("label").css("background-color","transparent");
		console.log(this);
		cnt++;
		if(cnt == 1 ){
			$(this).css("background-color","#E0F8F1");
			cnt--;
		}
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
	
	var checkDoubleSmtFlag=true;
	
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
		
		//submit 중복 방지
		if(checkDoubleSmtFlag){
			checkDoubleSmtFlag = false;
		} else {
			alert("중복 submit X");
			return false;
		}
		
		return true;

	}
</script>
</body>
</html>