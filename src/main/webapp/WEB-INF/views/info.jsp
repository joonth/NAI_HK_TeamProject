<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link rel="shortcut icon" href="./resources/images/favicon.ico">
		<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/hj/info.js"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/info.css">	
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	</head>
	<body>
		<%@include file="header.jsp" %>
		<div class="container">
			<div class="row">
				<div class="col-sm-11 mobile-p">
					<!-- BOX -->
					<div class="box">	
						<h3 class="sectionTitle p-01">학원정보</h3>
						<div class="line"></div>
						<div class="row">
							<div id="centerimg" class="col-sm-5">
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
											<p style="WIDTH: ${infoDto.score * 20}%; PADDING-RIGHT:0px;	PADDING-LEFT:0px;	BACKGROUND: url(./resources/images/icon_star.gif) 0px 0px;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	PADDING-TOP: 0px;	HEIGHT: 18px;"></p>
										</div>
										<p class="m-t-10">(${infoDto.score})</p>
									</div>
								</div>
								<div class="col-sm-8">
									<p class="m-t-10">	${infoDto.addr1}${infoDto.addr2}</p>
									<p class="m-t-10">	${infoDto.hpaddr}</p>
									<p class="m-t-10">	${infoDto.trprchaptel}</p>
								</div>
								<div class="col-sm-2">
									<button id="bk" class="btn btn-default" onclick="msgCheck()">찜하기</button>
								</div>
							</div>
						</div>			
						<div class="panel-group">
							<div class="panel panel-default">
								<div class="panel-heading">
									<h4 class="panel-title row">
										<div class="input-group input-group-lg">
											<form id="commentForm" action="addComment.do" method="get">	
												<input type="hidden" name="ac_name" value="${infoDto.inonm}">
												<input type="hidden" name="m_id" value="${sessionScope.member.id}" readonly>
												<div class="col-sm-9">
													<input type="text" class="form-control" size="70%" name="ac_comment" placeholder="평을 작성하실때 과정명과 강사님 성함을 넣어주세요~!" >
												</div>
												<div class="col-sm-2">
													<select class="form-control" name="ac_score">
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
												</div>
												<div class="col-sm-1">
													<div class="input-group-btn">
														<button type="submit" class="form-control" value="글작성">
															 <i class="	glyphicon glyphicon-pencil"></i> 수강평 작성
														</button>
													</div>
												</div>
											</form>
										</div>
									</h4>
								</div>				
							</div>		
						</div>
					</div>
					<!-- BOX -->	
					<div class="box">
						<h3 class="sectionTitle p-01">개강 과정</h3>
						<div class="row" style="margin:8px;">
							<div class="col-sm-8">
								과정명
							</div>
							<div class="col-sm-3">
								개강일
							</div>
							<div class="col-sm-1">
								D-day
							</div>
						</div>
						<div class="line"></div>
						<div class="panel-group">
							<c:forEach var = "dto" items="${aclist}">
								<c:choose>
									<c:when test="${dto.dday <14}">
										<div class="panel panel-default">
											<div class="panel-heading" style="color:black; background:#2114;">
												<h4 class="panel-title row">
													<div class="col-sm-8">
														${dto.title}
													</div>
													<div class="col-sm-3">
														${dto.trastartdate}
														<span id="alert">개강임박</span>
													</div>
													<div class="col-sm-1 mobile-m-t-10">
														${dto.dday}
													</div>
												</h4>
											</div>
										</div>
									</c:when>
									<c:otherwise>
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
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
					</div>
					<!-- BOX -->		
					<div class="box">	
						<h3 class="sectionTitle p-01">학원 수강평</h3>
						<div class="line"></div>
						<div class="panel-group">
							<div class="innerbox">
								<c:choose>
									<c:when test="${empty list}">
										<div class="panel panel-default">		
											<div id="empty" class="panel-body">
												---작성된 수강평이 없습니다.---
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<c:forEach var = "dto" items="${list}">
											<div class="panel panel-default">
												<div class="panel-heading font-gray">
													${dto.ac_name}&nbsp;&nbsp; <fmt:formatDate pattern="yyyy-MM-dd" value="${dto.cmt_date}"/>
												</div> 
												<div class="panel-body">
													<div class="col-xs-3 intvw-left-side">
														<div class="row">
															<div style="CLEAR: both;	PADDING-RIGHT: 0px;	PADDING-LEFT: 0px;	BACKGROUND: url(./resources/images/icon_star2.gif) 0px 0px;	FLOAT: left;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	WIDTH: 90px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
																<p style="WIDTH: ${dto.ac_score * 20}%; PADDING-RIGHT:0px;	PADDING-LEFT:0px;	BACKGROUND: url(./resources/images/icon_star.gif) 0px 0px;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	PADDING-TOP: 0px;	HEIGHT: 18px;"></p>
															</div>
														</div>
														<div class="row">
															${dto.ac_score}
														</div>
													</div>
													<div class="col-xs-8 mobile-intvw-p">
														<div class="row">
															${dto.m_id}
														</div>
														<div class="row">
															${dto.ac_comment}
														</div>
													</div>
													<div class="col-xs-1 mobile-intvw-p">
														<c:choose>
															<c:when test="${sessionScope.member.id eq dto.m_id}">
																<button id="delete">삭제</button>
															</c:when>
														</c:choose>
													</div>		
												</div>
											</div>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
					<!-- BOX -->
				</div>
			</div>
		</div>
	</body>
</html>