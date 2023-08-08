package com.project.mapper;

import java.util.List;

import com.project.vo.BoardVO;
import com.project.vo.Criteria;

public interface RecipeListMapper {

	public List<BoardVO> getRecList(Criteria cri);

	public int getListTotalCnt(Criteria cri);

	public BoardVO getOne(int b_NO);
	

	public List<BoardVO> getComList(Criteria cri);
	
	public BoardVO getComOne(int b_NO);
	
	public int getComListTotalCnt(Criteria cri);

}
