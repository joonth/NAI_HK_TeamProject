<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script type="text/javascript">
		//뒤로가기 눌렀을때 메인으로 돌아가기
		history.pushState(null, null, location.href); 
		window.onpopstate = function(event) { 
			location.href="main.do";
		}
		
		$(document).ready(function(){
			var frm = $('#commentForm');
			
			frm.submit(function (e) {
			    e.preventDefault();
			    $.ajax({
			        type: frm.attr('method'),
			        url: frm.attr('action'),
			        data: frm.serialize(),
			        success: function (data) {
			            console.log('Submission was successful.');
		            	var cmt = data.dto;
				       	if(cmt.ac_comment != 'false'){				       		
				       		$('#comment').append('<div class="table-row">'+ cmt.ac_name+" "+cmt.m_id+" "+cmt.ac_comment+" "+cmt.ac_score +'</div>');
				       	}else{
				       		alert('등록한 학원이 다르거나, 이미 학원평을 작성했습니다.');
				       	}
			        },
			        error: function (data) {
			            console.log('An error occurred.');
			        },
			    });
			}); 
		
			});
	</script>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<style type="text/css">
			.table { display:table; }
			.table-row { display:table-row; }
			.table-cell { display:table-cell; }
		</style>
	</head>
<body>
<%@include file="header.jsp" %>

	<div class="table">
		<div class="table-row"> <img alt="img" src="${infoDto.img}"></div>
		<div class="table-row">${infoDto.addr1} ${infoDto.addr2}</div>
		<div class="table-row">${infoDto.hpaddr}</div>
		<div class="table-row">${infoDto.inonm}</div>
		<div class="table-row">${infoDto.trprchaptel}</div>
		<div class="table-row">${infoDto.trprnm}</div><br>
	</div>
	<div class="table">
		<c:choose>
			<c:when test="${empty list}">
			<div id="comment">
				<div class="table-row">---작성된 글이 없습니다.---</div>
			</div>
			</c:when>
			<c:otherwise>
			<div id="comment">
				<c:forEach var = "dto" items="${list}">
					<div class="table-row">
						${dto.ac_name}
						${dto.m_id}
						${dto.ac_comment}
						${dto.ac_score}
					</div>
				</c:forEach>
			</div>
			</c:otherwise>
		</c:choose>
		<form id="commentForm" action="addComment.do">
	
			<input type="hidden" name="ac_name" value="${infoDto.inonm}">
			<input type="hidden" name="m_id" value="${sessionScope.member.nickname}" readonly>
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
	</div>
</body>
</html>