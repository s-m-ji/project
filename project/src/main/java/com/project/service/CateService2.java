package com.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.vo.CategoryVO2;

@Service
public interface CateService2 {

public List<CategoryVO2> getlist();
	
	public int insert(CategoryVO2 vo);
}
