<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>찜한 학원 목록</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myinfo.css">	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
<%@include file="header.jsp" %>
<div id="myac-container" class="container">
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
	<h1>찜한 학원</h1>
	<table class="table table-condensed">
	<c:choose>
		<c:when test="${myAcList != null}">
			<c:forEach items="${myAcList}" var="ac">
				<tr>
					<td><a href="info.do?subTitle=${ac.baskAcademyName}" target="_blank">${ac.baskAcademyName}</a></td>
					<td><a href="#"><img src="./resources/images/like.png" alt="하트사진" name="delheart" style="width:28px;"></a></td>
					<td style="display:none;"><input type="checkbox" name="delMyAc" checked="checked" value="${ac.baskSeq}">삭제(체크풀시 삭제)</td>
				</tr>
			</c:forEach>
			<a href="#" id="delAllMyAc"> 전체 삭제</a>
		</c:when>
	</c:choose>
	</table>
</div>
<!-- 사이드 메뉴 -->
<div id="myinfo-sidemenu-bar">
		<ul class="nav nav-pills nav-stacked">
			<li><a href="mypage.do">마이페이지</a></li>
			<li class="active"><a href="myacademylist.do">찜한 학원</a></li>
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
	
	$("img[name='delheart']").click(function(){
		var delchk =  $(this).parent("a").parent("td").next("td").children("input");
		if(delchk.attr('checked',false)){
			$(this).attr('src',"./resources/images/dislike.png");
			ajax(delchk.val(), this);
		}
	});
	
	function ajax(data, delheart){
		$.ajax({
			url: "delmyacademy.do",
			data: {"myAcSeq":data},
			datatype:"json",
			method: "post",
			success:function(obj){ //컨트롤에서 전달받은 객체map -> obj
				var msg = obj["msg"];
				setTimeout(function() {
					$(delheart).parent("a").parent("td").parent("tr").remove();
				}, 1000);
				
			},
			error: function(){
				alert("서버 통신 실패");
			}
		})
	};
</script>
</body>
</html>