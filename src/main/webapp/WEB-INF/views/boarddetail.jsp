<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 상세보기</title>
</head>
<body>
<%@include file="header.jsp" %>
<h2>게시글 상세보기</h2>
<form method="post">
<input type ="hidden" name="b_seq" value="${dto.b_seq}" />
<input type ="hidden" name="page" value="${cri.page}" />
<input type ="hidden" name="perPageNum" value="${cri.perPageNum}" />
<input type="hidden" name="pagelist" value="${dto.pagelist}" />
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
	<tr>
		<td colspan="2">
			<c:if test="${sessionScope.member.nickname eq dto.m_nick}">
				<button type="button" onclick="updateForm('${dto.b_seq}')">수정</button>
				<button type="button" onclick="delBoard('${dto.b_seq}')">삭제</button>
			</c:if>
			<button type="button" onclick="location.href='boardlist.do?page=${cri.page}&pagelist=${pagelist}'">글목록</button>
		</td>
	</tr>
</table>
<br /><br />
<%@include file="reply.jsp" %>


<script type="text/javascript">
	//수정폼으로 이동하는 함수
	function updateForm(b_seq){
		location.href="updateform.do?page=${cri.page}&b_seq="+b_seq;
	}
	//게시글 삭제로 이동
	function delBoard(b_seq){
		location.href="delboard.do?page=${cri.page}&pagelist=${pagelist}&b_seq="+b_seq;
	}
</script>
</body>
</html>