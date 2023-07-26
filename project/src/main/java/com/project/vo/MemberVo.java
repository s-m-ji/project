package com.project.vo;

import lombok.Data;

@Data
public class MemberVo {
	private int mno;
	private String email;
	private String pw;
	private String name;
	private String nickName;
	private String pNum;
	private String reg_date;
	private String grade;
	private String delYN;
	
	private String delYNStr; // 탈퇴 신청 여부 (신청 , '') ${member.delYNStr}
	private String reg_dateStr; // 가입일

}
