package com.pkt.mapper;

import java.util.List;

import com.pkt.model.BoardVO;
import com.pkt.model.Criteria;

public interface BoardMapper {
	public List<BoardVO> getList();		// 목록
	
	public void create(BoardVO vo);		// 쓰기
	public BoardVO read(Integer bno);	// 상세페이지
	public void update(BoardVO vo);		// 수정
	public void delete(Integer bno);	// 삭제
	
	public List<BoardVO> listPage(int page);	// 목록(페이징)
	public List<BoardVO> listCriteria(Criteria cri);
	
	public int countPaging(Criteria cri);
	public void updateViewCnt(Integer bno);
	
	public List<BoardVO> listSearch(Criteria cri);
	public int listSearchCount(Criteria cri);
	
	List<BoardVO> searchBoards(String keyword);
}
