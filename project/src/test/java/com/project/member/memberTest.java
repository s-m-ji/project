package com.project.member;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.project.mapper.MemberMapper;
import com.project.vo.MemberVo;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class memberTest {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Test
	public void memberList() {
		List<MemberVo> list = memberMapper.memberList();
		
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
}
