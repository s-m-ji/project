package com.project.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.project.vo.GeneralReplyVo;
import com.project.vo.RecipeReplyVo;

@Service
public interface ReplyService {

	
	public List<RecipeReplyVo> getRecipeReply(int b_no);
	
	public int replyWrite(RecipeReplyVo vo);
	
	public int selectPhotoReview(@Param("b_no")int b_no, @Param("writer")String writer);
	
	public List<GeneralReplyVo> getGeneralReply(int b_no);
	
	public int grWrite(GeneralReplyVo vo);
	
	public int replyDelete(int r_no);

	public int replyEdit(RecipeReplyVo vo);
}
