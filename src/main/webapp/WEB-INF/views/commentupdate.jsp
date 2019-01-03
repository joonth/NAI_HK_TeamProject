<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<%@include file="header.jsp" %>
<h2>게시글 상세보기</h2>
<form method="post">
<input type ="hidden" name="b_seq" value="${dto.b_seq}" />
<input type ="hidden" name="page" value="${cri.page}" />
<input type ="hidden" name="perPageNum" value="${cri.perPageNum}" />
</form>
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
		<td>${dto.b_title}</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" readonly="readonly">${dto.b_content}</textarea>
	</tr>
	
</table>
<br /><br />

<!-- 	 수정댓글목록 출력할위치 -->

<form action="updatecomment.do" method="post">
<input type ="hidden" name="page" value="${cri.page}" />
<input type ="hidden" name="perPageNum" value="${cri.perPageNum}" />
<input type ="hidden" name="b_seq" value="${dto.b_seq}" />
<input type="hidden" name="r_seq" value="${cdto.r_seq }" />
<table>
	<col width="100px">
	<col width="100px">
	<col width="100px">
	<col width="800px">
	<col width="300px">
	<col width="50px">
	<col width="50px">
	<tr>
		<th>댓글번호</th>
		<th>게시글번호</th>
		<th>작성자</th>
		<th>내용</th>
		<th>작성일</th>
	</tr>
	<tr>
		<td style="text-align:center">${cdto.r_seq}</td>
		<td style="text-align:center">${dto.b_seq}</td>
		<td style="text-align:center">${cdto.m_nick}</td>
		<td style="text-align:center;"><textarea rows="5" cols="80" name="r_content">${cdto.r_content}</textarea>
		<td style="text-align:center"><fmt:formatDate value="${cdto.r_regdate}" pattern="yyyy-MM-dd a HH:mm"/></td>
		<td><input type="submit" value="수정완료" /></td>
		<td><button type="button" onclick="location.href='detailboard.do?page=${cri.page}&perPageNum=${cri.perPageNum}&b_seq=${dto.b_seq}'">취소</button></td>
	</tr>
</table>
</form>
</body>
</html>