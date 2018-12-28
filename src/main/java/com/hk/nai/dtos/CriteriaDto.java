package com.hk.nai.dtos;

public class CriteriaDto { //Criteria 클래스 : 페이징 처리를 위해서 사용될 객체로, 페이지 번호와, 페이지당 출력할 개시글 수를 관리할 객체이다.
	
	private int page; // 보여줄 페이지
    private int perPageNum; // 페이지당 보여줄 페이지수
    
    public int getPageStart(){
        return (this.page -1) * this.perPageNum;
    }

    public CriteriaDto() { // 최초 default 생성자로 기본 객체 생성시 초기값을 지정한다. (1페이지, 10개씩)
        this.page = 1;  // 사용자가 세팅하지 않으면 기본 1
        this.perPageNum = 10; // 페이지당 기본 10개씩 출력하도록 세팅
    }
    
 // getter setter
    public int getPage() {
        return page;
    }
    public void setPage(int page) {
        if ( page <= 0 ){
            // 페이지는 1페이지부터임으로 0보다 작거나 같은값일 경우 무조건 첫번째 페이지로 설정되도록 해준다.
            this.page = 1;
        }else{
            this.page = page;
        }
    }
    public int getPerPageNum() {
         
        return perPageNum;
    }
    public void setPerPageNum(int perPageNum) {
        if ( perPageNum <= 0 || perPageNum > 100 ) {
            this.perPageNum = 10;
        }else {
            this.perPageNum = perPageNum;
        }
    }
}
