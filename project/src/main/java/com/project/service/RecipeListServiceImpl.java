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

	// ※ 현재 rec_table VO가 없어서 BoardVO로 대체 테스트 중
	@Override
	public void getRecList(Model model, Criteria cri) {
		System.out.println("=========================== 서비스 임플 getRecList 실행");
		List<BoardVO> list = rMapper.getRecList(cri);
		// System.out.println("*** list : " + list);
		model.addAttribute("list", list);
		
		int totalCnt = rMapper.getListTotalCnt(cri); 
		System.out.println("totalCnt : "  + totalCnt);

		PageDto pageDto = new PageDto(cri, totalCnt);
		System.out.println("pageDto : "  + pageDto);
		
		model.addAttribute("tCnt", totalCnt); 
		model.addAttribute("pDto", pageDto);
		
		// 게시글 번호에 해당하는 파일 목록 조회
		/*
		 * List<AttachVO> fileList = aService.getList(list.get(0).getB_NO());
		 * model.addAttribute("file", fileList); System.out.println("여기 파일 있어요 ! : " +
		 * aService.getList(list.get(0).getB_NO()));
		 */

	}

	@Override
	public BoardVO getOne(int b_NO) {
		return rMapper.getOne(b_NO);
	}

}
