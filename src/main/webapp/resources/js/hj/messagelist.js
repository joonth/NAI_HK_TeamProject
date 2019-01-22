$(document).ready(function(){	
	var sock = new SockJS('.do');
	sock.onopen = function() {
		 sock.send($("#session").val());
		 sock.send($("#rec").val()); 
	 };
	$('a#delete').click(function() {
			sock.send($('#rec').val());
	});
 });

function changeUrl(url){
	document.getElementById("if").src=url;	
}