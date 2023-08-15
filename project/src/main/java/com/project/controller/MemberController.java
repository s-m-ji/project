package com.project.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import com.project.service.MailService;
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

	public static final String ATTACHES_DIR = "c:\\upload\\";

	@Autowired
	MemberService memberservice;

	@Autowired
	AdminFileService adminfileservice;

	@GetMapping("message")
	public void message(Model model) {

	}
	
	@GetMapping("adminHome")
	public String adminHOME() {
		return "/recipe/adminHome";
	}

	// 회원 목록 조회
	@GetMapping("admin")
	public void memberList(Criteria cri, Model model) {
		memberservice.memberList(cri, model);
		System.out.println("🐧회원 : " + cri);

	};

	// 회원 체크박스 삭제
	/*
	@ResponseBody
	@PostMapping("deleMemAction")
	public String deleMemAction(@RequestParam String[] checkBoxArr, Model model, Criteria cri) {

		for (String mno : checkBoxArr) {

			int delCnt = memberservice.delMem(mno, "Y");

			String message = "";
			if (delCnt <= 0) {
				// 삭제건수가 없다는 건 탈퇴(미신청) - mno 값을 failDelMem에 넣기
				System.out.println(delCnt);
				model.addAttribute("message", "탈퇴 미신청 회원이므로 삭제할 수 없습니다.");

				model.addAttribute("url", "/recipe/admin");
				return "/common/message";
			} else {
				// 삭제건수가 있는 경우 탈퇴(신청)
				System.out.println(delCnt);
				message = delCnt + "건 회원 탈퇴 신청이 처리되었습니다.";
				model.addAttribute("message", message);

				model.addAttribute("pageNo", cri.getPageNo());
				model.addAttribute("sField", cri.getSField());
				model.addAttribute("sWord", cri.getSWord());
				model.addAttribute("message", message);

				model.addAttribute("url", "/recipe/admin?pageNo=" + cri.getPageNo() + "&mno=" + mno + "&sField="
						+ cri.getSField() + "&sWord=" + cri.getSWord());
				/* model.addAttribute("url", "/recipe/admin"); */
	/*
				return "/common/message";
			}
		}
		return "/recipe/message";
	};
	*/
	
	// 회원 삭제 
	  @ResponseBody
	   @PostMapping("deleMemAction")
	    public Map<String, Object> deleMemAction(@RequestBody Map<String, Object> requestData) {
	        Map<String, Object> map = new HashMap<String, Object>();
	        
	        try {
	            List<String> checkBoxArr = (List<String>) requestData.get("checkBoxArr");
	            String delyn = (String) requestData.get("delyn");
	            
	            System.out.println(" 선택된 checkbox " + checkBoxArr);
	            int deletedCount = 0;

	            for (String mno : checkBoxArr) {
	                int result = memberservice.delMem(mno, "Y");
	                if (result > 0) {
	                    deletedCount++;
	                }
	            }

	            if (deletedCount > 0) {
	                map.put("result", "success");
	                map.put("message", deletedCount + "명의 회원을 삭제했습니다.");
	            } else {
	                map.put("result", "fail");
	                map.put("message", "삭제 실패");
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            map.put("result", "fail");
	            map.put("message", "삭제 실패");
	        }
	        return map;
	      }

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

			if (res > 0) {
				System.out.println("회원 등록 res = " + res);
				message = membervo.getMno() + "번 회원" + membervo.getName() + "님이  등록되었습니다.";
				log.info("회원 등록 : " + membervo.toString());

				model.addAttribute("message", message);
				model.addAttribute("url", "/recipe/admin");
				return "/common/message";
			} else {
				model.addAttribute("mesage", "회원 등록에 실패하였습니다.");
				model.addAttribute("url", "/recipe/admin");
				return "/common/message";
			}
		} catch (Exception e) {
			if (e.getMessage().indexOf("첨부파일") > -1) {
				model.addAttribute("message", e.getMessage());
			} else {
				model.addAttribute("message", "회원 등록 중 예외 사항 발생-adminInputAction");
			}
			return "/recipe/admin";
		}
	}

	// 회원 수정 페이지
	@GetMapping("adminUpdate")
	public String getMemOne(int mno, Model model) {
		model.addAttribute("memList", memberservice.getMemOne(mno));
		return "/recipe/adminUpdate";
	}

	// 회원 수정 하기
	@PostMapping("adminUpdateAction")
	public String memberUpdate(MemberVo membervo, Model model, Criteria cri, ArrayList<MultipartFile> files)
			throws Exception {
		MemberVo mv = memberservice.getMemOne(membervo.getMno());
		// 이메일, 비밀번호, 이름, 닉네임, 전화번호, 회원사진
		mv.setEmail(mv.getEmail());
		System.out.println(mv.getEmail());
		mv.setPw(mv.getPw());
		mv.setName(mv.getName());
		mv.setNickname(mv.getNickname());
		mv.setPnum(mv.getPnum());

		memberservice.memberList(cri, model);

		int res;

		try {
			res = memberservice.memberUpdate(membervo, files);
			String message;

			System.out.println("수정 건 수 : " + res);
			System.out.println("수정된 멤버 : " + membervo + files);
			if (res > 0) {
				message = res + "건 수정되었습니다.";

				model.addAttribute("pageNo", cri.getPageNo());
				model.addAttribute("sField", cri.getSField());
				model.addAttribute("sWord", cri.getSWord());
				model.addAttribute("message", message);
				model.addAttribute("url", "/recipe/admin?pageNo=" + cri.getPageNo() + "&mno=" + mv.getMno() + "&sField="
						+ cri.getSField() + "&sWord=" + cri.getSWord());
			} else {
				message = "수정 중 오류가 발생하였습니다.";
				model.addAttribute("message", message);
				return "/common/message";
			}
		} catch (Exception e) {
			if (e.getMessage().indexOf("첨부파일") > -1) {
				model.addAttribute("message", e.getMessage());
			} else {
				model.addAttribute("message", "수정 중 예외 발생!!");
			}
		}
		return "/common/message";

	}

	/* 파일(업로드) 관련 */
	// 파일 목록 조회
	@GetMapping("adminList") // rest 방식으로 호출 할 예정
	public @ResponseBody Map<String, Object> fileUploadList() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("FileList", adminfileservice.getAllList());
		System.out.println("FileAllList(membercontroller): " + adminfileservice.getAllList());
		return map;
	}

	// 파일 한건 조회
	@GetMapping("fileList/{mno}")
	public @ResponseBody Map<String, Object> fileList(@PathVariable("mno") int mno) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("FileList", adminfileservice.fileSelect(mno));
		System.out.println("파일 한건 조회 : " + map);
		return map;
	}

	// 파일 삭제
	@GetMapping("fileDelete/{mno}/{uuid}")
	public @ResponseBody Map<String, Object> fileDelete(@PathVariable("mno") int mno,
			@PathVariable("uuid") String uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		int res = adminfileservice.fileDelete(mno, uuid);
		System.out.println("파일 삭제 : " + res);
		if (res > 0) {
			map.put("result", "success");
		} else {
			map.put("result", "fail");
		}
		return map;
	}

	// 파일 이미지 화면에 보여주기
	@GetMapping("displayAdmin")
	// 이미지를 화면에 보여줍니다
	public ResponseEntity<byte[]> display(String filename) {
		log.info("=====fileName : " + filename);

		try {
			// 파일 객체를 생성
			File file = new File(ATTACHES_DIR + filename);
			HttpHeaders headers = new HttpHeaders();

			// 이미지 파일이 존재하면 파일을 이미지를 다운로드
			if (file.exists()) {
				// Mime타입을 설정
				headers.add("Content-Type", Files.probeContentType(file.toPath()));
				return new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
			} else {
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}

		} catch (IOException e) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}

	// 공지 조회하기
	@GetMapping("notice")
	public void noticeList(Criteria cri, Model model) {
		memberservice.noticeList(cri, model);
		System.out.println("🐥 공지 : " + cri);

	};

	// 공지 등록하기
	@PostMapping("writeAction")
	public String noticeWrite(NoticeVo noticevo, Model model) {
		int res = memberservice.noticeWrite(noticevo);
		log.info(noticevo.toString());
		String message = "";
		if (res > 0) {
			message = noticevo.getNno() + "번 글이 등록되었습니다.";
			model.addAttribute("message", message);
			model.addAttribute("url", "/recipe/notice");
			return "/common/message";
		} else {
			model.addAttribute("message", "공지사항 등록에 실패하였습니다.");
			model.addAttribute("url", "/recipe/notice");
			return "/common/message";
		}
	}

	// 공지 수정하기 Action
	@PostMapping("noticeUpdate")
	@ResponseBody
	public String noticeUpdate(NoticeVo noticevo, Model model) {
		System.out.println("수정 :" + noticevo);
		int res = memberservice.noticeUpdate(noticevo);

		log.info("수정 : " + noticevo.toString());
		log.info("res " + res);
		String message = "";
		if (res > 0) {
			message = noticevo.getNno() + "번 글이 수정되었습니다.";
			model.addAttribute("message", message);
			model.addAttribute("url", "/recipe/notice");
			return "/common/message";
		} else {
			model.addAttribute("message", "공지사항  수정 오류 발생!! ");
			model.addAttribute("url", "/recipe/notice");
			return "/common/message";
		}

	}

	// 공지 삭제하기
	@GetMapping("noticeDel")
	public String noticeDel(@RequestParam("nno") int nno, Model model) {

		int res = memberservice.noticeDel(nno);
		System.out.println(nno);
		String message = "";

		if (res > 0) {
			message = nno + "번 글이 삭제되었습니다.";
			model.addAttribute("message", message);
			model.addAttribute("url", "/recipe/notice");
			return "/common/message";
		} else {
			model.addAttribute("message", "게시글 삭제 중 오류 발생하였습니다.");
			model.addAttribute("url", "/recipe/notice");
			return "/common/message";
		}
	}

	@GetMapping("reward")
	public void rewardList(Model model) {
		memberservice.rewardListReal(model);
	}

	// 리워드 페이지 (
	@GetMapping("reward/list/{startDate}/{endDate}")
	@ResponseBody
	public Map<String, Object> rewardList(@PathVariable("startDate") String startDate,
			@PathVariable("endDate") String endDate) {

		System.out.println(startDate + " endDate : " + endDate);
		Map<String, Object> map = new HashMap<String, Object>();

		List<MemberVo> rewardList = memberservice.rewardList(startDate, endDate);
		System.out.println(rewardList);
		map.put("rewardList", rewardList);
		return map;
	}

	// 리워드 수정
	@PostMapping("reward/gradeUpdateAction")
	@ResponseBody
	public Map<String, Object> gradeUpdate(@RequestBody MemberVo membervo) {
		Map<String, Object> map = new HashMap<String, Object>();
		int res = memberservice.gradeUpdate(membervo);
		map.put("res", res);
		System.out.println("reward 변경 건수 : " + res);
		return map;
	}
	
	
	//  마이페이지
	@GetMapping("myPage")
	public String myPage() {
		return "/recipe/myPage";
	}
	// 마이페이지 수정 (상세 페이지)
	@GetMapping("myPageUpdate")
	public String myPageUpdate(int mno, Model model) {
		model.addAttribute("myList", memberservice.getMemOne(mno));
		return "/recipe/myPageUpdate";
	}

	// 마이페이지 수정 Action (처리)
	@PostMapping("myPageUpdateAction")
	public String myPageUpdate(MemberVo membervo, Model model, Criteria cri, ArrayList<MultipartFile> files)
			throws Exception {
		MemberVo mv = memberservice.getMemOne(membervo.getMno());
		// 이메일, 비밀번호, 이름, 닉네임, 전화번호, 회원사진
		mv.setEmail(mv.getEmail());
		mv.setPw(mv.getPw());
		mv.setName(mv.getName());
		mv.setNickname(mv.getNickname());
		mv.setPnum(mv.getPnum());

		memberservice.memberList(cri, model);

		int res;

		try {
			res = memberservice.memberUpdate(membervo, files);
			String message;

			System.out.println("마이페이지 수정 건 수 : " + res);
			System.out.println("수정된 나의 목록 : " + membervo + files);
			if (res > 0) {
				message = res + "건 수정되었습니다.";
				
				/*
				 * model.addAttribute("pageNo", cri.getPageNo());
				 * 
				 * model.addAttribute("sField", cri.getSField()); model.addAttribute("sWord",
				 * cri.getSWord());
				 */
				model.addAttribute("message", message);
				model.addAttribute("url", "/recipe/myPage2?mno=" + mv.getMno());
			} else {
				message = "수정 중 오류가 발생하였습니다.";
				model.addAttribute("message", message);
				return "/common/message";
			}
		} catch (Exception e) {
			if (e.getMessage().indexOf("첨부파일") > -1) {
				model.addAttribute("message", e.getMessage());
			} else {
				model.addAttribute("message", "수정 중 예외 발생!!");
			}
		}
		return "/common/message";

	}
	
	// 마이페이지 수정  ( 탈퇴 신청 ) 
		@PostMapping("myPageDel")
		public String myPageDel(MemberVo membervo, Model model) {
			MemberVo mv = memberservice.getMemOne(membervo.getMno());
			mv.setDelyn(mv.getDelyn());
			int res;
			try {
				res = memberservice.myPageDel(mv.getMno());
				String message;
				System.out.println("마이페이지 탈퇴신청 건 수 : " + res);
				if (res > 0) {
					message =  " 탈퇴 신청이 완료되었습니다.";
					model.addAttribute("message", message);
					model.addAttribute("url", "/recipe/myPage2?mno=" + mv.getMno());
				}else {
					message = "탈퇴 신청 중 오류가 발생하였습니다.";
					model.addAttribute("message", message);
					return "/common/message";
				}
			} catch (Exception e) {
				if (e.getMessage().indexOf("첨부파일") > -1) {
					model.addAttribute("message", e.getMessage());
				} else {
					model.addAttribute("message", "수정 중 예외 발생!!");
				}
			}
			return "/common/message";
		}


	
	
	// 광민

	@Autowired
	MailService mailservice;

	/**
	 * 로그인 페이지로 이동
	 * 
	 * @return
	 */
	@GetMapping("/login")
	public String loginPage() {
		return "/recipe/login";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "login";
	}

//		@GetMapping("/main")
//		public String main() {
//			return "recipe/main";
//		}

	@GetMapping("/register")
	public String registerPage() {
		return "recipe/register";
	}

	@PostMapping("/loginAction")
	public @ResponseBody Map<String, Object> loginAction(@RequestBody MemberVo member, Model model,
			HttpSession session) {
		System.out.println("email : " + member.getEmail());
		System.out.println("pw : " + member.getPw());

		member = memberservice.login(member);

		if (member != null) {
			session.setAttribute("member", member);
			session.setAttribute("userEmail", member.getEmail());
			Map<String, Object> map = responseMap(REST_SUCCESS, "로그인 되었습니다.");
			map.put("url", "/recipe/main");

			return map;
		} else {
			return responseMap(REST_FAIL, "이메일, 비밀번호를 확인해주세요.");
		}

		// service.login(member, model);
		// model.addAttribute("message", member.getName() + "환영합니다.");
		// return "main";
	}

	private final String REST_WRITE = "등록";
	protected final String REST_SUCCESS = "success";
	protected final String REST_FAIL = "fail";

	public Map<String, Object> responseMap(int res, String msg) {
		Map<String, Object> map = new HashMap<String, Object>();

		if (res > 0) {
			map.put("result", REST_SUCCESS);
			map.put("msg", msg + " 되었습니다.");
		} else {
			map.put("result", REST_FAIL);
			map.put("msg", msg + "중 예외가 발생하였습니다.");
		}

		return map;
	}

	public Map<String, Object> responseWriteMap(int res) {
		return responseMap(res, REST_WRITE);
	}

	public Map<String, Object> responseMap(String result, String msg) {
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("result", result);
		map.put("msg", msg);

		return map;
	}

	@PostMapping("/emailCheck")
	public @ResponseBody Map<String, Object> emailCheck(@RequestBody MemberVo member) {

		int res = memberservice.emailCheck(member);

		if (res == 0) {
			return responseMap(REST_SUCCESS, "사용가능한 아이디 입니다.");
		} else {
			return responseMap(REST_FAIL, "이미 사용중인 아이디 입니다.");
		}

	}

	// 이메일 인증번호 발송
	@PostMapping("/confirmEmail")
	public ResponseEntity<Map<String, Boolean>> confirmEmail(HttpSession session,
			@RequestBody Map<String, String> requestData) {
		String email = requestData.get("email");
		boolean emailExists = memberservice.emailExists(email);

		if (emailExists) {
			return ResponseEntity.ok(Map.of("exists", true));
		} else {
			String verificationCode = mailservice.ConfirmEmailGenerator();
			mailservice.confirmEmail(email, verificationCode);
			session.setAttribute("verificationCode", verificationCode);
			return ResponseEntity.ok(Map.of("success", true));
		}
	}

	// 이메일 인증번호 검증
	@PostMapping("/verifyConfirmationCode")
	public ResponseEntity<Map<String, String>> verifyConfirmationCode(HttpSession session,
			@RequestBody Map<String, String> requestData) {
		String confirmCode = requestData.get("confirmCode");
		String verificationCode = (String) session.getAttribute("verificationCode");
		System.out.println("confirmCode : " + confirmCode);
		System.out.println("verificationCode : " + verificationCode);

		if (verificationCode != null && verificationCode.equals(confirmCode)) {
			return ResponseEntity.ok(Map.of("success", "success"));
		} else {
			return ResponseEntity.ok(Map.of("fail", "fail"));
		}
	}

	// 닉네임 중복 체크
	@PostMapping("/nicknameCheck")
	public @ResponseBody Map<String, Object> nicknameCheck(@RequestBody MemberVo member) {

		int res = memberservice.nicknameCheck(member);

		if (res == 0) {
			return responseMap(REST_SUCCESS, "사용가능한 닉네임 입니다.");
		} else {
			return responseMap(REST_FAIL, "이미 사용중인 닉네임 입니다.");
		}

	}

	// 회원가입
	@PostMapping("/register")
	public @ResponseBody Map<String, Object> register(@RequestBody MemberVo member) {
		try {
			System.out.println("member : " + member);
			int res = memberservice.insert(member);
			return responseWriteMap(res);

		} catch (Exception e) {
			e.printStackTrace();
			return responseMap(REST_FAIL, "등록중 예외사항이 발생 하였습니다.");
		}
	}

	// 아이디 찾기 폼을 보여주는 페이지로 이동
	@GetMapping("/findEmailForm")
	public String showFindEmailForm() {
		return "recipe/find-email-form"; // find-email-form.jsp 페이지로 이동
	}

	@PostMapping("/recipe/findEmail")
	public String findEmail(MemberVo member, Model model) {
		// 아이디 찾기 로직을 구현
		String email = memberservice.findEmailBy(member);
		System.out.println("email : " + email);
		if (email != null) {
			model.addAttribute("foundEmail", email);
			// System.out.println(email);
			return "recipe/find-email-form";
		} else {
			model.addAttribute("error", "해당 이름과 전화번호로 등록된 이메일이 없습니다.");
			return "recipe/find-email-form";
		}
	}

	// 임시 비밀번호 발급 폼을 보여주는 페이지로 이동
	@GetMapping("/sendPwForm")
	public String showsendPwForm() {
		return "recipe/send-pw-form"; // send-pw-form.jsp 페이지로 이동
	}

	@PostMapping("/recipe/sendPw")
	public String sendPw(MemberVo member, Model model) {
		// 아이디 찾기 로직을 구현
		return memberservice.sendPwBy(member, model);
	}
}
