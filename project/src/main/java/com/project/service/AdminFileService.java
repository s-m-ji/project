package com.project.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.vo.AttachVO;
import com.project.vo.MemberVo;

// admin 파일 service 

@Service
public interface AdminFileService {

	// 등록
	public int fileInsert(MemberVo membervo);

	// 조회
	public List<MemberVo> fileSelect(int mno);
	
	// 파일 삭제 
	public int fileDelete(@Param("mno")int mno, @Param("uuid")String uuid);
	
											// fileServiceImpl에서 오류 예외처리를 하고 있기 때문에 똑같이 맞춰줌
											//			(✨impl을 수정하면 service도 똑같이 맞춰주기!)
	public int fileupload(List<MultipartFile> files, int mno) throws Exception;
	
	// 파일 리스트 전체 조회 
	public List<MemberVo> getAllList();
	
	// 파일 한 건 
	public List<MemberVo> getOne (@Param("mno") int mno, @Param("uuid") String uuid);

	// 파일 수정 
	public int fileUpdate(List<MultipartFile> files, int mno);
}



