<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div class="container">
		<c:choose>
			<c:when test="${dto.ns_state_code eq 'a'}">
				<span class="glyphicon glyphicon-bullhorn" style="color:red;"></span>
			</c:when>
			<c:otherwise>
				<span class="glyphicon glyphicon-gift" style="color:yellow;" ></span>
			</c:otherwise>
		</c:choose>
		${dto.n_time}
		<div class="jumbotron">
			${dto.n_content}
		</div>
	</div>
	<a href="getMessageList.do?n_receiver=${sessionScope.member.id}">뒤로</a>
</body>
</html>