package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.project.mapper.ComMapper;
import com.project.vo.ComBoardVO;

@Service
public class ComBoardServiceImpl implements ComBoardService {

	@Autowired
	private ComMapper commapper;
	
	@Autowired
	private ComFileService comfileservice;
	
	@Override
	public List<ComBoardVO> getlist(Model model) {
	    List<ComBoardVO> list = commapper.list();
	    model.addAttribute("list", list);
	    return list;
	}

	@Override
	public int insert(ComBoardVO vo) {
		
		return commapper.insert(vo);
	}

	@Override
	public int delete(int bno) {
		// TODO Auto-generated method stub
		return commapper.delete(bno);
	}

	@Override
	public ComBoardVO getOne(int bno ) {
		// TODO Auto-generated method stub
		return commapper.getOne(bno);
	}

	@Override
	public int update(ComBoardVO board , List<MultipartFile> photos) throws Exception {
		// TODO Auto-generated method stub
		return commapper.update(board);
	}
	
	

	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int insertSelectKey(ComBoardVO board
								, List<MultipartFile> photos) throws Exception {
		
		// 게시물 등록
		int res = commapper.insertSelectKey(board);
		
		// 파일 첨부
		comfileservice.fileupload(photos, board.getCom_bno());
		
		
		return res;
	}

	
}
