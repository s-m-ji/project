package com.project.vo;

import lombok.Data;

@Data // 이 친구가 toString까지 알아서 오버라이드 해줍니당
public class BoardVO {

	// rec_board_test로 사용
	private int bno;
	private String title;
	private String nickName;
	private String regdate;
	private int C_NO;
	
}
