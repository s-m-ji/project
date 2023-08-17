package com.project.service;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.project.mapper.RecMapper2;
import com.project.vo.RecBoardVO2;

@Service
public class RecBoardServiceImpl2 implements RecBoardService2 {

	@Autowired
	RecMapper2 recMapper;
	
	
	
	@Autowired
	RecFileService2 fileservice;

	@Override
	public List<RecBoardVO2> getlist() {
		// TODO Auto-generated method stub
		return recMapper.getlist();
	}

	@Override
	public int insert(RecBoardVO2 vo) {
		// TODO Auto-generated method stub
		return recMapper.insert(vo);
	}

	@Override
	public int delete(int bno) {
		// TODO Auto-generated method stub
		return recMapper.delete(bno);
	}

	@Override
	public RecBoardVO2 getOne(int bno) {
		// TODO Auto-generated method stub
		return recMapper.getOne(bno);
	}

	@Override
	public int update(RecBoardVO2 vo) {
		// TODO Auto-generated method stub
		return recMapper.update(vo);
	}

	

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int insertSelectKey(RecBoardVO2 board
								, List<MultipartFile> files
								, List<MultipartFile> Fphotos
								, List<MultipartFile> Sphotos, Model model) throws Exception {
		
		// 게시물 등록
		int res = recMapper.insertSelectKey(board);
		
		// 파일 첨부
		fileservice.fileupload(files, board.getB_NO());
		fileservice.Ffileupload(Fphotos, board.getB_NO());
		fileservice.Sfileupload(Sphotos, board.getB_NO(), model);
		
		
		
		return res;
	}

	
	
	
}
