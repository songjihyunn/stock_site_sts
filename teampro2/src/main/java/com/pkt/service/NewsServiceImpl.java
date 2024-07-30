package com.pkt.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pkt.mapper.NewsMapper;
import com.pkt.mapper.StockMapper;
import com.pkt.model.Criteria;
import com.pkt.model.NewsVO;
import com.pkt.model.StockVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service //스프링 빈으로 인식되기 위해 선언
@AllArgsConstructor
public class NewsServiceImpl implements NewsService {
	private NewsMapper mapper;
	private final StockMapper smapper;
	
	@Override
	public List<NewsVO> listAll(){
		return mapper.getList();
	}
	
	@Override
    public NewsVO readOne(Integer id) {
		mapper.updateViewCnt(id);
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
	public List<NewsVO> newsSearchCriteria(Criteria cri){
		return mapper.newsSearch(cri);
	}
	
	@Override
	public int newsSearchCount(Criteria cri) {
		return mapper.newsSearchCount(cri);
	}
	
	@Override
    public List<NewsVO> searchNews(String keyword) {
        return mapper.searchNews(keyword);
    }
}
