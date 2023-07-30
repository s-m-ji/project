package com.project.vo;

import lombok.Data;

@Data
public class NoticeVo {
	private int nno; 	    // 공지 번호
	private String ntitle; // 공지 제목
	private String ncontent; // 공지 내용
	private String nwriter;  // 작성자
	private String nregdate; // 작성일
	private String ncount;   // 조회수
	private String gubun;    // 구분 (일반, 이벤트, 자주묻는질문)
}
