package com.project.vo;

import lombok.Data;

/**
 * 요리 재료들의 정보를 담고 있는 Vo
 * @author 이한규
 *
 */
@Data
public class IngredientsVo {

	private int i_no;
	private String i_name;
	private String i_cook;
	private String i_power;
	private String i_friendfood;
	private String i_repair;
	
}
