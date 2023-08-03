package com.project.mapper;

import java.util.List;

import com.project.vo.AttachVO;

public interface AttachMapper {

	public List<AttachVO> getList(int bno);
	
	public int insert(AttachVO att);
	
	public int delete(AttachVO att);

	public AttachVO getOne(AttachVO att);

	public List<AttachVO> getAllList();
	
}
