//뒤로가기 눌렀을때 메인으로 돌아가기
history.pushState(null, null, location.href); 
$(window).on('popstate',function(){
	location.href="main.do";
});
		
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
	        	console.log(cmt);
		       	if(cmt.ac_comment != 'false'){
		       	
		       		alert('학원평이 작성되었습니다.');
		       		//수강평 첫 작성시 ('수강평이 없습니다' 삭제)
		       		if($('#empty') != null){
		       			$('#empty').remove();
		       		}
		       		
		       		// 학원평 추가 ajax
		       		$('.innerbox').append("<div class='panel panel-default'>" +
				       		"  <div class='panel-heading font-gray'>"
		       																						// 아직 date 값을 넣지 않음.
							+	cmt.ac_name+"&nbsp;&nbsp; <fmt:formatDate pattern='yyyy-MM-dd' value='"+cmt.cmt_date+"'/>"+
							"</div>" +
							"<div class='panel-body'>" +
							"	<div class='col-xs-3 intvw-left-side'>" +
							"<div class='row'>" +
							"<div style='CLEAR: both;	PADDING-RIGHT: 0px;	PADDING-LEFT: 0px;	BACKGROUND: url(./resources/images/icon_star2.gif) 0px 0px;	FLOAT: left;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	WIDTH: 90px;	PADDING-TOP: 0px;	HEIGHT: 18px;'>" +
							"<p style='WIDTH: ${dto.ac_score * 20}%; PADDING-RIGHT:0px;	PADDING-LEFT:0px;	BACKGROUND: url(./resources/images/icon_star.gif) 0px 0px;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	PADDING-TOP: 0px;	HEIGHT: 18px;'>" +
							"</p>" +
							"</div>" +
							"</div>" +
							"<div class='row'>" +
							parseFloat(cmt.ac_score).toFixed(1) +
							"</div>" +
							"</div>" +
							"<div class='col-xs-8 mobile-intvw-p'>" +
							"<div class='row'> "
								+	cmt.m_id+
							"</div>" +
							"<div class='row'>" +
							cmt.ac_comment +
							"</div>" +
							"</div>" +
							"<div class='col-xs-1 mobile-intvw-p'>" +
							"<c:choose>" +
							"<c:when test='${sessionScope.member.id eq dto.m_id}'>" +
							"<button id='delete'>삭제</button>" +
							"</c:when>" +
							"</c:choose>" +
							"</div>	" +
							"</div>" +
							"</div>");
		       		
		       		//학원평 삭제 ajax
		       		$('#delete').click(function() {
		       			$(this).parents().eq(4).remove();
		       			var m_id = $('#session').val();
		       			var ac_name = $('#ac_name').text();
		       			$.ajax({
		       				type: "get",
		       				url: "deleteComment.do",
		       				traditional:true,
		       				data:{"m_id":m_id, "ac_name":ac_name},
		       				datatype:"json",
		       				success: function (data) {
		       					console.log('성공');
		       				},
		       				error: function (data) {
		       					console.log('실패');
		       				},
		       			});
		       	    });
		       	}else{
		       		alert('등록한 학원이 다르거나, 이미 학원평을 작성했습니다.');
		       	}
	        },
	        error: function (data) {
	            console.log('An error occurred.');  
	        },
	    });
	}); 
	
	$('#bk').click(function() {
		var id = $('#session').val();
		var ac_name = $('#ac_name').text();
		$.ajax({
			type: "get",
			url: "putBasket.do",
			traditional:true,
			data:{"baskId":id, "baskAcademyName":ac_name},
			datatype:"json",
			success: function (data) {
				alert(data.msg);
				if(data.msg == '찜목록에 추가되었습니다.'){
					showBasket();					
				}
			},
			error: function (data) {
				console.log('실패');
			},
		});
	});
	
	
	$('#delete').click(function() {
		$(this).parents().eq(2).remove();
		var m_id = $('#session').val();
		var ac_name = $('#ac_name').text();
		$.ajax({
			type: "get",
			url: "deleteComment.do",
			traditional:true,
			data:{"m_id":m_id, "ac_name":ac_name},
			datatype:"json",
			success: function (data) {
				console.log('성공');
			},
			error: function (data) {
				console.log('실패');
			},
		});

    });
	
	
});

function showBasket(){
	var m_id = $('#session').val();
	$.ajax({
		type: "get",
		url: "showBasket.do",
		traditional:true,
		data:{"m_id":m_id},
		datatype:"json",
		success: function (data) {
			var list = data.list;
			for(var i=(list.length/2)-1; i<list.length/2; i++){
				if((list.length/2)-1 == 5){	// 찜목록 5개 제한
					break;
				}
				$('#icon-bar').append("<a href='info.do?subTitle="+list[(2*i)+1]+"' class='ac'>" +
										"<img src='"+list[2*i]+"' alt='pic' width='120' height='60'>" +
									  "</a>");
			}
			console.log('성공');
		},
		error: function (data) {
			console.log('실패');
		},
	});
}

