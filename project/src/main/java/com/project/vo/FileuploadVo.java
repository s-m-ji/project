package com.project.vo;

import lombok.Data;

@Data
public class FileuploadVo {

	private String uuid;
	private String uploadpath;
	private String filetype;
	private String filename;
	private int r_no;
	private int i_no;
	private int b_no;
	private int s_no;
	
	// 저장된 파일 경로
	private String savePath;
	private String s_savePath;
	
	private int photoTotalCnt;
		// uploadpath + uuid + "_" + filename;
	
}
