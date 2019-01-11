<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link rel="shortcut icon" href="./resources/images/favicon.ico">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
		<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
		<script src="//netdna.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
		<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/hj/messagelist.js"></script>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	</head>
	<body>
		<input type="hidden" id="rec" value="${n_receiver}" >
		<table class="table table-hover">
				<tr>
					<th colspan="1" width="18%">date</th>
					<th colspan="1" width="8">type</th>
					<th colspan="1" width="69">contents</th>
					<th colspan="1" width="5"></th>
				</tr>
			<c:choose>
				<c:when test="${empty list}">
					<tr><td colspan="6">---작성된 글이 없습니다.---</td></tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${list}" var="dto">
						<tr onclick="window.location='getMessage.do?n_seq=${dto.n_seq}'" style="font-size:15px;">
							<td>${dto.n_time}</td>
							<c:choose>
								<c:when test="${dto.ns_state_code eq 'a'}">
									<td>
										<span class="glyphicon glyphicon-bullhorn" style="color:red;"></span>
									</td>
								</c:when>
								<c:otherwise>
									<td>
										<span class="glyphicon glyphicon-gift" style="color:yellow;" ></span>
									</td>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${fn:length(dto.n_content)>20}">
									<td>${fn:substring(dto.n_content, 0,20)}...</td>
								</c:when>
								<c:otherwise>
									<td>${dto.n_content}</td>
								</c:otherwise>
							</c:choose>
							<td>
								<a id="delete" href="deleteMessage.do?n_seq=${dto.n_seq}&n_receiver=${sessionScope.member.id}">
									<span class="glyphicon glyphicon-trash"></span>
								</a>
							</td>		
						</tr>
						<input type="hidden" id="session" value="${dto.n_receiver}" >
					</c:forEach>
				</c:otherwise>		
			</c:choose>
		</table>
	</body>
</html>