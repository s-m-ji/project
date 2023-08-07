package com.project.vo;

import lombok.Data;

@Data
public class RecipeReplyVo {

	
	private int r_no;
	private String replydate;
	private String reply;
	// bno 주의
	private int b_no;
	private String writer;
	private double star;
	
}
