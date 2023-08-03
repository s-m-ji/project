package com.project.vo;

import lombok.Data;

@Data
public class AttachVO {
	private String uuid       ;
	private String uploadPath ;
	private String fileName   ;
	private String filetype   ;
	private int B_NO; // 게시글 번호
	private String savePath; // 저장된 파일 경로
	private String t_savePath; // 저장된 썸네일 경로
}
