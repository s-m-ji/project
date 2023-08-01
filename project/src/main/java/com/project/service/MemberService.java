package com.project.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.project.vo.Criteria;
import com.project.vo.MemberVo;
import com.project.vo.NoticeVo;

@Service
public interface MemberService {
	// 회원 목록 조회
	public List<MemberVo> memberList(Criteria cri ,Model model);

	// 총건수 조회 
	public int getTotalCnt(Criteria cri);
	
	// 회원 선택 삭제
	public int delMem(@Param("mno")String mno,@Param("delyn")String delyn);
	
	// 공지 목록 조회 
	public List<NoticeVo> noticeList(Criteria cri,Model model);
	
	// 공지 등록
	public int noticeWrite(NoticeVo noticevo); 
	
	// 공지 총건수 조회 
	public int getTotalNcnt(Criteria cri); 
	
	// 공지 한건 불러오기 
	public NoticeVo noticeOne(int nno);
		
	// 공지 삭제 
	public int noticeDel(int nno);
		
	// 공지 수정 
	public int noticeUpdate(NoticeVo noticevo);
}
