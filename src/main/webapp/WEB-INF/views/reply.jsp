<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="./resources/images/favicon.ico">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style type="text/css">
	#table-container{
		width: 1000px;		
		margin: 0 auto; /* 0 :위,아래 auto :좌우를 자동으로 조정*/
		overflow :auto;
	}
</style>
<script type="text/javascript">
	function checkForm(){
		var r_content = document.getElementById('r_content');
		if(replyForm.r_content.value == ""){
			alert("댓글을 작성해주세요");
			r_content.focus();
			return false;
		}
	}
</script>
</head>
<body>
<!-- 댓글폼 -->
<div id="table-container" >
<form action="insertcomment.do?page=${cri.page}&pagelist=${pagelist }" method="post" id="replyForm" name="replyForm" onsubmit="return checkForm();">
	<input type ="hidden" name="b_seq" value="${dto.b_seq}" />
	<input type="hidden" name="m_nick" value="${sessionScope.member.nickname}" />
	<table class="table table-bordered">	
		<tr>
			<td>
				<textarea rows="4" id="r_content" name="r_content" placeholder="댓글을 작성해주세요" class="form-control"></textarea>
			</td>
		</tr>	
		</table>	
		<div style="text-align:right">
			<input type="submit" value="댓글작성" class="btn btn-primary btn-sm"/>
		</div>	
</form><br /><br />

<!-- 	 댓글목록 출력할위치 -->
<form method="post">
<input type ="hidden" name="page" value="${cri.page}" />
<input type ="hidden" name="perPageNum" value="${cri.perPageNum}" />
<input type ="hidden" name="b_seq" value="${dto.b_seq}" />
<input type="hidden" name="r_seq" value="${cdto.r_seq }" />
</form>
<table class="table">
	<col width="100px">
	<col width="800px">
	<col width="250px">
	<col width="75px">
	<col width="75px">	
	<tr>
		<th>작성자</th>
		<th>내용</th>
		<th>작성일</th>
		<th></th>
		<th></th>
	</tr>
	<c:choose>
		<c:when test="${empty list}">			
			<tr><td colspan="30"><strong>----------------------------------------------------------------------------------------작성된 댓글이 없습니다-----------------------------------------------------------------------------------------</strong></td></tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${list}" var="cdto">
			<tr>
				<td>${cdto.m_nick}</td>
				<td>${cdto.r_content}</td>
				<td><fmt:formatDate value="${cdto.r_regdate}" pattern="yyyy-MM-dd a HH:mm"/></td>
				
				<c:if test="${sessionScope.member.nickname eq cdto.m_nick}">			
					<td><button type="button" onclick="updateComment('${cdto.r_seq}')" class="btn btn-default btn-sm">수정</button></td>
					<td><button type="button" onclick="delComment('${cdto.r_seq}')" class="btn btn-default btn-sm">삭제</button></td>			
				</c:if>			
			</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>
</div>
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