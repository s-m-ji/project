package com.project.recipe;

import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.project.mapper.RecMatMapper2;
import com.project.mapper.RecStepMapper2;
import com.project.mapper.RecipeListMapper;
import com.project.mapper.RecipeMapper;
import com.project.mapper.ReplyMapper;
import com.project.service.ReplyService;
import com.project.vo.BoardVO;
import com.project.vo.Criteria;
import com.project.vo.RecMatVO2;
import com.project.vo.RecipeBoardVo;
import com.project.vo.RecipeReplyVo;

import lombok.extern.log4j.Log4j;
import lombok.extern.log4j.Log4j2;

//스프링 실행
@RunWith(SpringJUnit4ClassRunner.class)
//설정파일 경로안내
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class recipeTest {
	@Autowired
	RecipeListMapper rMapper;
	
	@Autowired
	RecipeMapper vMapper;
	
	@Autowired
	ReplyMapper replyMapper;
	
	@Autowired
	ReplyService replySerive;
	
	@Autowired
	RecMatMapper2 mats;
	
	@Autowired
	RecStepMapper2 sM;
	
	
	@Test
	public void mi() {
		int res = sM.minusSno(105);
		
		log.info(res);
	}
	
	@Test public void getRecList() {
		// assertNotNull(rMapper);
		Criteria cri = new Criteria();
		cri.setC1("1");
		List<BoardVO> list = rMapper.getRecList(cri);
		log.info("*********** list : " + list);
		
	}
	
	@Test public void getListTotalCnt() {
		Criteria cri = new Criteria();
		cri.setC1("1"); 
		int res = rMapper.getListTotalCnt(cri);
		log.info("*********** res : " + res);
		
	}
	
	
	
	/**
	 * 이한규 테스트 getOne
	 */
	@Test
	public void getOne() {
		
		assertNotNull(vMapper);
		
		RecipeBoardVo vo = vMapper.getOne(2);
		
		log.info(vo);
	}
	
	
	@Test
	public void getOneOrgin() {
		
		assertNotNull(rMapper);
		BoardVO vo =  rMapper.getOne(2);
	
		log.info(vo);
	}
	
	@Test
	public void dupli() {
		
		int res = replyMapper.selectPhotoReview(2, "나는작성자");
		
		assertNotEquals(res, 1);
		
		log.info(res);
	}
	
	
	@Test
	public void dupl() {
		
		int res = replySerive.getRno(3, "관리자");
		
		assertNotNull(replySerive.getRno(3, "관리자"));
		
		log.info(res);
	}
	
	@Test
	public void getLikeRecipe() {
		
		assertNotNull(vMapper.getLikeRecipeList(1));
		List<RecipeBoardVo> list = vMapper.getLikeRecipeList(1);
		
		log.info(list);
		
	}
	
	@Test
	public void Mylist() {
		
		assertNotNull(vMapper.myRecipe(1));
		List<RecipeBoardVo> list = vMapper.myRecipe(1);
		
		log.info(list);
		
	}
	
	
	@Test
	public void MyReview() {
		
		assertNotNull(vMapper.getMyReply("침착맨"));
		List<RecipeReplyVo> list = vMapper.getMyReply("침착맨");
		
		log.info(list);
		
	}
	
	@Test
	public void My() {
		
		Criteria cri = new Criteria();
		List<RecipeReplyVo> list = vMapper.getReceiveReply(1, cri);
		
		log.info(list);
	}
	
	@Test
	public void testtt() {
		
		
		
		RecMatVO2 vo = new RecMatVO2();
		vo.setMaterialCnt("30");
		vo.setI_NAME("계란");
		
		
		log.info(mats.insert(vo));
		
	}
	
	
	
}


