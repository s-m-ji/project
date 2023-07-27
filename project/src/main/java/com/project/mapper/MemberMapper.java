package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.ui.Model;

import com.project.vo.MemberVo;

public interface MemberMapper {
	
	// 회원 목록 조회
	public List<MemberVo> memberList();
	
	// 회원 삭제 
	public int delMem(@Param("mno")String mno,@Param("delyn")String delyn);

}
