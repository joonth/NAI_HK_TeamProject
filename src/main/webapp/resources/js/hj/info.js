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
		       	if(cmt.ac_comment != 'false'){
		       		$('table').eq(1).append('<tr><td>'
		       				+ cmt.ac_name+" "
		       				+cmt.m_id+" "
		       				+cmt.ac_comment+" "
		       				+parseFloat(cmt.ac_score).toFixed(1)+" "+
		       				"<button id='delete'> 삭제</button>"
		       				+'</td></tr>');
		       		//
		       		$('#delete').click(function() {
		       			$(this).parent().remove();
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
				showBasket();
			},
			error: function (data) {
				console.log('실패');
			},
		});
	});
	
	
	$('#delete').click(function() {
		$(this).parent().remove();
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
	alert('되니?');
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

