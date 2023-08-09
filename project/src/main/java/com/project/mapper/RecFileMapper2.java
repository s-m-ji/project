package com.project.mapper;

import java.util.List;

import com.project.vo.RecFileVO2;

public interface RecFileMapper2 {

	public List<RecFileVO2> getList(int bno);
	
	public int insert(RecFileVO2 vo);
}
