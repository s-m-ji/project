package com.project.mapper;

import java.util.List;

import com.project.vo.ComBoardVO;

public interface ComMapper {

	public List<ComBoardVO> list();
	
	public int insert(ComBoardVO vo);
	
	public int delete(int bno);
	
	public ComBoardVO getOne(int bno);
	
	public int update(ComBoardVO vo);
	
	int insertSelectKey(ComBoardVO board);
	
	
	
	
}
