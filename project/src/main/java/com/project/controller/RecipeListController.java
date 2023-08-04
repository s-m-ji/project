package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.vo.BoardVO;
import com.project.service.RecipeListService;
import com.project.vo.Criteria;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/recipe/*")
public class RecipeListController {
	
	@Autowired
	RecipeListService rService;

	/**
	 * ▶ list.jsp로 이동
	 * @param model
	 * @param cri
	 * @author 지상미
	 */
	@GetMapping("list")
	public void getRecList(Model model, Criteria cri) {
	}
	
	@GetMapping("list_test")
	public void getRecList_test(Model model, Criteria cri) {
		System.out.println("================================ 컨트롤러 getRecList 실행");
		rService.getRecList(model, cri);
	}
	
	@GetMapping("com_list")
	public void getComList(Model model, Criteria cri) {
		System.out.println("================================ getComList 실행");
		rService.getRecList(model, cri);
	}

	
	@GetMapping("view_test")
	public void getRecOne(Model model,BoardVO paramVO) {
		System.out.println("================================ getRecOne 실행");
		BoardVO board = rService.getOne(paramVO.getB_NO());
		model.addAttribute("book", board);
		
	}
	
	@GetMapping("com_view_test")
	public void getComOne(Model model,BoardVO paramVO) {
		System.out.println("================================ getComOne 실행");
		BoardVO board = rService.getOne(paramVO.getB_NO());
		model.addAttribute("book", board);
		
	}
	
	@GetMapping("load") // 로딩페이지 
	public void load() {
		
	}
	
}