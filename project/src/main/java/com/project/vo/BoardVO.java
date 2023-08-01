package com.project.vo;

import lombok.Data;

@Data // 이 친구가 toString까지 알아서 오버라이드 해줍니당
public class BoardVO {

	private int B_NO; // 게시글 번호
	private int C_NO1; // 카테고리 번호
	private int C_NO2; // 카테고리 번호
	private int I_NO; // 재료 번호
	
	private String title;
	private String nickName;
	private String regdate;
	private String intro;
	private String boomup;
	private String viewcnt;
	
	private String cateName1; // 카테고리명
	private String cateName2; // 카테고리명

	private String newpost; // 신규 글 여부 
	// private String regtime; // 신규 글 여부 
	
	private String I_NAME; // 재료명
	
}
