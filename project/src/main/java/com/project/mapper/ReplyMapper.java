package com.project.mapper;

import java.util.List;

import com.project.vo.GeneralReplyVo;
import com.project.vo.RecipeReplyVo;

public interface ReplyMapper {

	
	public List<RecipeReplyVo> getRecipeReply(int b_no);
	
	// 
	public int replyWrite(RecipeReplyVo vo);
	
	
	public RecipeReplyVo selectPhotoReview(int r_no);
	
	// 일반 댓글 리스트 조회
	public List<GeneralReplyVo> getGeneralReply(int b_no);
	
	// 일반 댓글 작성
	public int grWrite(GeneralReplyVo vo);
	
	public int replyDelete(int r_no);

	public int replyEdit(RecipeReplyVo vo);
}
