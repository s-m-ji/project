package com.project.mapper;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.ui.Model;

import com.project.vo.Criteria;
import com.project.vo.MemberVo;
import com.project.vo.NoticeVo;

public interface MemberMapper {
	
	// 회원 목록 조회 + 검색 조건 추가
	public List<MemberVo> memberList(Criteria cri);
	
	// 총건수 조회 
	public int getTotalCnt(Criteria cri);

	// 회원 삭제 
	public int delMem(@Param("mno")String mno,@Param("delyn")String delyn);
	
	// 회원 등록 
	public int adminInput(MemberVo membervo);
	
	// 회원 한건 불러오기 
	public MemberVo getMemOne(int mno);

	// 회원 수정
	public int memberUpdate(MemberVo membervo);

	// 공지 목록 조회 
	public List<NoticeVo> noticeList(Criteria cri);
	
	// 공지 등록 
	public int noticeWrite(NoticeVo noticevo);
	
	// 공지 총 건수 
	public int getTotalNcnt(Criteria cri);
	
	// 공지 한건 불러오기 
	public NoticeVo noticeOne(int nno);
	
	// 공지 삭제 
	public int noticeDel(int nno);
	
	// 공지 수정 
	public int noticeUpdate(NoticeVo noticevo);

	// 리워드 조회 
	public List<MemberVo> rewardList(@Param("startDate") String startDate, @Param("endDate") String endDate);

	// 리워드 수정 
	public int gradeUpdate(MemberVo membervo);


}
