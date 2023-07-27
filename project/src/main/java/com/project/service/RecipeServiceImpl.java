package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.project.mapper.RecipeMapper;
import com.project.vo.BoardVO;
import com.project.vo.PageDto;
import com.project.vo.Criteria;

@Service
public class RecipeServiceImpl implements RecipeService {
	
	@Autowired
	private RecipeMapper rMapper;

	// ※ 현재 rec_table VO가 없어서 BoardVO로 대체 테스트 중
	@Override
	public void getRecList(Model model, Criteria cri) {
		List<BoardVO> list = rMapper.getRecList(cri);
		int totalCnt = rMapper.getListTotalCnt(cri);
		PageDto pageDto = new PageDto(cri, totalCnt);
		
		model.addAttribute("list", list);
		model.addAttribute("tCnt", totalCnt);
		model.addAttribute("pDto", pageDto);
	}

}
