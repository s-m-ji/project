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
import com.project.vo.MemberVo;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MemberController {

	@Autowired
	MemberService memberservice;


	// 회원 목록 조회
	 @GetMapping("/recipe/admin") 
	 public void memberList(Model model){
	 List<MemberVo> list =  memberservice.memberList(model); 
	 log.info("controller" +  list);
	};
	
	// 회원 체크박스 삭제 
	@PostMapping("/recipe/delMem")
	public String delMem(@RequestParam("delMno") String[] delMno, Model model)  {
		
		 // 미신청 회원 
		 List<String> delNmem = new ArrayList<String>();
		 
		 // 신청 회원 
		 List<String> delYmem = new ArrayList<String>();
		 
		for(String mno : delMno) {
		
			int delCnt = memberservice.delMem(mno, "Y");
			log.info("삭제 건수 : " + delCnt);
			
			if(delCnt == 0) {
				// 삭제건수가 없다는 건 탈퇴(미신청) - mno 값을 failDelMem에 넣기 
				delNmem.add(mno);
				
			}else if(delCnt > 0 ){
				// 삭제건수가 있는 경우 탈퇴(신청) 
				delYmem.add(mno);
			}else {
				
			}
		}
		
		if(!delNmem.isEmpty()) {
			String delNmnos = String.join(",", delNmem);
			model.addAttribute("delNmnos", delNmnos);
		}
		if(!delYmem.isEmpty()) {
			String delYmnos = String.join(",", delYmem);
			model.addAttribute("delYmnos", delYmnos);
		}
		
		return "redirect:/recipe/admin";
	};
}
