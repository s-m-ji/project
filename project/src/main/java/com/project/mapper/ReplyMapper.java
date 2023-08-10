package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.vo.GeneralReplyVo;
import com.project.vo.RecipeReplyVo;

public interface ReplyMapper {

	
	public List<RecipeReplyVo> getRecipeReply(int b_no);
	
	// 
	public int replyWrite(RecipeReplyVo vo);
	
	// 매개변수 2개 이상 << Param << 붙여야함.
	public int selectPhotoReview(@Param("b_no") int b_no, @Param("writer")String writer);
	
	// 일반 댓글 리스트 조회
	public List<GeneralReplyVo> getGeneralReply(int b_no);
	
	// 일반 댓글 작성
	public int grWrite(GeneralReplyVo vo);
	
	public int replyDelete(int r_no);

	public int replyEdit(RecipeReplyVo vo);
}
