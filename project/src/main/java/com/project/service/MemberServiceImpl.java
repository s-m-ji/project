package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.project.mapper.MemberMapper;
import com.project.vo.Criteria;
import com.project.vo.MemberVo;
import com.project.vo.NoticeVo;
import com.project.vo.PageDto;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberMapper membermapper;
	
	 // 회원 목록 조회 (검색조건 + 페이징)
	@Override
	public List<MemberVo> memberList(Criteria cri, Model model) {
		List<MemberVo> list = membermapper.memberList(cri);
		int totalCnt = membermapper.getTotalCnt(cri);
		PageDto pageDto = new PageDto(cri, totalCnt);
		
		model.addAttribute("list", list);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageDto", pageDto);
		
		return null;
	}
	
	// 회원 총 건수 조회
	@Override
	public int getTotalCnt(Criteria cri) {
		return membermapper.getTotalCnt(cri);
	}
	
	// 탈퇴 회원 선택 삭제
	@Override
	public int delMem(String mno, String delyn) {
		return membermapper.delMem(mno, delyn);
	}

	// 회원 등록
	@Override
	public int adminInput(MemberVo membervo) {
		int res = membermapper.adminInput(membervo);
		return res;
	}

	
	// 공지 목록 조회
	@Override
	public List<NoticeVo> noticeList(Criteria cri,Model model) {
		List<NoticeVo> notList = membermapper.noticeList(cri);
		int totalNcnt = membermapper.getTotalNcnt(cri);
		PageDto pageDtoN = new PageDto(cri, totalNcnt);
		
		model.addAttribute("notList", notList);
		model.addAttribute("totalNcnt", totalNcnt);
		model.addAttribute("pageDtoN", pageDtoN);
		
		return null;
	}
	// 공지 글 등록
	@Override
	public int noticeWrite(NoticeVo noticevo) {
		int res = membermapper.noticeWrite(noticevo);
		return res;
	}

	// 공지 총 건수 
	@Override
	public int getTotalNcnt(Criteria cri) {
		return membermapper.getTotalNcnt(cri);
	}
	
	// 공지 한 건
	@Override
	public NoticeVo noticeOne(int nno) {
		return membermapper.noticeOne(nno);
	}
	// 공지 삭제 
	@Override
	public int noticeDel(int nno) {
		return membermapper.noticeDel(nno);
	}
	
	// 공지 수정 
	@Override
	public int noticeUpdate(NoticeVo noticevo) {
		int res = membermapper.noticeUpdate(noticevo);
		return res;
	}

	@Override
	public List<MemberVo> rewardList(Model model) {
		List<MemberVo> rewardList = membermapper.rewardList();
		model.addAttribute("rewardList", rewardList);
		return null;
	}


}
