$(document).ready(function(){
	var sock = new SockJS('.do');
	
	$("#messageForm").submit(function(event) {
     sock.send($("#n_receiver").val());
		alert('보냄');
	});
	
	$("#messageAllForm").submit(function(event){
		alert('보냄');
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
		 $('#count').text(evt.data);
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



