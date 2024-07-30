package com.pkt.service;

import java.util.List;

import com.pkt.model.IndexNewsVO;
import com.pkt.model.NewsVO;
import com.pkt.model.StockVO;

public interface IndexNewsService {
	List<IndexNewsVO> listAll();
    IndexNewsVO readOne(Integer id);
    
    String getStockCodeById(Integer id);
    StockVO getStockInfo(String code);
    List<StockVO> getStockList();
    
    List<IndexNewsVO> searchIndexNews(String keyword);
}
