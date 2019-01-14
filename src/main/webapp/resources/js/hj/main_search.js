function myFunction(val) {	
	
  var input, filter, table, tr, td, i, txtValue, count, scores;
  var tdNum = [];
  var acTitle = [];
  count = 0;
  input = $('#myInput');
  filter = input.val().toUpperCase();
  tr= $('#myTable').find('tr');
  scores = $('.score');
  
  for (i = 0; i < tr.length; i++) {		
	  td = tr.eq(i).find('td')[1];
	  td1 = tr.eq(i).find('td')[2];
	  td2 = tr.eq(i).find('td')[3];
    if (td) {
      txtValue = td.textContent || td.innerText;
      txtValue1 = td1.textContent || td1.innerText;
      txtValue2 = td2.textContent || td2.innerText;     
      if (txtValue.toUpperCase().indexOf(filter) > -1 || txtValue1.toUpperCase().indexOf(filter) > -1 || txtValue2.toUpperCase().indexOf(filter) > -1) {
    	  $('#none').attr("style","display:block");
    	  tr.eq(i).attr("style","display:");
    	  acTitle.push(txtValue1);
    	  tdNum.push(i-1);     
      } else {	    
    	  tr.eq(i).attr("style","display:none");
      }
	}  
  }//	for문
  
  if(val === ""){ $('#none').attr("style","display:none");}


  $.ajax({
	url:"getList.do?",
	traditional:true,
	data:{"acTitle":acTitle},
	datatype:"json",
	method:"post",
	success:function(obj){
		for(var i=0; i<acTitle.length; i++){
		// 검색에 해당하는 학원들의 score만 구해서 변경해준다.
			scores.eq(tdNum[count]).html(parseFloat(obj[acTitle[count]]).toFixed(1));
			count++;
		}		
	},
	error:function(){
		console.log("서버통신실패!!");
	}
  });   
}