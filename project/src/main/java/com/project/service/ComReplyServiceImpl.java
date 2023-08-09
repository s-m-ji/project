package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.ComReplyMapper;
import com.project.vo.ComReplyVO;

@Service
public class ComReplyServiceImpl implements ComReplyService{

	@Autowired
	ComReplyMapper mapper;

	@Override
	public List<ComReplyVO> getList(int bno) {
		// TODO Auto-generated method stub
		return mapper.getList();
	}

	@Override
	public int insert(ComReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.insert(vo);
	}

	@Override
	public int delete(int R_NO ) {
		// TODO Auto-generated method stub
		return mapper.delete(R_NO );
	}

	@Override
	public int update(ComReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}
	
	
	@Override
	public List<ComReplyVO> getMyReplies(int com_bno) {
		// TODO Auto-generated method stub
		return mapper.getMyReplies(com_bno);
	}

	@Override
	public ComReplyVO getone(int R_NO) {
		// TODO Auto-generated method stub
		return mapper.getone(R_NO);
	}

	@Override
	public int getTotalCnt() {
		// TODO Auto-generated method stub
		return mapper.getTotalCnt();
	}

	@Override
	public int getCom_bnoCnt(int R_NO) {
		// TODO Auto-generated method stub
		return mapper.getCom_bnoCnt(R_NO);
	}


}
