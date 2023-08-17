package com.project.service;

import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.project.vo.MainVO;

@Service
public interface MainService {
	
	//1. 최다 추천 레시피 리스트 불러오기
	public List<MainVO> getBoomUpList();
	
	//2. 최다 조회 레시피 리스트 불러오기
	public List<MainVO> getViewCntList();
	
	//3. 최다 댓글 레시피 리스트 불러오기
	public List<MainVO> getReplyCntList();
	
	//4. 최근 등록 레시피 리스트 불러오기
	public List<MainVO> getRecentList();
	
	//5. 
	public String getenglish(MainVO vo);

	//public List<MainVO> getBoomUpListIMG();

	//6. 

}
