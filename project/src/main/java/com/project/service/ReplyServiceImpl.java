package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.ReplyMapper;
import com.project.vo.GeneralReplyVo;
import com.project.vo.RecipeReplyVo;

@Service
public class ReplyServiceImpl implements ReplyService{

	@Autowired
	ReplyMapper replyMapper;
	
	
	@Override
	public List<RecipeReplyVo> getRecipeReply(int b_no) {
		// TODO Auto-generated method stub
		return replyMapper.getRecipeReply(b_no);
	}


	@Override
	public int replyWrite(RecipeReplyVo vo) {
		// TODO Auto-generated method stub
		return replyMapper.replyWrite(vo);
	}


	@Override
	public int selectPhotoReview(int b_no, String writer) {
		// TODO Auto-generated method stub
		return replyMapper.selectPhotoReview(b_no, writer);
	}


	@Override
	public List<GeneralReplyVo> getGeneralReply(int b_no) {
		// TODO Auto-generated method stub
		return replyMapper.getGeneralReply(b_no);
	}


	@Override
	public int grWrite(GeneralReplyVo vo) {
		// TODO Auto-generated method stub
		return replyMapper.grWrite(vo);
	}


	@Override
	public int replyDelete(int r_no) {
		// TODO Auto-generated method stub
		return replyMapper.replyDelete(r_no);
	}


	@Override
	public int replyEdit(RecipeReplyVo vo) {
		// TODO Auto-generated method stub
		return replyMapper.replyEdit(vo);
	}


	@Override
	public int getRno(int b_no, String nickname) {
		// TODO Auto-generated method stub
		return replyMapper.getRno(b_no, nickname);
	}

}
