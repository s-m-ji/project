package com.project.member;

import static org.junit.Assert.assertEquals;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.project.mapper.MemberMapper;
import com.project.vo.Criteria;
import com.project.vo.MemberVo;
import com.project.vo.NoticeVo;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class memberTest {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Test
	public void memberList() {
		List<MemberVo> list = memberMapper.memberList(null);
		
		list.forEach(member ->{
			log.info("memberVo ==== ");
			log.info(member.getMno());
			log.info(member.getEmail());
			log.info(member.getNickname());
			log.info(member.getPnum());
			log.info(member.getReg_dateStr());
			log.info(member.getDelYNStr());
		});
	}
	// 회원 삭제 
	@Test
	public void delMember() {
		int res = memberMapper.delMem("17", "Y");
		System.out.println("탈퇴 신청 Y : 삭제 ");
		log.info("결과 : "+ res);
		
	}
	@Test
	public void getTotalCnt() {
		//int res = memberMapper.getTotalCnt();
		//log.info(res);
	}
	@Test
	public void noticeList() {
		List<NoticeVo> list =  memberMapper.noticeList(null);
		list.forEach(notice ->{
			log.info(notice.getNno());
			log.info(notice.getNtitle());
			log.info(notice.getNcontent());
			log.info(notice.getNcount());
			log.info(notice.getGubun());
			
			log.info(list);
		});
	}
	@Test
	public void noticeWrite() {
		NoticeVo noticevo = new NoticeVo();
		noticevo.setNtitle("7월 혜택");
		noticevo.setNcontent("여름맞이 기념으로 이벤트를 진행합니다.");
		noticevo.setGubun("이벤트");
		noticevo.setNwriter("admin");
		
		int res = memberMapper.noticeWrite(noticevo);
		assertEquals(res, 1);
		
		log.info(noticevo);
	}
	@Test
	public void noticeOne() {
		NoticeVo noticevo = memberMapper.noticeOne(57);
		log.info(noticevo);
	}
	
	@Test
	public void noticeDel() {
		int res = memberMapper.noticeDel(57);
		log.info(res);
	}
	@Test
	public void noticeUpdate() {

		NoticeVo noticevo = memberMapper.noticeOne(56);
		noticevo.setNtitle(" 테스트 제목 " );
		noticevo.setNcontent(" 테스트 내용 " );
		noticevo.setGubun("일반");
		
		int res = memberMapper.noticeUpdate(noticevo);
		log.info(res);
	}

}
