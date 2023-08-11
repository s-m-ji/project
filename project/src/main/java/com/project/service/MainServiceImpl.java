package com.project.service;

import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.project.mapper.MainMapper;
import com.project.vo.MainVO;

@Service
//@Cacheable(value="getRecipe", key="#menumap")
public class MainServiceImpl implements MainService{

	@Autowired
	MainMapper mainMapper;
	
	//1. 최다 추천 레시피 리스트 불러오기
	@Override
	public List<MainVO> getBoomUpList() {
		// TODO Auto-generated method stub
		return mainMapper.getBoomUpList();
	}
	
	//2. 최다 조회 레시피 리스트 불러오기
	@Override
	public List<MainVO> getViewCntList() {
		// TODO Auto-generated method stub
		return mainMapper.getViewCntList();
	}
	
	//3. 최다 댓글 레시피 리스트 불러오기
	@Override
	public List<MainVO> getReplyCntList() {
		// TODO Auto-generated method stub
		return mainMapper.getReplyCntList();
	}
	
	//4. 최근 등록 레시피 리스트 불러오기
	@Override
	public List<MainVO> getRecentList() {
		// TODO Auto-generated method stub
		return mainMapper.getRecentList();
	}

	
}
