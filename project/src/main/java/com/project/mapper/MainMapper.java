package com.project.mapper;

import java.util.List;

import org.json.simple.JSONObject;

import com.project.vo.MainVO;

public interface MainMapper {
	
	//1. 최다 추천 레시피 리스트 불러오기
	List<MainVO> getBoomUpList();
	
	//2. 최다 조회 레시피 리스트 불러오기
	List<MainVO> getViewCntList();
	
	//3. 최다 댓글 레시피 리스트 불러오기
	List<MainVO> getReplyCntList();

	//4. 최근 등록 레시피 리스트 불러오기
	List<MainVO> getRecentList();

}
