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
	RecipeMapper rMapper;

	// ※ 현재 rec_table VO가 없어서 BoardVO로 대체 테스트 중
	@Override
	public void getRecList(Model model, Criteria cri) {
		System.out.println("=========================== getRecList 실행");
		List<BoardVO> list = rMapper.getRecList(cri);
		System.out.println("*** list : " + list);
		model.addAttribute("list", list);
		
		int totalCnt = rMapper.getListTotalCnt(cri); 
		System.out.println("totalCnt : "  + totalCnt);

		PageDto pageDto = new PageDto(cri, totalCnt);
		System.out.println("pageDto : "  + pageDto);
		
		model.addAttribute("tCnt", totalCnt); 
		model.addAttribute("pDto", pageDto);
		

	}

	@Override
	public BoardVO getOne(int b_NO) {
		return rMapper.getOne(b_NO);
	}

}
