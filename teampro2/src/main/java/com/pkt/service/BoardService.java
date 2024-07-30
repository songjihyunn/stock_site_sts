package com.pkt.service;

import java.util.List;

import com.pkt.model.BoardVO;
import com.pkt.model.Criteria;

public interface BoardService {
	public void regist(BoardVO board);	//등록
	public BoardVO readOne(Integer bno);//읽기
	public void modify(BoardVO board);	//수정
	public void remove(Integer bno);	//삭제
	public List<BoardVO> listAll();		//목록
	
	//페이징
	public List<BoardVO> listCriteria(Criteria cri);
	public int listCountCriteria(Criteria cri);
	
	//검색
	public List<BoardVO> listSearchCriteria(Criteria cri);
	public int listSearchCount(Criteria cri);
	
	List<BoardVO> searchBoards(String keyword);
}
