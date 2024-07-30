package com.pkt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pkt.model.Criteria;
import com.pkt.model.NewsVO;

public interface NewsMapper {
	public List<NewsVO> getStockNews(String stockcode);
	public List<NewsVO> getList();
	NewsVO getDetail(@Param("id") Integer id);
	public void updateViewCnt(Integer id);
	public int stockNewsCount(String stockcode);
	
	String getStockCodeById(@Param("id") Integer id);
	
	public List<NewsVO> newsSearch(Criteria cri);
	public int newsSearchCount(Criteria cri);
	
	List<NewsVO> searchNews(String keyword);
}
