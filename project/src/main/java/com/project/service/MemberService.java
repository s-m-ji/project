package com.project.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.project.vo.MemberVo;

@Service
public interface MemberService {
	// 회원 목록 조회
	public List<MemberVo> memberList(Model model);

	// 회원 선택 삭제
	public int delMem(@Param("mno")String mno,@Param("delyn")String delyn);
}
