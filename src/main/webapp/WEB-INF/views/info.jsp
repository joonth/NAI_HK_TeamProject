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
	<style>
<!--
	.box{
		box-sizing: border-box;
	    margin: 0 0 20px 0;
	    padding: 5px;
	    background-color: white;
	    border-radius: 2px;
	    -webkit-box-shadow: 1px 1px 5px 0px #a8bff9;
	    box-shadow: 1px 1px 5px 0px #a8bff9;
	}
	
	.line{
	border-top-style: solid;
    	border-top-color: #dd4b39;
    	margin-bottom: 15px;
	}
	
	.innerbox{
		padding: 24px;
	    border-radius: 6px;
	    min-height: 20px;
	    padding: 19px;
	    margin-bottom: 20px;
	    background-color: #f5f5f5;
	    border: 1px solid #e3e3e3;
	    border-radius: 4px;
	    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .05);
	    box-shadow: inset 0 1px 1px rgba(0, 0, 0, .05);
	}
	
	.sectionTitle {
    
    font-weight: bolder;
    font-family: 'Godo', sans-serif;
    /* font-size: 30px; */
	}	
-->
	.center{
    	text-align: -webkit-center;
	}
	#ac_name{
		    font-size: 35px;
    font-style: inherit;
    font-family: 'Godo', sans-serif;
	}
</style>
	
<body>
<%@include file="header.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-sm-11 mobile-p">
		<div class="box">	
			<h3 class="sectionTitle p-01">학원정보</h3>
			<div class="line"></div>
			<div class="row">
				<div class="col-sm-5">
				<img alt="img" width="70%" height="70%" src="${infoDto.img}">
				</div>
				<div class="col-sm-7">
				<div class="row">
				<div class="col-sm-8">
					<span id="ac_name">${infoDto.inonm}</span>							
				</div>
				<div class="col-sm-4">
					<p class="m-t-10">종합 평점</p>
					<div style="CLEAR: both;	PADDING-RIGHT: 0px;	PADDING-LEFT: 0px;	BACKGROUND: url(./resources/images/icon_star2.gif) 0px 0px;	FLOAT: left;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	WIDTH: 90px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
					<p style="WIDTH: ${infoDto.score * 20}%; PADDING-RIGHT:0px;	PADDING-LEFT:0px;	BACKGROUND: url(./resources/images/icon_star.gif) 0px 0px;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
					</p>
					</div>
					<p class="m-t-10">(${infoDto.score})</p>
				</div>
				</div>
			
				<p class="m-t-10">	${infoDto.addr1}${infoDto.addr2}</p>
				<p class="m-t-10">	${infoDto.hpaddr}</p>
				<p class="m-t-10">	${infoDto.trprchaptel}</p>
			
				</div>
			</div>			
				<button id="bk">찜하기</button>
		
				<div class="innerbox">
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
			</div>
		</div>
		
		<div class="box">
			<h3 class="sectionTitle p-01">개강 과정</h3>
			<div class="line"></div>
			<div class="panel-group">
			<c:forEach var = "dto" items="${aclist}">
			<div class="panel panel-default">
				<div class="panel-heading">
				<h4 class="panel-title row">
					<div class="col-sm-8">
						${dto.title}
					</div>
					<div class="col-sm-3">
					 	${dto.trastartdate} 
					</div>
					<div class="col-sm-1 mobile-m-t-10">
						${dto.dday}			
					</div>
				</h4>
				</div>
			</div>
			</c:forEach>
			</div>
		</div>
		
			<div class="box">	
			<h3 class="sectionTitle p-01">학원 수강평</h3>
			<div class="line"></div>
			<div class="panel-group">
		
			<div class="innerbox">
				<table>
					<c:choose>
						<c:when test="${empty list}">
						<div class="panel panel-default">		
								<div class="panel-body">
									---작성된 글이 없습니다.---
								</div>
						</div>
						</c:when>
						<c:otherwise>
							<c:forEach var = "dto" items="${list}">
								<div class="panel panel-default">
							<div class="panel-heading font-gray">
									${dto.ac_name}
							</div>
							<div class="panel-body">
								<div class="col-xs-3 intvw-left-side">
									<div class="row">
									<div style="CLEAR: both;	PADDING-RIGHT: 0px;	PADDING-LEFT: 0px;	BACKGROUND: url(./resources/images/icon_star2.gif) 0px 0px;	FLOAT: left;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	WIDTH: 90px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
									<p style="WIDTH: ${dto.ac_score * 20}%; PADDING-RIGHT:0px;	PADDING-LEFT:0px;	BACKGROUND: url(./resources/images/icon_star.gif) 0px 0px;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
									</p>
									</div>
									</div>
									<div class="row">
										${dto.ac_score}
									</div>
								</div>
								<div class="col-xs-9 mobile-intvw-p">
									<div class="row">
									${dto.m_id}
									</div>
									<div class="row">
									${dto.ac_comment}
									</div>
							
								</div>
								
										
										
										<c:choose>
											<c:when test="${sessionScope.member.id eq dto.m_id}">
												<button id="delete">삭제</button>
											</c:when>
										</c:choose>
								
							</div>
							</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
			</div>
		</div>
		
		</div>
	</div>
</div>
</body>
</html>