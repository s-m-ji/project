package com.project.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.project.vo.ComReplyVO;

@Service
public interface ComReplyService {
	// 댓글 목록
	public List<ComReplyVO> getList(int bno);
	// 댓글 입력
	public int insert(ComReplyVO vo);
	// 댓글 삭제
	public int delete(int R_NO);
	// 댓글 수정
	public int update(ComReplyVO vo);
	
	
	
	public List<ComReplyVO> getMyReplies(@Param("com_bno") int com_bno);
	
	
	public ComReplyVO getone(int R_NO); 
	
	public int getTotalCnt();
	
	public int getCom_bnoCnt(int R_NO);

}
