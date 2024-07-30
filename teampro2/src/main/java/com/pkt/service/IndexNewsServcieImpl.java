package com.pkt.service;
import java.util.List;

import org.springframework.stereotype.Service;

import com.pkt.mapper.IndexNewsMapper;
import com.pkt.mapper.StockMapper;
import com.pkt.model.IndexNewsVO;
import com.pkt.model.NewsVO;
import com.pkt.model.StockVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class IndexNewsServcieImpl implements IndexNewsService {
    private final IndexNewsMapper mapper;
    private final StockMapper smapper;

    @Override
    public List<IndexNewsVO> listAll() {
        return mapper.getList();
    }

    @Override
    public IndexNewsVO readOne(Integer id) {
        return mapper.getDetail(id);
    }

    @Override
    public String getStockCodeById(Integer id) {
        return mapper.getStockCodeById(id);
    }

    @Override
    public StockVO getStockInfo(String code) {
        return smapper.getStockInfo(code);
    }

    @Override
    public List<StockVO> getStockList() {
        return smapper.getStockList();
    }
    
    @Override
    public List<IndexNewsVO> searchIndexNews(String keyword) {
        return mapper.searchIndexNews(keyword);
    }
}