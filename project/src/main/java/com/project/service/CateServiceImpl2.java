package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.CateMapper2;
import com.project.vo.CategoryVO2;

@Service
public class CateServiceImpl2 implements CateService2 {

	@Autowired
	CateMapper2 mapper;
	
	@Override
	public List<CategoryVO2> getlist() {
		
		return mapper.getlist();
	}

	@Override
	public int insert(CategoryVO2 vo) {

		return mapper.insert(vo);
	}

	
}
