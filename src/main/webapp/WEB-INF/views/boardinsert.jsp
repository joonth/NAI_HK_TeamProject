<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="./resources/images/favicon.ico">
<link rel="stylesheet" type="text/css" href="./resources/css/board.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 쓰기</title>
</head>
<body>
<script type="text/javascript" src="http://code.jquery.com/jquery-Latest.js"></script>
<script type="text/javascript">
	//$function(){} ->onload ,$(document).ready())
	$(function(){
		//form에서 submit이벤트가 발생하면 function()기능 실행~~~
		$("form").submit(function(){
			var tds = $("form table td"); //[td,td,td,td] 
			var tdVals = tds.slice(0,tds.length-1)   //마지막 td를 제외시키기위해 --> [td,td,td]
			var bool = true;
			tdVals.each(function(){     //each --> 배열의 길이만큼 함수를 실행
				if($(this).children().eq(0).val()==""){  //this --> 첫번째실행은 첫번째td  두번째 실행은 두번쨰td ...td안에 첫번째요소의 val값이 ""인지 확인
					alert($(this).prev("th").text() + "를 입력해주세요!");
					$(this).children().eq(0).focus();
					bool = false;
					return false;
				}        
			});//each
			return bool;
		});//submit
	});
</script>
</head>
<body>
<%@include file="header.jsp" %>
<div>
<h2 style="text-align:center">게시글 작성</h2>
<br /><br />
    <form action="insertboard.do" method="post">
    <input type="hidden" name="pagelist" value="${dto.b_regdate }"/>
    	
        <table class="table table-striped" id="table-container">
        	<col width="100px"><col width="400px">
        	<tr>
        		<th>작성자</th>
        		<td><input type="text" name="m_nick" value="${sessionScope.member.nickname}" readonly="readonly" class="form-control" /></td>
        	</tr>
        	<tr>
        		<th>제목</th>
        		<td><input type="text" name="b_title"  class="form-control" placeholder="제목을 작성해주세요" maxlength="50" /></td>
        	</tr>
        	
        	<tr>
        		<th>내용</th>
        		<td><textarea class="form-control"rows="20" cols="50" name="b_content" placeholder="내용을 작성해주세요"></textarea></td>
        	</tr>
        	
        	<tr>
        		<td colspan="2">
        			<div style="text-align:center">
        			<br />
        			<input type="submit" value="글 등록" class="btn btn-default"/> 
					<button type="button" onclick="location.href='boardlist.do?page=1&pagelist=${pagelist}'" class="btn btn-default">취소</button>
					</div>
				</td>
        	</tr>
        </table>
    </form>

</div>
</body>
</html>