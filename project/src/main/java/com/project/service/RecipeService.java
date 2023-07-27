package com.project.service;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.project.vo.Criteria;

@Service
public interface RecipeService {

	public void getRecList(Model model, Criteria cri);

}
