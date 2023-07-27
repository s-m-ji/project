package com.project.mapper;

import java.util.List;

import com.project.vo.BoardVO;
import com.project.vo.Criteria;

public interface RecipeMapper {

	List<BoardVO> getList(Criteria cri);

}
