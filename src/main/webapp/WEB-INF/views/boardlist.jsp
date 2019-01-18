<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="./resources/images/favicon.ico">
<link rel="stylesheet" type="text/css" href="./resources/css/board.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 목록 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
<%@include file="header.jsp" %>
<h1 style="text-align:center">자유 게시판</h1>

<div id="table-container">
	<div class="right-sort">
		<form action="boardlist.do" method="get">
			<input type="hidden" name="page" value="${cri.page }" />
			<select id="pagelist" name="pagelist" onchange="this.form.submit()" class="select-box">
				<option value="first" ${pagelist=="first"?"selected":"" }>선택</option>
				<option value="b_regdate" ${pagelist=="b_regdate"?"selected":""}>최신순</option>
				<option value="b_readcount" ${pagelist=="b_readcount"?"selected":""}>조회순</option>
				<option value="b_like" ${pagelist=="b_like"?"selected":""}>추천순</option>
				<option value="cmt_count" ${pagelist=="cmt_count"?"selected":""}>댓글순</option>
			</select>
		</form>
	</div>
<br /><br />
	<div >
		<table class="table table-hover">
			<col width = 50px>
			<col width = 100px>
			<col width = 350px>
			<col width = 150px>
			<col width = 50px>
			<col width = 50px>
			<tr>
				<th>글번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>추천수</th>
			</tr>
			<c:choose>
				<c:when test="${empty list}">
					<tr><td colspan="10">--------작성된 글이 없습니다--------</td></tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${list}" var="dto">
						<tr>
							<td>${dto.b_seq}</td>
							<td>${dto.m_nick}</td>
							<td><a href="detailboard.do?page=${cri.page}&b_seq=${dto.b_seq}">${dto.b_title}</a>
							(${dto.cmt_count})
							<td><fmt:formatDate value="${dto.b_regdate}" pattern="yyyy-MM-dd a HH:mm"/></td>
							<td>${dto.b_readcount}</td>
							<td>${dto.b_like }</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>

		</table>

<br />
 	<div class="right-sort">
		<a href='insertform.do?page=${cri.page }'><img src="./resources/images/write.png" ></a>
	</div>
	</div> 
</div>
<br />
<div class="paging-position">
    <!--
        이전 버튼이 클릭가능한 조건이면, a태그를 이용해 이전 버튼이 뜨도록 하며,
    PageMakerDto에서 만든 makeQuery 메서드를 이용한다.
        이전 버튼을 클릭하면 현재 페이지가 시작페이지의 - 1 이 되도록 되어야 함으로 그 부분만 신경써 주면 됩니다.
     -->    
    <c:if test="${pageMaker.prev}">
    	<a href="boardlist.do${pageMaker.makeQuery(pageMaker.startPage - 1)}&pagelist=${pagelist}" class="btn btn-default btn-sm">Prev</a>         
    </c:if>
 	
    <!--
        [1][2][3]....[10] 이 부분을 삽입하는 부분! 
        jstl 이용해 for문을 돌면서 startPage ~ endPage까지  표시해주며, a태그 눌렀을 때 이동하는 page 부분에 index 지정
 	-->
    
    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="index" >
        <a href="boardlist.do?page=${index }&pagelist=${pagelist}" class="btn btn-default btn-sm">${index }</a>
    </c:forEach>

    <c:if test="${pageMaker.next }">       
<!--  이전버튼과 마찬가지로 다음버튼을 끝 페이지보다 1개 큰게 현재 페이지가 되도록 makeQuery에 page를 넣어줌! --> 			
    	<a href="boardlist.do${pageMaker.makeQuery(pageMaker.endPage + 1)}&pagelist=${pagelist}" class="btn btn-default btn-sm">Next</a>	
    </c:if> 

</div>
</body>
</html>