package com.pkt.mapper;

import java.util.List;
import java.util.Map;

import com.pkt.model.AdminCriteria;
import com.pkt.model.BoardVO;

public interface AdminBoardMapper {
	public List<BoardVO> getBoardList(AdminCriteria acri);
	public int boardCount();
	public BoardVO getOneBoard(int bno);
	public void update(Map<String,Object> map);

	public List<BoardVO> listPage(int page);				//페이징
	public List<BoardVO> listCriteria(AdminCriteria acri);	//페이징
	public int listCountCriteria(AdminCriteria acri);
	public List<BoardVO> listSearch(AdminCriteria acri);
	public int listSearchCount(AdminCriteria acri);
	public int countPaging(AdminCriteria acri);
}
