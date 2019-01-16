//전체 선택 체크박스 
	function allSel(bool){
		var chks=document.getElementsByName("chk");//배열로 반환[chk,chk,chk...]
		for (var i = 0; i < chks.length; i++) {
			chks[i].checked=bool;
		}
	}
	//선택 체크박스
	function confirmChk(){
		var chks=document.getElementsByName("chk");//[chk,chk,chk..]
		var count=0;
		for (var i = 0; i < chks.length; i++) {
			if(chks[i].checked){ //체크되어 있으면 true, 아니면 false
				count++;  //체크 되어 있으면 카운트 증가
			}
		}
		if(count==0){// 체크를 안했을 경우
			alert("삭제할 멤버를 선택해주세요.");
			return false;
		}else if(count>0){
			if(confirm("정말 삭제하시겠습니까?")!=0){
				return count>0?true:false;//true이면 submit실행, false이면 취소
			}else {               
				return false;
			}
		}  
	}	
	
	function confirmChangeGrade(){
		alert("등급이 변경되었습니다.");		
		}
	function userDetail(){
		location.href="userDetail.do";
	}
