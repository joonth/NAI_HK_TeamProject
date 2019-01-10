<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="./resources/images/favicon.ico">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 수정</title>
</head>
<body>
<%@include file="header.jsp" %>
<div>
<h2>게시글 수정하기</h2>
<form action="boardupdate.do" method="post">
<input type ="hidden" name="b_seq" value="${dto.b_seq}" />
<input type ="hidden" name="page" value="${cri.page}" />

	<table>
		<tr>
			<th>글 번호</th>
			<td>${dto.b_seq}</td>
		</tr>
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
			<td><input type="text" name="b_title" value="${dto.b_title }" />
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="10" cols="60" name="b_content">${dto.b_content}</textarea></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="수정완료"/>
				<button type="button" onclick="location.href='detailboard.do?page=${cri.page}&b_seq=${dto.b_seq}'">취소</button>
			</td>
		</tr>
	</table>		
</form>
</div>
</body>
</html>