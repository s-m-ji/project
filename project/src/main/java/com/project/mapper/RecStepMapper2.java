package com.project.mapper;

import com.project.vo.RecStepVO2;

public interface RecStepMapper2 {

	public int insert(RecStepVO2 vo);
	
	public int selectStepSEQ();
	
	public int minusSno(int B_NO);
}
