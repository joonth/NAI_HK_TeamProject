<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 상세보기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
////ajax좋아요
function like_func(){
	var frm_read = $("#frm_read");
	var b_seq = $('#b_seq').val();
	var m_nick=$('#m_nick').val();
	var b_like=$('#b_like').val();
	
	
	$.ajax({
		url: "like.do",
		data: {'b_seq':b_seq,'m_nick':m_nick},
		dataType:"json",
		cache: false,
		type:"GET",
		traditional:true,
		success:function(data){
			var msg='';
// 			var like_img='';
			msg+=data.msg;
			alert(msg);
			
			if(data.like_check==0){
// 				like_img="./resources/dislike.png";
				$('#like_img').attr('src',"./resources/images/dislike.png");
			}else{
// 				like_img="./resources/like.png";
				$('#like_img').attr('src',"./resources/images/like.png");
			}
// 			$('#like_img',frm_read).attr('src',like_img);
			$('#b_like').html(data.b_like);
			$('#like_check').html(data.like_check);
		},
		error:function(){
			alert("서버에러");
		}
	});
}
</script>
</head>
<body>
<%@include file="header.jsp" %>
<h2>게시글 상세보기</h2>

<form id="frm_read" name="frm_read" method="get">
<input type="hidden" id="b_seq" name="b_seq" value="${dto.b_seq }" />
<input type="hidden" id="m_nick" name="m_nick" value="${sessionScope.member.nickname}" />
<input type="hidden" id="b_like" name="b_like" value="${dto.b_like }" />

<table>
	<tr>
		<th>글 번호</th>
		<td>${dto.b_seq}</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>${dto.m_nick}</td>
	</tr>
	<tr>
		<th>작성일</th>
		<td><fmt:formatDate value="${dto.b_regdate}" pattern="yyyy-MM-dd a HH:mm"/></td>
	</tr>
	<tr>
		<th>제목</th>
		<td>${dto.b_title}</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" readonly="readonly">${dto.b_content}</textarea>
		<a href='javascript:like_func();'><img src="./resources/images/${dto.like_check==0?'dislike.png':'like.png'}" id="like_img" alt="하트사진"></a>		

		<span id="b_like">Likes</span>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<c:if test="${sessionScope.member.nickname eq dto.m_nick}">
				<button type="button" onclick="updateForm('${dto.b_seq}')">수정</button>
				<button type="button" onclick="delBoard('${dto.b_seq}')">삭제</button>
			</c:if>
			<button type="button" onclick="location.href='boardlist.do?page=${cri.page}&pagelist=${pagelist}'">글목록</button>
		</td>
	</tr>
</table>
</form>
<br /><br />
<%@include file="reply.jsp" %>


<script type="text/javascript">
	//수정폼으로 이동하는 함수
	function updateForm(b_seq){
		location.href="updateform.do?page=${cri.page}&b_seq="+b_seq;
	}
	//게시글 삭제로 이동
	function delBoard(b_seq){
		location.href="delboard.do?page=${cri.page}&pagelist=${pagelist}&b_seq="+b_seq;
	}
	
</script>
</body>
</html>