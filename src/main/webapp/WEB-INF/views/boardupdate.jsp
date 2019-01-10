<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 수정</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-Latest.js"></script>
<style type="text/css">
	#table-container{
		width: 1000px;		
		margin: 0 auto; /* 0 :위,아래 auto :좌우를 자동으로 조정*/
		overflow :auto;
	}
</style>
<script type="text/javascript">
	$(function(){	
		$("form").submit(function(){
			var tds = $("form table td");
			var tdVals = tds.slice(0,tds.length-1)
			var bool = true;
			tdVals.each(function(){
				if($(this).children().eq(0).val()==""){
					alert($(this).prev("th").text()+"를 입력해주세요");
					$(this).children().eq(0).focus();
					bool = false;
					return false;
				}
			});
			return bool;
		});
	});
</script>
</head>
<body>
<%@include file="header.jsp" %>

<h2 style="text-align:center">게시글 수정하기</h2>
<br /><br />
<form action="boardupdate.do" method="post">
<input type ="hidden" name="b_seq" value="${dto.b_seq}" />
<input type ="hidden" name="page" value="${cri.page}" />
<div>
	<table class="table" id="table-container">
		<tr>
			<th>작성자</th>
			<td>${dto.m_nick}</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><fmt:formatDate value="${dto.b_regdate}" pattern="yyyy-MM-dd a HH:mm"/></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type="text" name="b_title" value="${dto.b_title }" class="form-control"/>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="20" cols="50" name="b_content" class="form-control">${dto.b_content}</textarea></td>
		</tr>
		<tr>
			<td colspan="2">
			<div style="text-align:center">
			<br />
				<input type="submit" value="수정완료" class="btn btn-default"/>
				<button type="button" class="btn btn-default" onclick="location.href='detailboard.do?page=${cri.page}&b_seq=${dto.b_seq}'">취소</button>
			</div>
			</td>
		</tr>
	</table>
</div>		
</form>

</body>
</html>