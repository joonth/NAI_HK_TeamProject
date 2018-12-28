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
<script type="text/javascript" src="http://code.jquery.com/jquery-Latest.js"></script>
<script type="text/javascript">
	$(function(){
		$("form").submit(function(){
			var tds = $("form table td");
			var tdVals = tds.slice(0,tds.length-1) //마지막 td제거 input값이므로
			var bool = true;
			tdVals.each(function(){
				if($(this).children().eq(0).val()==""){
					alert("빈칸을 채워주세요");
					$(this).children().eq(0).focus();
					bool = false;
					return false;
				}
			})//eact
			return bool;
		});//submit
	});
</script>
</head>
<body>
<!-- 댓글폼 -->
<form action="insertcomment.do?page=${cri.page}&pagelist=${pagelist }" method="post">
	<input type ="hidden" name="b_seq" value="${dto.b_seq}" />
	<table>	
		<tr>
			<td>작성자 : <input type="text" name="m_nick" value="${sessionScope.member.nickname}" readonly="readonly"/></td>
		</tr>	
		<tr><td><textarea rows="5" cols="80" id="r_content" name="r_content" placeholder="댓글을 작성해주세요"></textarea></td></tr>		
		<tr><td><input type="submit" value="댓글작성"/></td></tr>
	</table>
</form>
<!-- 	 댓글목록 출력할위치 -->
<form method="post">
<input type ="hidden" name="page" value="${cri.page}" />
<input type ="hidden" name="perPageNum" value="${cri.perPageNum}" />
<input type ="hidden" name="b_seq" value="${dto.b_seq}" />
<input type="hidden" name="r_seq" value="${cdto.r_seq }" />
</form>
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
	<c:choose>
		<c:when test="${empty list}">
			<tr><td colspan="30">----------------작성된 댓글이 없습니다-------------</td></tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${list}" var="cdto">
			<tr>
				<td>${cdto.r_seq}</td>
				<td>${dto.b_seq}</td>
				<td>${cdto.m_nick}</td>
				<td>${cdto.r_content}</td>
				<td><fmt:formatDate value="${cdto.r_regdate}" pattern="yyyy-MM-dd a HH:mm"/>
				<c:if test="${sessionScope.member.nickname eq cdto.m_nick}">
					<td><button type="button" onclick="updateComment('${cdto.r_seq}')">수정</button></td>
					<td><button type="button" onclick="delComment('${cdto.r_seq}')">삭제</button></td>
				</c:if>
			</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>

<script>
	//댓글 삭제로 이동
	function delComment(r_seq){
		location.href="delcomment.do?page=${cri.page}&perPageNum=${cri.perPageNum}&b_seq=${dto.b_seq}&r_seq="+r_seq;
	}
	//댓글 수폼으로 이동하는 함수
	function updateComment(r_seq){
		location.href="updatecommentform.do?page=${cri.page}&b_seq=${dto.b_seq}&r_seq="+r_seq;
	}
</script>
</body>
</html>