package com.project.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.project.vo.MemberVo;

@Service
public interface MemberService {
	// 회원 목록 조회
	public List<MemberVo> memberList(Model model);
}
