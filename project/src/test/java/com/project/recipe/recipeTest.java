package com.project.recipe;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.project.mapper.RecipeMapper;
import com.project.vo.BoardVO;

import lombok.extern.log4j.Log4j;

//스프링 실행
@RunWith(SpringJUnit4ClassRunner.class)
//설정파일 경로안내
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class recipeTest {
	@Autowired
	RecipeMapper rMapper;
	/*
	 * @Test public void getRecList() { assertNotNull(rMapper); List<BoardVO> list =
	 * rMapper.getRecList(); System.out.println("list : " + list);
	 * list.forEach(board -> { System.out.println(
	 * "**********************************************************");
	 * log.info("********* getBno : " + board.getB_NO());
	 * log.info("********* getTitle : " + board.getTitle()); }); }
	 */
	
	
	
}


