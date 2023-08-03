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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.service.MemberService;
import com.project.vo.Criteria;
import com.project.vo.MemberVo;
import com.project.vo.NoticeVo;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/recipe/*")
public class MemberController {

	@Autowired
	MemberService memberservice;

	
	@GetMapping("message")
	public void message(Model model) {
		
	}
	// 회원 목록 조회
	 @GetMapping("admin") 
	 public void memberList(Criteria cri,Model model){
		 
	
	 memberservice.memberList(cri, model); 
	 System.out.println("🐧회원 : " + cri);
	 
	 // 공지 목록 
	memberservice.noticeList(cri ,model);
	System.out.println("🐥 공지 : " + cri);
	};
	

	// 회원 체크박스 삭제 
	@PostMapping("delMem")
	public String delMem(@RequestParam("delMno") String[] delMno, Model model)  {
		
		for(String mno : delMno) {
			
			int delCnt = memberservice.delMem(mno, "Y");
			
			String message = "";
			if(delCnt <= 0) {
				// 삭제건수가 없다는 건 탈퇴(미신청) - mno 값을 failDelMem에 넣기 
				System.out.println(delCnt);
				model.addAttribute("message", "탈퇴 미신청 회원이므로 삭제할 수 없습니다.");
				model.addAttribute("url", "/recipe/admin");
				return  "/recipe/message";
			}else{
				// 삭제건수가 있는 경우 탈퇴(신청) 
				System.out.println(delCnt);
				message = "회원 탈퇴 신청이 정상적으로 처리되었습니다.";
				model.addAttribute("message",message);
				model.addAttribute("url", "/recipe/admin");
				return  "/recipe/message";
			}
		}
		return  "/recipe/message";
	};
	// 공지 조회하기
	@GetMapping("notice")
	public void noticeList(Criteria cri,Model model) {
		memberservice.noticeList(cri ,model);
		System.out.println("🐥 공지 : " + cri);
	
	};
	
	// 공지 등록하기 
	@PostMapping("writeAction")
	public String noticeWrite(NoticeVo noticevo, Model model, RedirectAttributes rttr) {
		int res = memberservice.noticeWrite(noticevo);
		
		String message = "";
		if(res > 0) {
			message = noticevo.getNno() + "번 글이 등록되었습니다.";
			model.addAttribute("message",message);
			model.addAttribute("url", "/recipe/admin");
			return  "/recipe/message";
		}else {
			model.addAttribute("message", "공지사항 게시 중 오류 발생하였습니다.");
			model.addAttribute("url", "/recipe/admin");
			return  "/recipe/message";
		}
	}
	
	// 공지 수정 페이지 
	@GetMapping("noticeView")
	public String noticeList(Criteria cri,Model model, RedirectAttributes rttr) {
		memberservice.noticeList(cri ,model);
		System.out.println("🐥 공지 : " + cri);
		
		model.addAttribute("message", " 수정 ");
		return "recipe/message";
		
	
	};
	/*
	 * // 공지 수정하기
	 * 
	 * @PostMapping("noticeUpdate")
	 */
	
	// 공지 삭제하기 
	@GetMapping("noticeDel")
	public String noticeDel(@RequestParam("nno")int nno, Model model) {
		
		int res = memberservice.noticeDel(nno);
		System.out.println(nno);
		String message= "";

		if(res > 0) {
			message = nno + "번 글이 삭제되었습니다.";
			model.addAttribute("message", message);
			model.addAttribute("url", "/recipe/admin");
			return "recipe/message";
		}else {
			model.addAttribute("message", "게시글 삭제 중 오류 발생하였습니다.");
			model.addAttribute("url", "/recipe/noticeView");
			return "/recipe/message";
		}
	}
}
