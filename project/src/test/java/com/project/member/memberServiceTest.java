package com.project.member;

import static org.junit.Assert.assertEquals;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.ui.Model;

import com.project.service.MemberService;
import com.project.vo.MemberVo;
import com.project.vo.NoticeVo;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class memberServiceTest {
	
	@Autowired
	MemberService memberservice;
	
//	@Test
/*	public void memList() {
		List<MemberVo> list = memberservice.memberList(null);
		
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
*/
	/*
	 * @Test public void noticeList() { List<NoticeVo> notice =
	 * memberservice.noticeList(); notice.forEach(list ->{ log.info(list.getNno());
	 * 
	 * }); }
	 */
}
