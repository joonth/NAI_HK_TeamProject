<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="./resources/images/favicon.ico">
<link rel="stylesheet" type="text/css" href="./resources/css/board.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript">
	function checkForm(){
		var r_content = document.getElementById('r_content');
		if(replyForm.r_content.value==""){
			alert("댓글을 작성해주세요");
			r_content.focus();
			return false;
		}
	}
</script>
</head>
<body>
<%@include file="header.jsp" %>
<h2 style="text-align:center">댓글 수정하기</h2>
<br /><br />
<form method="post">
<input type ="hidden" name="b_seq" value="${dto.b_seq}" />
<input type ="hidden" name="page" value="${cri.page}" />
<input type ="hidden" name="perPageNum" value="${cri.perPageNum}" />
</form>
<div id="table-container">
<div>
<table class="table table-bordered">
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
		<td>${dto.b_title}</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="20" cols="50" readonly="readonly" class="form-control">${dto.b_content}</textarea>
	</tr>	
</table>
</div>
<br /><br />
<form action="updatecomment.do" method="post" name="replyForm" onsubmit="return checkForm();">
<input type ="hidden" name="page" value="${cri.page}" /> 
<input type ="hidden" name="perPageNum" value="${cri.perPageNum}" /> 
<input type ="hidden" name="b_seq" value="${dto.b_seq}" /> 
<input type="hidden" name="r_seq" value="${cdto.r_seq }" />
<table class="table table-bordered">	
	<tr>
		<td>
			<textarea rows="4" id="r_content" name="r_content"class="form-control">${cdto.r_content}</textarea>
		</td>
	</tr>	
</table>	
	<div style="text-align:right">
		<input type="submit" value="댓글수정" class="btn btn-primary btn-sm"/>
	</div>	
</form>
</div>
</body>
</html>