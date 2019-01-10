<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<link rel="shortcut icon" href="./resources/images/favicon.ico">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>찜한 학원 목록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
<h1>찜한 학원 목록</h1>
<table border="1">
<c:choose>
	<c:when test="${myAcList != null}">
		<c:forEach items="${myAcList}" var="ac">
			<tr>
				<td><a href="info.do?subTitle=${ac.baskAcademyName}" target="_blank">${ac.baskAcademyName}</a></td>
				<td><input type="checkbox" name="delMyAc" checked="checked" value="${ac.baskSeq}">삭제(체크풀시 삭제)</td>
			</tr>
		</c:forEach>
	</c:when>
</c:choose>
</table>
<a href="#" id="delAllMyAc">전체 삭제</a>
<br>
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
	//전체 삭제
	$("#delAllMyAc").click(function(){
		var myAcSeqs = $("input[name='delMyAc']:checked").val();
		$("input[name='delMyAc']:checked").parent("td").parent("tr").remove();
		ajax(myAcSeqs);
	});
	
	$("input[name='delMyAc']").click(function(){
		if($(this).attr('checked',false)){

			var myAcSeq = $(this).val();
			$(this).parent("td").parent("tr").remove();
			ajax(myAcSeq);

		}
	});
	
	function ajax(data){
		$.ajax({
			url: "delmyacademy.do",
			data: {"myAcSeq":data},
			datatype:"json",
			method: "post",
			success:function(obj){ //컨트롤에서 전달받은 객체map -> obj
				var msg = obj["msg"];
				console.log(msg);
			},
			error: function(){
				alert("서버 통신 실패");
			}
		})
	};
</script>
</body>
</html>