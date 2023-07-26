package com.project.mapper;

import java.util.List;

import org.springframework.ui.Model;

import com.project.vo.MemberVo;

public interface MemberMapper {
	
	// 회원 목록 조회
	public List<MemberVo> memberList(Model model);

}
