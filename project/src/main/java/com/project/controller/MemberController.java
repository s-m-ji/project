package com.project.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.service.MemberService;
import com.project.vo.Criteria;
import com.project.vo.MemberVo;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MemberController {

	@Autowired
	MemberService memberservice;

	
	// 회원 목록 조회
	 @GetMapping("/recipe/admin") 
	 public void memberList(Criteria cri,Model model){
	 memberservice.memberList(cri, model); 
	 log.info("cri" +  cri);
	 
	};
	
	
	// 회원 체크박스 삭제 
	@PostMapping("/recipe/delMem")
	public String delMem(@RequestParam("delMno") String[] delMno, Model model)  {
		
		for(String mno : delMno) {
			int delCnt = memberservice.delMem(mno, "Y");
			if(delCnt <= 0) {
				// 삭제건수가 없다는 건 탈퇴(미신청) - mno 값을 failDelMem에 넣기 
				System.out.println(delCnt);
				model.addAttribute("message", "미신청 회원이므로 삭제할 수 없습니다.");
				
			}else{
				// 삭제건수가 있는 경우 탈퇴(신청) 
				System.out.println(delCnt);
				model.addAttribute("message", "탈퇴 신청이 정상적으로 처리되었습니다.");
			}
		}
		return "redirect:/recipe/admin";
	};
}
