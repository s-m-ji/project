
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
// @RequestMapping("/recipe/*")
public class RecipeListController {
	
	@Autowired
	RecipeListService rService;
	
	@GetMapping("mimiTest")
	public void mimiTest() {
		
	}
	
	
	/**
	 * ▶ list.jsp로 이동
	 * @param model
	 * @param cri
	 * @author 지상미
	 */
	@GetMapping("/recipe/list")
	public void getRecList(Model model, Criteria cri) {
		System.out.println("[RecipeListController] getRecList 실행");
		rService.getRecList(model, cri);
	}
	
	@GetMapping("/recipe/com_list")
	public void getComList(Model model, Criteria cri) {
		System.out.println("[RecipeListController] getComList 실행");
		rService.getComList(model, cri);
	}

	@GetMapping("/error/load") // 로딩페이지 
	public void load() {
		
	}
	
}
