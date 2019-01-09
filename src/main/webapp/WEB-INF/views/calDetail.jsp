<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>캘린더상세보기</title>
</head>
<body>
<h2>캘린더상세보기</h2>
<table id="calDetailTable">
	<col width="210px">
	<col width="210px">
	<col width="100px">
	<tr>
		<th>이미지</th>
		<td><img alt="<c:out value="${calDto.ac_name}"/>" src="<c:out value="${calDto.img}"/>"></td>
	</tr>
	<tr>
		<th>학원명</th>
		<td><c:out value="${calDto.ac_name}"/></td>
	</tr>
	<tr>
		<th>과정명</th>
		<td><c:out value="${calDto.ac_class}"/></td>
	</tr>
	<tr>
		<th>장소</th>
		<td><c:out value="${calDto.ac_location}"/></td>
	</tr>
	<tr>
		<th>개강일</th>
		<td><c:out value="${calDto.ac_cre_date}"/><td>
	</tr>
	<tr>
		<th>종강일</th>
		<td><c:out value="${calDto.ac_end_date}"/></td>
	</tr>
	
</body>
</html>