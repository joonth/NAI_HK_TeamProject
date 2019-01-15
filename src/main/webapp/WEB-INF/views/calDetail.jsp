<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>캘린더상세보기</title>
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100|Noto+Sans+KR:400|Do+Hyeon" rel="stylesheet">
<style type="text/css">

#wrap{
	width:620px;
	height:450px;
	margin: 0 auto;
	border-color: black;
	box-shadow: 5px 5px 5px;
    text-align: left;
    padding-right: 25px;
    padding-left: 25px; 
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 2px 3px rgba(10,10,10,.1), 0 0 0 1px rgba(10,10,10,.1);
    padding: 1.25rem;
    flex: 1 1 auto;
    flex-direction: column;
    background: #fff;
    color: rgba(0,0,0,.87);
}

#acaTitle{
	margin-top: 1%;
    font-weight: bolder;
    font-family: 'Godo', sans-serif;

}
.row{
  	margin: 0 auto;
}

.row >img{
    text-align: center;
    width: 400px;
    height: 150px;
    margin-top: 1.5%;
}

.line{
    border-top-style: solid;
    border-top-color: #dd4b39;
    margin-top: 8px;
}

#detailContent{
	margin: 0 auto;

}

.calDetail{
	width: 500px;
	margin-top: 1%;
	box-shadow: 1px 2px 2px #ddd;
	border-color: black;
	margin-bottom:20px;

}

.calDetail th{
	padding: 14px 10px 14px 20px;
    background: #f5f5f5;
    color: #333;
    text-align: left;
    vertical-align: top;

}

.calDetail td{
    padding-left: 20px;
    font-family: 'Noto Sans KR', sans-serif;
    color: #666;
    vertical-align: middle;
    border-bottom: 1px solid #e5e5e5;
    letter-spacing: 0;
}


</style>
</head>
<body>
	<div id="wrap">
		<strong id="acaTitle"><c:out value="${calDto.ac_name}" /></strong>
		<div class="line"></div>
		<div class="row">
			<img alt="<c:out value="${calDto.ac_name}"/>"
				src="<c:out value="${calDto.img}"/>"
				style="text-align: center; width: 400px; height: 150px;">
		</div>

	<div id="detailContent">
		<table class="calDetail">
				<tr>
					<th><strong>과정명 </strong></th>
					<td><c:out value="${calDto.ac_class}" /></td>
				</tr>
				<tr>
					<th><strong>장소</strong></th>
					<td><c:out value="${calDto.ac_location}" /></td>
				</tr>
				<tr>
					<th><strong>훈련기간</strong></th>
					<td><c:out value="${calDto.ac_cre_date}" /> ~ <c:out
							value="${calDto.ac_end_date}" /></td>
				</tr>
		</table>
	</div>
	</div>
</body>
</html>