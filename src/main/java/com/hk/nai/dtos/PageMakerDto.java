package com.hk.nai.dtos;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;



public class PageMakerDto {
	
	private CriteriaDto cri; // page, perPageNum 을 가지고 있음
	 
    private int totalCount; // 전체 게시글 수
    private int startPage; // 게시글 번호에 따른 (보여지는)페이지의 시작 번호
    private int endPage; // 게시글 번호에 따른 (보여지는)페이지의 마지막 번호
    private boolean prev; // 이전 버튼을 누를 수 있는 경우/없는 경우 분류를 위함
    private boolean next;//다음버튼 누를수 있는경우/없는경우 분류
 
    private int displayPageNum = 3; // 화면 하단에 보여지는 페이지의 개수
    private int tempEndPage;
 
    ///////////////////////////////////////////////////////////////////////////////////////////////
    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
 
        calcData(); // 전체 필드 변수들 세팅 : 전체 게시글 수의 setter가 호출될 때 전체 세팅되도록 함
    }
 
    private void calcData() { // 전체 필드 변수 값들을 계산하는 메서드
 
        endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);//math.ceil -> 소수점을 올림한다
 
        startPage = (endPage - displayPageNum) + 1;
 
        int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum()));   //전체 게시글 수에 따른 보여줄 페이지 수  게시글이61개이면 7페이지까지만 보여준다.
        this.tempEndPage = tempEndPage;   
 
        if (endPage > tempEndPage) {
            endPage = tempEndPage;
        }
 
        prev = startPage == 1 ? false : true; // 1페이지면 이전 누를 수 없게 false
        next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
 
    }
 
    // getter setter
 
    public CriteriaDto getCri() {
        return cri;
    }
 
    public int getTempEndPage() {
        return tempEndPage;
    }
 
    public void setCri(CriteriaDto cri) {
        this.cri = cri;
    }
 
    public int getTotalCount() {
        return totalCount;
    }
 
    public int getStartPage() {
        return startPage;
    }
 
    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }
 
    public int getEndPage() {
        return endPage;
    }
 
    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }
 
    public boolean isPrev() {
        return prev;
    }
 
    public void setPrev(boolean prev) {
        this.prev = prev;
    }
 
    public boolean isNext() {
        return next;
    }
 
    public void setNext(boolean next) {
        this.next = next;
    }
 
    public int getDisplayPageNum() {
        return displayPageNum;
    }
 
    public void setDisplayPageNum(int displayPageNum) {
        this.displayPageNum = displayPageNum;
    }

    public String makeQuery(int page) {
    	 
        UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page)
                .queryParam("perPageNum", cri.getPerPageNum()).build();
 
        return uriComponents.toUriString();
    }


	

}
