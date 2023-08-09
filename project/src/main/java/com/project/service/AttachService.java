package com.project.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.vo.AttachVO;

@Service
public interface AttachService {
	
	public List<AttachVO> getAllList(); // 파일 리스트 전체 조회 (list)
	
	public List<AttachVO> getAllComList(); // 파일 리스트 전체 조회 (com_list)
}
