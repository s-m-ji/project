package com.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.RecMatMapper2;
import com.project.vo.RecMatVO2;

@Service
public class RecMatServiceImpl2 implements RecMatService2{

	@Autowired
	RecMatMapper2 mapper;
	
	@Override
	public int insert(RecMatVO2 vo) {
		// TODO Auto-generated method stub
		return mapper.insert(vo);
	}

	
}
