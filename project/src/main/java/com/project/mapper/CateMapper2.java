package com.project.mapper;

import java.util.List;

import com.project.vo.CategoryVO2;

public interface CateMapper2 {

	public List<CategoryVO2> getlist();
	
	public int insert(CategoryVO2 vo);
}
