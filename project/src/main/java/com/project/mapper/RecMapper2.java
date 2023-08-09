package com.project.mapper;

import java.util.List;

import com.project.vo.RecBoardVO2;

public interface RecMapper2 {
	
	public List<RecBoardVO2> getlist();
	
	public int insert(RecBoardVO2 vo);
	
	public int delete(int bno);
	
	public RecBoardVO2 getOne(int bno);
	
	public int update(RecBoardVO2 vo);
	
	public int insertSelectKey(RecBoardVO2 board);

}
