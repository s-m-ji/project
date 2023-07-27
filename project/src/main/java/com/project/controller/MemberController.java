package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.service.MemberService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MemberController {

	@Autowired
	MemberService memberservice;

//
	// 회원 목록 조회
	 @GetMapping("/recipe/admin") 
	 public void memberList(Model model){
	 memberservice.memberList(model); 
	};
	 

}
