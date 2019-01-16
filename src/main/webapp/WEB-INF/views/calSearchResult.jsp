<%@page import="org.springframework.web.util.UrlPathHelper"%>
<%@page import="com.hk.nai.services.CalService"%>
<%@page import="com.hk.nai.dtos.CalDto"%>
<%@page import="java.util.List"%>
<%@page import="com.hk.nai.daos.CalDao"%>
<%@page import="com.hk.nai.utils.CalUtil"%>
<%@page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%response.setContentType("text/html; charset=utf-8");%>
<!DOCTYPE html>
<html>
<head>
<%@include file="header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Oswald" rel="stylesheet">
<style>

#Calendar{
    position: absolute;
    left: 50%;
    margin-bottom: 10px;
    margin-top: 0.5%;
	transform:translateX(-50%);
	width: 980px;
	height: 900px;
    border-color: black;
    text-align: center;
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

@media (min-width: 980px)
#Calendar {
    width: 66.66666667%;
}

#calCap {
    padding-top: 8px;
    padding-bottom: 8px;
    color: #777;
    text-align: center;
}

#calCap >a{
	
}


#monthPagebefore, #monthPageafter{
	vertical-align: right;
	float: right;
	margin-left: 95%; 
}


#monthPagebefore{
	border-radius: 0px 0px 6px 0px;
    box-shadow: 1px 2px 2px #ddd;
    border: none;
    outline: 0;
}

#monthPageafter{
	position: relative;
	border-radius: 6px 0px 0px 0px;
    box-shadow: 1px 2px 2px #ddd;
    border: none;
    outline: 0;

}

 .srchTraArea1, .process_Kword {
	list-style-type: none;
}

#caltable {
	border-collapse: collapse;
	table-layout: fixed;
	word-wrap: break-word;
	width: 100%;
    max-width: 100%;
    margin-bottom: 20px;
}

#date{
	background-color: black;
}

#weekday >th{
	color: #a4a4a7;
}


#caltable td {
	position: relative;
	border: 3px solid white;
	background-color: white;
	text-align: left;
	vertical-align: top;

}

#calPage{
	position: relative;
	display: inline-block;
	margin-left: 80%;

}

#calPage >img{
	display: inline-block;

}


#calDate{
	font-family: 'Oswald', sans-serif;
	font-size: 30px;
	color: #5a5d63;
	text-align: left;	
}

.dateNum{
	padding-left: 3%;
}

.lastDayNum {
	display: none;
}

.acName > a {
	text-decoration: none;
}


.acName > a{
	color: black;
	
}

#aca_name{
	position: relative;
	float:left;
	width:100%;
	text-align: center;
	margin-top: 0.5%;
	height:100px;	
}

/* 검색창 */
#AcademySearch {
	position: relative;
	float: left;
	display: inline-block;
    width: 21%;
    height: 48px;
    margin-left:0.4%;
    border-radius: 6px 0px 0px 6px;
    box-shadow: 1px 2px 2px #ddd;
    border: none;
    outline: 0;
    font-size: 16px;
    font-family: 'Open Sans';
    color: #bbb;
    padding: 0px 12px;
    text-rendering: auto;
    letter-spacing: normal;
    word-spacing: normal;
    text-transform: none;
    text-indent: 0px;
    text-shadow: none;
    text-align: start;
    font: 400 13.3333px Arial;
    -webkit-writing-mode: horizontal-tb !important;

 }
 
/*  검색버튼 */
 #submitForm{
	 display: inline-block;
	 float: left;
 	 background-image: url( "./resources/images/search.png" );
 	 width: 48px;
 	 height: 48px;
 	 background-color: white;
 	 border-radius: 0px 6px 6px 0px;
 	 box-shadow: 1px 2px 2px #ddd;
 	 border: none;
     outline: 0;
 }
 
 
/*  버튼상자 */
 .btn-worksets{
	position: relative;
 	margin-top:8%; 
    width: 160px;
    height: 100px;
	padding: 20px;
    margin-bottom: 20px;
    border-radius: 6px 0px 0px 6px;
    box-shadow: 1px 2px 2px #ddd;
    border: none;
    outline: 0;
     -webkit-box-sizing: border-box;
     -moz-box-sizing: border-box;
          box-sizing: border-box;
 
 }

#AcademyRk{	
	position:relative;
    border: 1px solid rgba(0,0,0,0.15);
    color: #fff;
    font-weight: bold;
    text-align: center;
    line-height: 35px;
    background: #c1b7d0;
    height: 34px;
    overflow: hidden;
    width: auto;
    cursor: pointer;

}

#CartAcademyCal{
	display: inline-block;
    border: 1px solid rgba(0,0,0,0.15);
    color: #fff;
    font-weight: bold;
    text-align: center;
    line-height: 35px;
    background: #c1b7d0;
    height: 34px;
    overflow: hidden;
    width: auto;
    cursor: pointer;
}

.Right-sidebar{
	 width: 160px;
	 padding: 20px;
	 margin-bottom: 20px;
 	 margin-top:3%;
	 float: right;
}

</style>
<script type="text/javascript">
	$(function(){
		 //현재 마우스 이벤트가 발생된 .countView 태그의 a를 구해줌
		var DAY = $(".dateNum").text().trim();
		var MONTH = $(".m").text().trim();
		var YEAR = $(".y").text().trim();
		console.log(YEAR+MONTH+DAY);
		var yyyyMMdd= [];
	}),
	
	$("#dateNum").click(function(){
		var countView = $(this);
		var YEAR=$(".y").text().trim();
		var MONTH=$(".m").text().trim();
		var date= countView.text().trim();
		var yyyyMMdd=YEAR+MONTH+date;
		alert(yyyyMMdd);
	});
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>캘린더검색페이지</title>
</head>
<%
	String paramYear=request.getParameter("year");
	String paramMonth=request.getParameter("month");
	
	Calendar cal=Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH)+1;
	int day = cal.get(Calendar.DATE);
	
	
  	
  	if(paramYear != null){
		year=Integer.parseInt(paramYear);
	}
	if(paramMonth != null){
		month=Integer.parseInt(paramMonth);
	}
	
	if(month>12){
		month=1;
		year++;
	}
	if(month<1){//월이 감소하다 1보다 작아지면 0,-1,-2..되는 거 처리
		month=12;
		year--;
	}
	//----------------------------------------------------
	cal.set(year, month-1, 1);	
	int dayOfWeek=cal.get(Calendar.DAY_OF_WEEK);//1일의 요일을 구함
	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	
	CalDao dao=new CalDao();
	
	UrlPathHelper urlPathHelper = new UrlPathHelper();  //controller 호출 url 찾기
	String originalURL = urlPathHelper.getOriginatingRequestUri(request);
	int Doleng = originalURL.length();
	String Do = originalURL.substring(5,Doleng); //찜한학원 url, 학원랭킹 url
	
	
	//--------------------------------------------------------
%>
<body>
	<jsp:useBean id="util" class="com.hk.nai.utils.CalUtil" />
	<div id="Search">
		 <form name="calSearchform" method="GET" action="calSearchform.do"> 		
			<div id="aca_name">
				<span><input type="text" name="search" id="AcademySearch" onclick="searchbox(1)" placeholder="<%=(String)session.getAttribute("search")%>"></span>
				<span><input type="submit" id="submitForm" value="" ></span>
				<span id="searchResult"></span>	
			</div>	
		</form> 
	</div>
	
	<div id="Calendar" >
		<table id="caltable" >
		<div class="lastDayNum" style="diplay:none;"><%=lastDay%></div>
			<caption id="calCap">
				<div id="calPage">
					<a id="monthPageafter" href="calSearchform.do?search=<%=(String)session.getAttribute("search")%>&year=<%=year%>&month=<%=month+1%>"><img src="./resources/images/uparrow.png"/></a>
					<a id="monthPagebefore" href="calSearchform.do?search=<%=(String)session.getAttribute("search")%>&year=<%=year%>&month=<%=month-1%>"><img src="./resources/images/downarrow.png"/></a>
					<%-- <a id="yearPagebefore" href="<%=Do%>?year=<%=year-1%>&month=<%=month%>"></a>  
					<a id="yearPageafter" href="<%=Do%>?year=<%=year+1%>&month=<%=month%>"></a>  --%>
				</div>
				<div id="calDate"><span class="y"><%=year%></span>년  <span class="m"><%=month%></span>월</div>
			</caption>
			
			<tr id="weekday">
				<th>S</th>
				<th>M</th>
				<th>T</th>
				<th>W</th>
				<th>T</th>
				<th>F</th>
				<th>S</th>
			</tr>
			<tr>
				<%
  	for(int i=0;i<dayOfWeek-1;i++){
           out.print("<td>&nbsp;</td>");
        }
     
        for(int i=1;i<=lastDay;i++){
  %>
				<td style="background-color: #f7f5f5; width: 150px; height: 140px;"><a style="color:<%=CalUtil.fontColor(i, dayOfWeek)%>"
					class="dateNum"><%=i%> <% 
               	String yyyyMMdddd =year+"-"+CalUtil.isTwo(String.valueOf(month))+"-"+CalUtil.isTwo(String.valueOf(i));
                            	pageContext.setAttribute("yyyyMMdddd", yyyyMMdddd.trim());
               %>
				</a>
				<div class="yyyyMMdddd" style="display:none;"> ${yyyyMMdddd}</div>
 					<div class="clist">
						<c:choose>
							<c:when test="${empty calViewList}">	
							</c:when>
							<c:otherwise>
								<c:set var="yyyyMMdddd" value="${yyyyMMdddd}" />
								<c:set var="count" value="0" />
								<div class="acName" >
								<c:forEach items="${calViewList}" var="list">
									<c:set var="ac_cre_date" value="${list.ac_cre_date}" />
									<c:choose>
										<c:when test="${yyyyMMdddd eq ac_cre_date && count <3}">
											<!-- 개강일이 같은 학원명 3개 출력 -->		
												<a href="calDetail.do?ac_seq=${list.ac_seq}&ac_name=${list.ac_name}" onclick="window.open(this.href,'','width=690, height=460, scrollbars=yes'); return false;" href="calDetail.do?ac_seq=${list.ac_seq}&ac_name=${list.ac_name}">${list.ac_name}</a>													
												<%-- <a target='blank' href="calDetail.do?ac_seq=${list.ac_seq}&ac_name=${list.ac_name}" >${list.ac_name}</a>							 --%>
											<br />
											<c:set var="count" value="${count + 1}" />
											<!-- for문을 돌때마다 count 증가 -->
										</c:when>
									</c:choose>
								</c:forEach>
								</div>
							</c:otherwise>
						</c:choose>
					</div></td>
				
				<% 
         //행을 바꿔주기---> 토요일은 공백수+현재날짜==7배수
         if((dayOfWeek-1+i)%7==0){//토요일이냐??
            out.print("</tr><tr>");
         }
       
      }// 날짜 출력 for문 종료
       for(int i =0; i<(7-((dayOfWeek-1+lastDay)%7))%7;i++)
         out.print("<td style='width: 150px; height: 140px;'>&nbsp;</td>"); 
   %>
			</tr>
		</table>
	</div>
	<div class="btn worksets" style="background-color: white; 	margin-left:0.4%;"  >
		<button type="button" id="AcademyRk" onclick="location.href='acDayRank.do'">일별랭킹 보기</button>
		<button type="button" id="CartAcademyCal" onclick="location.href='cartAcademyCal.do'">찜한 학원일정 보기</button>
	</div>
	<div class="Right-sidebar">
	</div>


	
<!-- 검색결과가 없을때 나타나는 문구 -->
<script type="text/javascript">

		var SearchControl = document.getElementById('SBox');
		var ColorChange = document.getElementById('color');

		function searchbox(num) {
		  if(num == "1"){
		    SearchControl.style.visibility = "visible";
		    SearchControl.style.opacity = "1";
		  } else if(num == "0") {
		    SearchControl.style.visibility = "hidden";
		    SearchControl.style.opacity = "0";
		    }
		  } 
</script>	
</body>
</html>



