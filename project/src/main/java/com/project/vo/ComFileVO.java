package com.project.vo;

import lombok.Data;

@Data
public class ComFileVO {
	private String uuid;
	private String uploadpath;
	private String filename;
	private String filetype;
	private int com_bno;

	private String savePath; // 저장된 파일 경로
}
