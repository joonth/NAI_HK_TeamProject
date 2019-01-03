<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/hj/info.js"></script>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	</head>
<body>
<%@include file="header.jsp" %>
	<table>
		<tr><td><img alt="img" src="${infoDto.img}"></td></tr>
		<tr><td>${infoDto.addr1} ${infoDto.addr2}</td></tr>
		<tr><td>${infoDto.hpaddr}</td></tr>
		<tr><td id="ac_name">${infoDto.inonm}</td></tr>
		<tr><td>${infoDto.trprchaptel}</td></tr>
		<tr><td>${infoDto.trprnm}</td></tr>
		<tr><td><button id="bk">찜하기</button></td></tr>
	</table>
	<table>
		<c:choose>
			<c:when test="${empty list}">
				<tr><td>---작성된 글이 없습니다.---</td></tr>
			</c:when>
			<c:otherwise>
				<c:forEach var = "dto" items="${list}">
					<tr>
						<td>
							${dto.ac_name}
							${dto.m_id}
							${dto.ac_comment}
							${dto.ac_score}
							<c:choose>
								<c:when test="${sessionScope.member.id eq dto.m_id}">
									<button id="delete">삭제</button>
								</c:when>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
		<form id="commentForm" action="addComment.do" method="get">
			<input type="hidden" name="ac_name" value="${infoDto.inonm}">
			<input type="hidden" name="m_id" value="${sessionScope.member.id}" readonly>
			<input type="text" name="ac_comment" placeholder="평을 작성하실때 과정명과 강사님 성함을 넣어주세요~!" >
			<select name="ac_score">
				<option value="5.0">5.0</option>
				<option value="4.5">4.5</option>
				<option value="4.0">4.0</option>
				<option value="3.5">3.5</option>
				<option value="3.0">3.0</option>
				<option value="2.5">2.5</option>
				<option value="2.0">2.0</option>
				<option value="1.5">1.5</option>
				<option value="1.0">1.0</option>
				<option value="0.5">0.5</option>
				<option value="0.0">0.0</option>
			</select>
			<input type="submit" value="글작성">
			<input type="button" value="뒤로가기" onclick="location.href='main.do'">
		</form>
</body>
</html>