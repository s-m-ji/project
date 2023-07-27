package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.ui.Model;

import com.project.vo.Criteria;
import com.project.vo.MemberVo;

public interface MemberMapper {
	
	// 회원 목록 조회 + 검색 조건 추가
	public List<MemberVo> memberList(Criteria cri);
	
	// 총건수 조회 
	public int getTotalCnt(Criteria cri);

	// 회원 삭제 
	public int delMem(@Param("mno")String mno,@Param("delyn")String delyn);
	
}
