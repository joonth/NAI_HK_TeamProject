

/////////////// 선택해서 보내기

$(document).ready(function(){
	
	var frm = $('#messageAllForm');
		
		frm.submit(function (e) {
		for(var i=0; i<$('#b').children('div').length; i++){
			var ns_state_code = $(":input:radio[class=pick]:checked").val();
			var n_sender = 'admin';
			var n_receiver = $('#b').children('div').eq(i).attr('value');	
			var n_content = $('#allContent').val();

		
		    e.preventDefault();
		    $.ajax({
		        type: frm.attr('method'),
		        url: frm.attr('action'),
		        data: {"n_sender":n_sender,"n_receiver":n_receiver,"n_content":n_content,"ns_state_code":ns_state_code},
		        success: function (data) {
		            console.log('Submission was successful.');
		        },
		        error: function (data) {
		            console.log('An error occurred.');
		        },
		    });
		}
	});
});




////////////// 입력해서 보내기
$(document).ready(function(){
	var frm = $('#messageForm');
	frm.submit(function (e) {
	    e.preventDefault();
	    $.ajax({
	        type: frm.attr('method'),
	        url: frm.attr('action'),
	        data: frm.serialize(),
	        success: function (data) {
	            console.log('Submission was successful.');
	        },
	        error: function (data) {
	            console.log('An error occurred.');
	        },
	    });
	});
});


/////////////// 멤버리스트 출력
$(document).ready(function(){
	$.ajax({
        type: "post",
        url: "getMemberList.do",
        success: function (data) {
        	for(var i=0; i<data.list.length; i++){        		
        	var dto = data.list[i];
        	$('#a').append("<div onclick='stateClick(this)') value='"+dto.id+"'>"+dto.id+","+dto.nickname+","+ dto.grade+"</div>");
        	}
        },
        error: function (data) {
            console.log('An error occurred.');
        },
    });
});


///////////////////////// 클릭하면 넘어가기
function stateClick(val){
	if(val == 'all'){
		var section = 'a';
		for(var i=0; i<$('#a').children('div').length; i++){
			var value = $('#a').children('div').eq(i).attr('value');
			$.ajax({
		        type: "get",
		        url: "changeState.do",
		        traditional:true,
				data:{"value":value ,"section":section},
				datatype:"json",
		        success: function (data) {
		        (data.section =='b') ? $('#b').append($("div[value="+data.value+"]")) : $('#a').append($("div[value="+data.value+"]"));	        				
		        },
		        error: function (data) {
		            console.log('실패');
		        },
		    });
		}
	}else{	
		var value = $(val).attr('value');
		var section = $(val).parents('div').attr('id'); 
		$.ajax({
	        type: "get",
	        url: "changeState.do",
	        traditional:true,
			data:{"value":value ,"section":section},
			datatype:"json",
	        success: function (data) {
	        (data.section =='b') ? $('#b').append($("div[value="+data.value+"]")) : $('#a').append($("div[value="+data.value+"]"));	        				
	        },
	        error: function (data) {
	            console.log('실패');
	        },
	    });
	}
}
