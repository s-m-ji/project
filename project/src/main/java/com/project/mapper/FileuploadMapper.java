package com.project.mapper;

import java.util.List;

import com.project.vo.FileuploadVo;

public interface FileuploadMapper {

	// 상단 이미지 불러오는 메서드
	public List<FileuploadVo> getFileList(int bno);
	
	// 완료 이미지 불러오는 메서드
	public List<FileuploadVo> getFinishImg(int bno);
	
	// 요리순서 이미지 불러오는 메서드
	public List<FileuploadVo> getRecipeStep(int bno);
	
	// 포토리뷰 사진 불러오는 메서드
	public List<FileuploadVo> getPhotoReview(int bno);
	
	// modal 재료 정보 불러오는 메서드
	public FileuploadVo getIngredients(int i_no);
	
	// 파일 업로드
	public int insertFile(FileuploadVo vo);
	
	public FileuploadVo getMemberImg(int m_no);
	
}
