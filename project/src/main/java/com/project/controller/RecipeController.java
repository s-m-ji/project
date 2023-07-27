package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.service.RecipeService;
import com.project.vo.Criteria;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/recipe/*")
public class RecipeController {
	
	@Autowired
	RecipeService rService;

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
		rService.getRecList(model, cri);
		
	}
	
	
}
