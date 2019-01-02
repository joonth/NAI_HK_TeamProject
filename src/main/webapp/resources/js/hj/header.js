$(document).ready(function(){
	var sock = new SockJS('.do');
	
	$( document ).ajaxComplete(function() {
		 sock.send($("#session").val());
		});
	
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
 });
	
function changeUrl(url){
	document.getElementById("if").src=url;	
}