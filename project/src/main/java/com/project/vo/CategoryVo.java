package com.project.vo;

import lombok.Data;

@Data
public class CategoryVo {

	private int C_NO	      ; // 카테고리 번호 (고유번호)
	private String cateTier	      ; // 카테고리 분류(1:대분류, 2:중분류, 3:소분류)
	private String cateName	  ; // 카테고리명 (종류, 재료 등등)
	private String cateParent ; // 상위 카테고리명

}
