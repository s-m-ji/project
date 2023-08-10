package com.project.vo;



import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ComBoardVO {

	private int com_bno;
	private String nickName;
	private String com_title;
	private String com_content;
	private String regdate;
	private String update_date;
	private int replycnt;
	private int mno;
	
	private List<MultipartFile> photos;
	
	
	
}
