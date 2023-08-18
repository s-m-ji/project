package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.project.mapper.AttachMapper;
import com.project.mapper.RecipeListMapper;
import com.project.vo.AttachVO;
import com.project.vo.BoardVO;
import com.project.vo.PageDto;
import com.project.vo.Criteria;

@Service
public class RecipeListServiceImpl implements RecipeListService {
	
	@Autowired
	RecipeListMapper rMapper;
	
	@Autowired
	AttachService aService;

	// ========== 레시피 게시판 (rec_board)
	@Override
	public void getRecList(Model model, Criteria cri) {
		System.out.println("[RecipeListServiceImpl] getRecList 실행");
			if(cri.getAmount() == 10) {
				cri.setAmount(6);
			} else {
				cri.setAmount(cri.getAmount());
			}
			cri.setPageNo(cri.getPageNo());
		
		List<BoardVO> list = rMapper.getRecList(cri);
		// System.out.println("*** list : " + list);
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

	
	// ========== 커뮤니티 게시판 (com_board)
	@Override
	public void getComList(Model model, Criteria cri) {
		System.out.println("[RecipeListServiceImpl] getComList 실행");
		List<BoardVO> list = rMapper.getComList(cri);
		model.addAttribute("list", list);
		
		int totalCnt = rMapper.getComListTotalCnt(cri); 
		System.out.println("totalCnt : "  + totalCnt);

		PageDto pageDto = new PageDto(cri, totalCnt);
		System.out.println("pageDto : "  + pageDto);
		
		model.addAttribute("tCnt", totalCnt); 
		model.addAttribute("pDto", pageDto);
		
	}

	@Override
	public BoardVO getComOne(int com_BNO) {
		return rMapper.getComOne(com_BNO);
	}

}
