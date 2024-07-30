package com.pkt.service;

import java.util.List;

import com.pkt.model.Criteria;
import com.pkt.model.NewsVO;
import com.pkt.model.StockVO;

public interface NewsService {
	public List<NewsVO> listAll();
	NewsVO readOne(Integer id);
	
	public List<NewsVO> newsSearchCriteria(Criteria cri);
	public int newsSearchCount(Criteria cri);
	
	String getStockCodeById(Integer id);
	
	StockVO getStockInfo(String code);
    List<StockVO> getStockList();
    
    List<NewsVO> searchNews(String keyword);
}
