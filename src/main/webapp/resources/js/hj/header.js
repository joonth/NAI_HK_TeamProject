var sock = new SockJS('.do');
$(document).ready(function(){

	$("#messageForm").submit(function(event) {
	    sock.send($("#n_receiver").val());
	    alert('쪽지를 보냈습니다.');
	});
	
	$("#messageAllForm").submit(function(event){
		alert('쪽지를 보냈습니다.');
		for(var i=0; i<$('#b').children('div').length; i++){
			var n_receiver = $('#b').children('div').eq(i).attr('value');	
			 sock.send(n_receiver);
		}				
	});
	
	 sock.onopen = function() {
		 sock.send($("#session").val());
	     console.log('open');
	 };
	 
	 sock.onmessage = function(evt) {
		 if(evt.data != 0){
			 $('#count').html("<span class='badge' style='color:red; font-size:15px;'>"+evt.data+"</span>");			 
		 }else{
			 $('#count').html("<span class='badge' style='color:red; font-size:15px;'></span>");
		 }
	 };
	 
	 sock.onclose = function() {
	     console.log('close');
	 };
	 
	 //장바구니 출력
	 var m_id = $('#session').val();
		$.ajax({
			type: "get",
			url: "showBasket.do",
			traditional:true,
			data:{"m_id":m_id},
			datatype:"json",
			success: function (data) {
				var list = data.list;
				for(var i=0; i<list.length/2; i++){
					$('#icon-bar').append("<a href='info.do?subTitle="+list[(2*i)+1]+"' class='ac'>" +
											"<img src='"+list[2*i]+"' alt='pic' width='120' height='60'>" +
										  "</a>");
					if(i == 4){
						break;
					}
				}
				console.log('성공');
			},
			error: function (data) {
				console.log('실패');
			},
		});
 });
	
function changeUrl(url){
	document.getElementById("if").src=url;	
}

function msgCheck(){
	$(document).ajaxStop(function() {
		sock.send($("#session").val());
	});
}
