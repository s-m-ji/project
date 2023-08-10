package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.vo.ComFileVO;

public interface ComFileMapper {

	public List<ComFileVO> getList(int bno);
	
	public int insert(ComFileVO vo);
	
	public int delete(@Param("com_bno")int com_bno
						, @Param("uuid") String uuid);
	
	public ComFileVO getOne(@Param("com_bno")int com_bno );
}
