package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.RecipeMapper;
import com.project.vo.IngredientsVo;
import com.project.vo.LikeVo;
import com.project.vo.MaterialVo;
import com.project.vo.RecipeBoardVo;
import com.project.vo.RecipeReplyVo;
import com.project.vo.RecipeStepVo;

@Service
public class RecipeServiceImpl implements RecipeService{

		
	@Autowired 
	RecipeMapper mapper;

	@Override
	public RecipeBoardVo getOne(int b_no) {
		// TODO Auto-generated method stub
		return mapper.getOne(b_no);
	}

	@Override
	public List<MaterialVo> getMaterial(int b_no) {
		// TODO Auto-generated method stub
		return mapper.getMaterial(b_no);
	}

	@Override
	public List<RecipeStepVo> getRecipeStep(int b_no) {
		// TODO Auto-generated method stub
		return mapper.getRecipeStep(b_no);
	}

	@Override
	public List<RecipeReplyVo> getRecipeReply(int b_no) {
		// TODO Auto-generated method stub
		return mapper.getRecipeReply(b_no);
	}

	@Override
	public int replyTotalCnt(int b_no) {
		// TODO Auto-generated method stub
		return mapper.replyTotalCnt(b_no);
	}

	@Override
	public IngredientsVo getIngredients(String i_name) {
		// TODO Auto-generated method stub
		return mapper.getIngredients(i_name);
	}

	@Override
	public int like_Recipe(LikeVo likevo) {
		// TODO Auto-generated method stub
		return mapper.like_Recipe(likevo);
	}

	@Override
	public int photoTotalCnt(int b_no) {
		// TODO Auto-generated method stub
		return mapper.photoTotalCnt(b_no);
	}

	@Override
	public int plusViewcnt(int b_no) {
		// TODO Auto-generated method stub
		return mapper.plusViewcnt(b_no);
	}

	@Override
	public List<RecipeBoardVo> getLikeRecipeList(int m_no) {
		// TODO Auto-generated method stub
		return mapper.getLikeRecipeList(m_no);
	}

	@Override
	public List<RecipeBoardVo> myRecipe(int m_no) {
		// TODO Auto-generated method stub
		return mapper.myRecipe(m_no);
	}

	@Override
	public List<RecipeReplyVo> getMyReply(String writer) {
		// TODO Auto-generated method stub
		return mapper.getMyReply(writer);
	}

	
}
