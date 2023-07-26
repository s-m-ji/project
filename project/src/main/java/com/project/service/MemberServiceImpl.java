package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.project.mapper.MemberMapper;
import com.project.vo.MemberVo;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberMapper membermapper;
	
	@Override
	public List<MemberVo> memberList(Model model) {
		List<MemberVo> list = membermapper.memberList(model);
		model.addAttribute("list", list);
		log.info("list ===="+ list);
		return null;
	}

}
