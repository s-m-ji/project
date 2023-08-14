package com.project.mapper;

import java.util.List;

import com.project.vo.IngredientsVo;
import com.project.vo.LikeVo;
import com.project.vo.MaterialVo;
import com.project.vo.RecipeBoardVo;
import com.project.vo.RecipeReplyVo;
import com.project.vo.RecipeStepVo;

public interface RecipeMapper {

	// 레시피 리스트
	public RecipeBoardVo getOne(int b_no);
	
	// 필요 재료 정보
	public List<MaterialVo> getMaterial(int b_no);
	
	// 순수 재료 정보 
	public IngredientsVo getIngredients(String i_name);
	
	public List<RecipeStepVo> getRecipeStep(int b_no);
	
	public List<RecipeReplyVo> getRecipeReply(int b_no);
	
	public int replyTotalCnt(int b_no);
	
	public int like_Recipe(LikeVo likevo);

	public int photoTotalCnt(int b_no);
	
	public int plusViewcnt(int b_no);
	
	// 내가 작성한 레시피 목록
	public List<RecipeBoardVo> myRecipe(int m_no); 
	
	// 찜한 레시피 목록
	public List<RecipeBoardVo> getLikeRecipeList(int m_no);
	
	public List<RecipeReplyVo> getMyReply(String writer);
	
}
