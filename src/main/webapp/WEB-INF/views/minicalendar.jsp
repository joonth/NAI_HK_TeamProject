<%@page import="org.springframework.web.util.UrlPathHelper"%>
<%@page import="com.hk.nai.services.CalService"%>
<%@page import="com.hk.nai.dtos.CalDto"%>
<%@page import="java.util.List"%>
<%@page import="com.hk.nai.daos.CalDao"%>
<%@page import="com.hk.nai.utils.CalUtil"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
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
	String Do = originalURL.substring(5,Doleng);
	//--------------------------------------------------------
%>
<body>
<jsp:useBean id="util" class="com.hk.nai.utils.CalUtil" />
<div id="miniCalendar">
	<table id="miniCalTable">
	<caption>
		<a href="minicalendar.jsp?year=<%=year-1%>&month=<%=month%>">◁</a>
		<a href="minicalendar.jsp?year=<%=year%>&month=<%=month-1%>">◀</a>
		<span class="y"><%=year%></span>년 <span class="m"><%=month%></span>월
		<a href="minicalendar.jsp?year=<%=year%>&month=<%=month+1%>">▶</a>
		<a href="minicalendar.jsp?year=<%=year+1%>&month=<%=month%>">▷</a>
	</caption>
	<tr>
		<th>일</th>
		<th>월</th>
		<th>화</th>
		<th>수</th>
		<th>목</th>
		<th>금</th>
		<th>토</th>
	</tr>
	<tr>
	<%
		for(int i=0;i<dayOfWeek-1;i++){
			out.print("<td>&nbsp;</td>");
		}
		for(int i=1;i<=lastDay;i++){
			%>
			<td>
				<a class="countView" href="CalController.do?command=callist&year=<%=year%>&month=<%=month%>&date=<%=i%>">
					<%=i%>
				</a>
			</td>
			<%
			//행을 바꿔주기---> 토요일은 공백수+현재날짜==7배수
			if((dayOfWeek-1+i)%7==0){//토요일이냐??
				out.print("</tr><tr>");
			}
		}//날짜출력하는 for문 종료
		for(int i=0;i<(7-((dayOfWeek-1+lastDay)%7))%7;i++){
			out.print("<td>&nbsp;</td>");
		}
	%>
	</tr>
</table>
</div>

</body>
</html>