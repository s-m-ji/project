package com.project.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

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
	
	@Autowired
	AdminFileService adminfileservice;
	
	 // 회원 목록 조회 (검색조건 + 페이징)
	@Override
	public List<MemberVo> memberList(Criteria cri, Model model) {
			/* 페이지 게시물 개수 처리 */
		cri.setAmount(5);
		cri.setPageNo(cri.getPageNo());
		
		List<MemberVo> list = membermapper.memberList(cri);
		int totalCnt = membermapper.getTotalCnt(cri);
		PageDto pageDtoA = new PageDto(cri, totalCnt);
		
		model.addAttribute("list", list);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageDtoA", pageDtoA);
		
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

	// 회원 등록 + 파일 등록 
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int adminInput(MemberVo membervo, ArrayList<MultipartFile> files) throws Exception {
		int res = membermapper.adminInput(membervo);
		
		adminfileservice.fileupload(files, membervo.getMno());
		
		return res;
	}
	
	// 회원 한 건 불러오기 
	@Override
	public MemberVo getMemOne(int mno) {
		return membermapper.getMemOne(mno);
	}
	
	// 회원 수정하기 + 파일 수정 
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int memberUpdate(MemberVo membervo, ArrayList<MultipartFile> files) throws Exception {
		int res = membermapper.memberUpdate(membervo);
		adminfileservice.fileupload(files, membervo.getMno());
		return res;
	}

	
	// 공지 목록 조회
	@Override
	public List<NoticeVo> noticeList(Criteria cri,Model model) {
		/* 페이지 게시물 개수 처리 */
		cri.setAmount(6);
		cri.setPageNo(cri.getPageNo());
		
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
	
	// 리워드 조회 
	@Override
	public List<MemberVo> rewardList(String startDate, String endDate) {
		return membermapper.rewardList(startDate, endDate);
	}

	// 리워드 수정 
	@Override
	public int gradeUpdate(MemberVo membervo) {
		return membermapper.gradeUpdate(membervo);
	}

	@Override
	public List<MemberVo> rewardListReal(Model model) {
		List<MemberVo> rewardListReal = membermapper.rewardListReal();
		model.addAttribute("rewardListReal", rewardListReal);
		return null;
	}

	// 마이페이지 회원 탈퇴 
	@Override
	public int myPageDel(int mno) {
		int res = membermapper.myPageDel(mno);
		return res;
	}

	


	
	
	// 광민
	@Autowired
	BCryptPasswordEncoder encoder;
	
	@Autowired
	MailService mailservice;
	
	@Override
	public MemberVo login(MemberVo paramMember) {
		MemberVo member = membermapper.login(paramMember);
		if(member != null) {
			// 사용자가 입력한 비밀번호가 일치하는지 확인
			// 사용자가 입력한 비밀번호, 데이터베이스에 암호화되어 저장된 비밀번호
			boolean res = 
					encoder.matches(paramMember.getPw()
									, member.getPw());
			 List<String> role = membermapper.getMemberRole(member.getEmail());
			// 비밀번호 인증이 성공하면 member객체를 반환
			if(res) {
				member.setRole(role);
			return member;
			}else {
				
				return null;
			}
		}
		return membermapper.login(member);
	}
	
	@Override
	public int insert(MemberVo member) {
		
		BCryptPasswordEncoder encoder 
						= new BCryptPasswordEncoder();
		
		// 비밀번호 암호화
		member.setPw(encoder.encode(member.getPw()));
		System.out.println("pw : " + member.getPw());
		return membermapper.insert(member);
	}

	@Override
	public int emailCheck(MemberVo member) {
		return membermapper.emailCheck(member);
	}
	
	@Override
	public int nicknameCheck(MemberVo member) {
		return membermapper.nicknameCheck(member);
	}
	
	@Override
	public String findEmailBy(MemberVo member) {
		return membermapper.findEmailBy(member);
	}
	
	@Override
	public String sendPwBy(MemberVo member, Model model) {
		String pw = membermapper.sendPwBy(member);
		System.out.println("pw : " + pw);
		if (pw != null) {
			// 임시 비밀번호 생성
			String temporaryPassword = PasswordGenerator.generateRandomPassword();

	        // 사용자 비밀번호 업데이트 (생성한 임시 비밀번호로 업데이트)
	        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	        String encodedTemporaryPassword = passwordEncoder.encode(temporaryPassword);
	        membermapper.updatePassword(member.getEmail(), encodedTemporaryPassword);

			// 이메일 전송
	        member.setPw(temporaryPassword);
    		mailservice.findMailSend(member);
    		System.out.println(pw);
    		model.addAttribute("msg", "해당 이메일로 임시비밀번호가 발송되었습니다.");
    		return "recipe/send-pw-form";
    		
    	} else {
    		model.addAttribute("error", "해당 아이디와 이름으로 등록된 정보가 없습니다.");
    		return "recipe/send-pw-form";
    	}
	}

	@Override
	public boolean emailExists(String email) {
		return membermapper.emailExists(email);
	}



}
