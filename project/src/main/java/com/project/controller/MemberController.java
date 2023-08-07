package com.project.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.service.AdminFileService;
import com.project.service.MemberService;
import com.project.vo.Criteria;
import com.project.vo.MemberVo;
import com.project.vo.NoticeVo;

import lombok.extern.log4j.Log4j;
import oracle.jdbc.proxy.annotation.Post;

@Log4j
@Controller
@RequestMapping("/recipe/*")
public class MemberController {

	
	public static final String ATTACHES_DIR ="c:\\upload\\";
	
	@Autowired
	MemberService memberservice;
	
	@Autowired
	AdminFileService adminfileservice;

	@GetMapping("message")
	public void message(Model model) {
		
	}
	
	@GetMapping("adminHOME")
	public void adminHOME() {
		
	}
	// 회원 목록 조회
	 @GetMapping("admin") 
	 public void memberList(Criteria cri,Model model){
	 memberservice.memberList(cri, model); 
	 System.out.println("🐧회원 : " + cri);
	 
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
				return  "/common/message";
			}else{
				// 삭제건수가 있는 경우 탈퇴(신청) 
				System.out.println(delCnt);
				message = "회원 탈퇴 신청이 정상적으로 처리되었습니다.";
				model.addAttribute("message",message);
				model.addAttribute("url", "/recipe/admin");
				return  "/common/message";
			}
		}
		return  "/recipe/message";
	};
	
	
	// 회원 등록 페이지
	@GetMapping("adminInput")
	public void adminInputMember() {
		
	}
	
	// 회원 등록 처리
	@PostMapping("adminInputAction")
	public String adminInput(MemberVo membervo, Model model, ArrayList<MultipartFile> files) {
		int res;
		
		try {
			res = memberservice.adminInput(membervo, files);
			String message;
			
			if(res > 0) {
				System.out.println("회원 등록 res = "+ res);
				message = membervo.getMno() + "번 회원"+membervo.getName()+"님이  등록되었습니다.";
				log.info("회원 등록 : 👨🏻‍👩🏻‍👧🏻‍👦🏼" + membervo.toString());

				model.addAttribute("message", message);
				model.addAttribute("url", "/recipe/admin");
				return "/common/message";
			}else {
				model.addAttribute("mesage", "회원 등록에 실패하였습니다.");
				model.addAttribute("url", "/recipe/admin");
				return "/common/message";
			}
		} catch (Exception e) {
			if(e.getMessage().indexOf("첨부파일")>-1) {
				model.addAttribute("message", e.getMessage());
			}else {
				model.addAttribute("message", "회원 등록 중 예외 사항 발생-adminInputAction");
			}
			return "/recipe/admin";
		}
	}
	
	// 파일 목록 조회
	@GetMapping("adminList") // rest 방식으로 호출 할 예정
	public @ResponseBody Map<String, Object> fileUploadList() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("FileList", adminfileservice.getAllList());
		System.out.println("FileAllList : " + adminfileservice.getAllList());
		return map;
	}
	
	// 파일 이미지 화면에 보여주기 
	@GetMapping("displayAdmin")
	// 이미지를 화면에 보여줍니다
	public ResponseEntity<byte[]> display(String filename) {
		log.info("=====fileName : " + filename);
		
		try {
			// 파일 객체를 생성
			File file = new File(ATTACHES_DIR+filename);
			HttpHeaders headers = new HttpHeaders();
			
			// 이미지 파일이 존재하면 파일을 이미지를 다운로드
			if(file.exists()) {
				// Mime타입을 설정
				headers.add("Content-Type",Files.probeContentType(file.toPath()));
				return new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
			}else {
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}
			
		} catch (IOException e) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
	}
	
	// 공지 조회하기
	@GetMapping("notice")
	public void noticeList(Criteria cri,Model model) {
		memberservice.noticeList(cri ,model);
		System.out.println("🐥 공지 : " + cri);
	
	};
	
	// 공지 등록하기 
	@PostMapping("writeAction")
	public String noticeWrite(NoticeVo noticevo, Model model) {
		int res = memberservice.noticeWrite(noticevo);
		log.info(noticevo.toString());
		String message = "";
		if(res > 0) {
			message = noticevo.getNno() + "번 글이 등록되었습니다.";
			model.addAttribute("message",message);
			model.addAttribute("url", "/recipe/notice");
			return  "/common/message";
		}else {
			model.addAttribute("message", "공지사항 등록에 실패하였습니다.");
			model.addAttribute("url", "/recipe/notice");
			return  "/common/message";
		}
	}
	
	// 공지 수정하기 Action
	  @PostMapping("noticeUpdate")
	  @ResponseBody
	public String noticeUpdate(NoticeVo noticevo, Model model){
		  System.out.println("수정 :"+ noticevo);
		  int res = memberservice.noticeUpdate(noticevo);
			
		  log.info("수정 : " +  noticevo.toString());
		  log.info("res " + res);
		  String message = "";
			if(res > 0) {
				message = noticevo.getNno() + "번 글이 수정되었습니다.";
				model.addAttribute("message",message);
				model.addAttribute("url", "/recipe/notice");
				return  "/common/message";
			}else {
				model.addAttribute("message", "공지사항  수정 오류 발생!! ");
				model.addAttribute("url", "/recipe/notice");
				return  "/common/message";
			}
		
	  }	
	
	// 공지 삭제하기 
	@GetMapping("noticeDel")
	public String noticeDel(@RequestParam("nno")int nno, Model model) {
		
		int res = memberservice.noticeDel(nno);
		System.out.println(nno);
		String message= "";

		if(res > 0) {
			message = nno + "번 글이 삭제되었습니다.";
			model.addAttribute("message", message);
			model.addAttribute("url", "/recipe/notice");
			return "/common/message";
		}else {
			model.addAttribute("message", "게시글 삭제 중 오류 발생하였습니다.");
			model.addAttribute("url", "/recipe/notice");
			return "/common/message";
		}
	}
	  
	@GetMapping("reward")
	public void rewardList() {
		
	}
	// 리워드 페이지 (
	@GetMapping("reward/list/{startDate}/{endDate}")
	@ResponseBody
	public Map<String, Object> rewardList(@PathVariable("startDate")String startDate
										,@PathVariable("endDate")String endDate) {
		
		System.out.println(startDate + " endDate : " + endDate );
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<MemberVo> rewardList = memberservice.rewardList(startDate, endDate);
		System.out.println(rewardList);
		map.put("rewardList", rewardList);
		return map;
	}
	
	// 리워드 수정 
	@PostMapping("reward/gradeUpdateAction")
	@ResponseBody
	public Map<String, Object> gradeUpdate(@RequestBody MemberVo membervo){
		Map<String, Object> map = new HashMap<String, Object>();
		int res  = memberservice.gradeUpdate(membervo);
		map.put("res", res);
		System.out.println("reward 변경 건수 : " + res);
		return map;
	}
	
	  
}
