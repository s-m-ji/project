package com.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.RecStepMapper2;
import com.project.vo.RecStepVO2;

@Service
public class RecStepServiceImpl2 implements RecStepService2{

	@Autowired
	RecStepMapper2 mapper;

	@Override
	public int insert(RecStepVO2 vo) {
		// TODO Auto-generated method stub
		return mapper.insert(vo);
	}
}
