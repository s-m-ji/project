package com.project.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.project.vo.RecFileVO2;

@Service
public interface RecFileService2 {

	public List<RecFileVO2> getList(int bno);
	
	public int insert(RecFileVO2 vo);
	
	public int stepInsert(RecFileVO2 vo);
	
	public int fileupload(List<MultipartFile> files, int bno) throws Exception;
	
	public int Ffileupload(List<MultipartFile> files, int bno) throws Exception;

	public int Sfileupload(List<MultipartFile> files, int bno, Model model) throws Exception;
}
