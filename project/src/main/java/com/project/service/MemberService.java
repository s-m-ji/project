package com.project.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

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
	
	// 회원 등록 
	int adminInput(MemberVo membervo, ArrayList<MultipartFile> files) throws Exception;
	
	// 회원 한건 불러오기 
	public MemberVo getMemOne(int mno);
	
	// 회원 수정
	public int memberUpdate(MemberVo membervo, ArrayList<MultipartFile> files) throws Exception;

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
	
	// 리워드 목록
	public List<MemberVo> rewardList(String startDate, String endDate);
	
	// 리워드 수정 
	public int gradeUpdate(MemberVo membervo);


}
