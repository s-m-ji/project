package com.project.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.project.vo.Criteria;
import com.project.vo.IngredientsVo;
import com.project.vo.LikeVo;
import com.project.vo.MaterialVo;
import com.project.vo.RecipeBoardVo;
import com.project.vo.RecipeReplyVo;
import com.project.vo.RecipeStepVo;

@Service
public interface RecipeService {

	public RecipeBoardVo getOne(int b_no);
	
	public List<MaterialVo> getMaterial(int b_no);
	
	public List<RecipeStepVo> getRecipeStep(int b_no);
	
	public List<RecipeReplyVo> getRecipeReply(int b_no);
	
	public int replyTotalCnt(int b_no);

	public IngredientsVo getIngredients(String i_name);
	
	public int like_Recipe(LikeVo likevo);

	public int photoTotalCnt(int b_no);
	
	public int plusViewcnt(int b_no);
	
	public List<RecipeBoardVo> getLikeRecipeList(int m_no);
	
	public List<RecipeBoardVo> myRecipe(int m_no);
	
	public List<RecipeReplyVo> getMyReply(String writer);
	
	public List<RecipeReplyVo> getReceiveReply(@Param("mno") int mno, @Param("cri") Criteria cri);

	public int getTotalRecieveReply(int m_no);
}
