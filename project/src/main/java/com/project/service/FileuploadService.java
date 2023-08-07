package com.project.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.vo.FileuploadVo;

@Service
public interface FileuploadService {

	public List<FileuploadVo> getFileList(int bno);
	
	// 완료 이미지 불러오는 메서드
	public List<FileuploadVo> getFinishImg(int bno);
	
	public List<FileuploadVo> getRecipeStep(int bno);
	
	public List<FileuploadVo> getPhotoReview(int bno);
	
	public FileuploadVo getIngredients(int i_no);

	// 파일 업로드
	public int fileupload(List<MultipartFile> files, int bno, int r_no);
	
	int insertFile(FileuploadVo vo);
	
	
}
