package com.project.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.vo.ComFileVO;

@Service
public interface ComFileService {

	public List<ComFileVO> getList(int bno);
	
	public int insert(ComFileVO vo);
	
	public ComFileVO getOne(@Param("com_bno")int com_bno );
	
	
	public int fileupload(List<MultipartFile> files, int bno) throws Exception;
}
