package com.project.vo;

import java.util.List;

import lombok.Data;

/**
 * 게시글의 정보를 담고 있는 객체
 * @author 이한규
 *
 */
@Data
public class RecipeBoardVo {

	private int b_no;
	private String title;
	private String nickname;
	private String regdate;
	private String updatedate;
	private int boomup;
	private String intro;
	private String cooktip;
	private int viewcnt;
	private int star;
	private String tier;
	private int mno;
	private String videoCode;
	
	// 파일 vo list
	private String savePath;
	// private List<ListStep> step;
}
