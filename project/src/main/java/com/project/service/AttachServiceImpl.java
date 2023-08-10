package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.AttachMapper;
import com.project.vo.AttachVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AttachServiceImpl implements AttachService {

	@Autowired
	AttachMapper aMapper;

	@Override
	public List<AttachVO> getAllList() {
		System.out.println("[AttachServiceImpl] getAllList 실행 ");
		return aMapper.getAllList();
	}

	
	@Override
	public List<AttachVO> getAllComList() {
		System.out.println("[AttachServiceImpl] getAllComList 실행 ");
		return aMapper.getAllComList();
	}
		
}
