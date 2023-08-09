package com.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.FileuploadService;
import com.project.service.RecipeService;
import com.project.service.ReplyService;
import com.project.vo.GeneralReplyVo;
import com.project.vo.MemberVo;
import com.project.vo.RecipeReplyVo;

import lombok.extern.log4j.Log4j;

@RestController
@Log4j
public class ReplyController {
	
	@Autowired
	RecipeService recipeService;
	
	@Autowired
	ReplyService service;

	@Autowired
	FileuploadService fileService;

	@PostMapping("/reply/photoReply")
	public Map<String, Object> selectPhotoReview(int r_no, HttpSession session) {

		
		// 
		MemberVo member = session.getAttribute("member") == null ?  null : (MemberVo)session.getAttribute("member");
		
		// select << 게시물에 nickName << 으로 댓글이 달린 적이 있는지 total, or YN 으로 조회
		member.getNickname();
		
		System.out.println("selectPhotoReview 실행 ==================================");

		Map<String, Object> map = new HashMap<String, Object>();

		RecipeReplyVo vo = service.selectPhotoReview(r_no);

		if (vo != null) {

			map.put("photoReply", vo);
			map.put("result", "success");
		} else {
			map.put("result", "fails");
		}

		return map;
	}

	@GetMapping("/replyList/{bno}")
	public Map<String, Object> getRecipeList(@PathVariable("bno") int bno) {

		System.out.println(" getRecipeList 호출 ========================================== ");

		Map<String, Object> map = new HashMap<String, Object>();
		List<RecipeReplyVo> replyList = service.getRecipeReply(bno);
		int replyCnt =recipeService.replyTotalCnt(bno);
		int photoReviewCnt = recipeService.photoTotalCnt(bno);
		
		map.put("replyList", replyList);
		map.put("photoReview", fileService.getPhotoReview(bno));
		map.put("replyCnt", replyCnt);
		map.put("photoReviewCnt", photoReviewCnt);
		
		return map;
	}

	@PostMapping("/reply/write")
	public Map<String, Object> insert(@RequestBody RecipeReplyVo vo) {

		System.out.println("insert 출력 =======================================================");

		log.info("============================== insert");
		log.info("replyVo : " + vo);

		Map<String, Object> map = new HashMap<String, Object>();

		try {

			int res = service.replyWrite(vo);

			map.put("result", "success");

			return map;

		} catch (Exception e) {
			map.put("result", "fail");
			map.put("message", e.getMessage());

		}
		return map;
	}
	
	@GetMapping("/replyDelete/{r_no}")
	public Map<String, Object> delete(@PathVariable("r_no") int r_no){
		
		System.out.println("삭제 호출호출 ================================");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int res = service.replyDelete(r_no);
		
		if(res > 0) {
	
			map.put("result", "success");
		
		}else {
		
			map.put("result", "fail");
		}
			
		return map;
		
	}
	
	
	@PostMapping("/reply/edit")
	public Map<String, Object> edit(@RequestBody RecipeReplyVo vo){
		
		System.out.println("수정 호출호출 ================================");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int res = service.replyEdit(vo);
		
		if(res > 0) {
			
			map.put("result", "success");
		
		}else {
		
			map.put("result", "fail");
		}
			
		return map;
		
	}
	
	

	/**
	 * 일반 댓글 리스트를 불러오는 메서드
	 * 
	 * @param b_no
	 * @return
	 */
	@GetMapping("/reply/generalReply/{b_no}")
	public Map<String, Object> getGeneralReply(@PathVariable("b_no") int b_no) {

		System.out.println("getGeneralReply 실행 !!!!!!!!!!!!!!!!!!!!!!!!!!!");

		Map<String, Object> map = new HashMap<String, Object>();

		try {

			List<GeneralReplyVo> vo = service.getGeneralReply(b_no);

			if (vo != null) {

				map.put("result", "success");
				map.put("generalReply", vo);
			}

			else {

				map.put("result", "success");
			}

		} catch (Exception e) {
			// TODO: handle exception
		}

		return map;
	}

	@PostMapping("/reply/grWrite")
	public Map<String, Object> grWrite(@RequestBody GeneralReplyVo vo) {

		System.out.println("vo 출력 ===========" + vo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("grWrite 실행 !!!!!!!!!!!!!!!!!!!!!!!!!!");

		int res = service.grWrite(vo);

		if (res > 0) {

			map.put("result", "success");

		} else {
			map.put("result", "fail");
		}

		return map;
	}
}
