package com.pkt.mapper;

import java.util.List;
import java.util.Map;

import com.pkt.model.ReplyVO;

public interface ReplyMapper {
	public List<ReplyVO> list(Integer bno); //목록
	public void create(ReplyVO vo); //추가
	public void update(ReplyVO vo); //수정
	public void delete(Integer rno); //삭제
	
	public List<ReplyVO> listPage(Map<String, Object> m); // Map 전달
	public int count(Integer bno); // 총 게시물 수
}
