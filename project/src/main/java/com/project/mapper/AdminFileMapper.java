package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.project.vo.AttachVO;
import com.project.vo.MemberVo;

public interface AdminFileMapper {
	// 등록
	public int fileInsert(MemberVo membervo);
	
	// 조회 (게시물 당 첨부파일의 개수)
	public List<MemberVo> fileSelect(int mno);
	
	// 파일 삭제 
	public int fileDelete(@Param("mno")int mno, @Param("uuid")String uuid);
	
	// 파일 목록 한건 불러오기
	public List<MemberVo> getOne (@Param("mno") int mno, @Param("uuid") String uuid);

	// 파일 전체 목록 불러오기 
	public List<MemberVo> getAllList();

	// 파일 수정 
	public int fileUpdate(List<MultipartFile> files, int mno);
}
