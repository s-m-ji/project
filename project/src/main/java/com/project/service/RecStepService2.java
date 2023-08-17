package com.project.service;

import org.springframework.stereotype.Service;

import com.project.vo.RecStepVO2;

@Service
public interface RecStepService2 {
	
	public int insert(RecStepVO2 vo);
	
	public int selectStepSEQ();
}
