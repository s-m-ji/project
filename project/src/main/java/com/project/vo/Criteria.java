package com.project.vo;

import lombok.Data;

@Data
public class Criteria {
	
	private String sField = ""; // 검색 조건
	
	private String c1depth = ""; // 검색 조건 : 첫번째 셀렉트 박스
	private String c2depth = ""; // 검색 조건 : 두번째 셀렉트 박스
	
	private String sWord = ""; // 검색어
	
	
	private int pageNo = 1; // 요청 페이지 번호s
	private int amount = 10; // 한 페이지 당 게시물 수
	
	private int startNo = 1;
	private int endNo = 10;
	
	
	// 페이지 정보가 넘어오면 알아서 start & end를 자동 설정하기 위함
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
		if(pageNo>0){
			endNo = pageNo * amount;
			startNo = pageNo * amount - (amount -1);
		}
	}
}
