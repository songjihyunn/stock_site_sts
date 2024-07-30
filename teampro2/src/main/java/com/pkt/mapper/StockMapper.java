package com.pkt.mapper;

import java.util.List;
import java.util.Map;

import com.pkt.model.PortVO;
import com.pkt.model.StockVO;

public interface StockMapper {
	public List<StockVO> getStockList();
	public int getAllStockCount();
	
	public StockVO getStockInfo(String code);
	
	public int getHavePortPolio(Map<String,Object> map);
	public void addToPortfolio(PortVO request);
}
