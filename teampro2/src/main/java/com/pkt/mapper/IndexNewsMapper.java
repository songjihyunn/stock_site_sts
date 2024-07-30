package com.pkt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pkt.model.IndexNewsVO;

public interface IndexNewsMapper {
	public List<IndexNewsVO> getList();
	IndexNewsVO getDetail(@Param("id") Integer id);
	
	String getStockCodeById(@Param("id") Integer id);
	List<IndexNewsVO> searchIndexNews(String keyword);
}
