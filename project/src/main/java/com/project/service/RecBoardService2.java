package com.project.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.project.vo.RecBoardVO2;

@Service
public interface RecBoardService2 {
	

	public List<RecBoardVO2> getlist();
	
	public int insert(RecBoardVO2 vo);
	
	// public int insertSelectKey(RecBoardVO board);
	public int insertSelectKey(RecBoardVO2 board, List<MultipartFile> files , List<MultipartFile> Fphotos, List<MultipartFile> Sphotos, Model model) throws Exception;
	
	public int delete(int bno);
	
	public RecBoardVO2 getOne(int bno);
	
	public int update(RecBoardVO2 vo);

	

}
