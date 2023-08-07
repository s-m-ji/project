package com.project.vo;

import java.sql.Date;

import lombok.Data;

// (지수) 회원 
@Data
public class MemberVo {
	private int mno;
	private String email;
	private String pw;
	private String name;
	private String nickname;
	private String pnum;
	private String reg_date;
	private int gno; 	// 등급 번호
	private String delyn;
	
	private String delYNStr; // 탈퇴 신청 여부 (신청 , '') ${member.delYNStr}
	private String reg_dateStr; // 가입일
	
	private String grade;
	private String benefit;
	
	
// (지수) 리워드 테이블 
	private String viewcnt;	// 게시글 조회수
	private String regdate; // 게시글 등록
	private String startDate; // 시작일
	private String endDate; // 마감일
	
// (지수) 파일 테이블
	private String uuid       ;
	private String uploadpath ;
	private String filename   ;
	private String filetype   ;
	
	// 저장된 파일 경로 (uploadpath + uuid + "_" + filename;)
	private String savePath; // 저장된 파일 경로
	private String s_savePath; // 저장된 썸네일 경로

}
