package com.pkt.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.pkt.mapper.StockMapper;
import com.pkt.model.Criteria;
import com.pkt.model.IndexNewsVO;
import com.pkt.model.StockVO;
import com.pkt.service.IndexNewsService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class IndexNewsController {
    private final IndexNewsService service;

    @GetMapping("/indexDetail")
    public String detail(@RequestParam("id") int id, Model model) {
        // 뉴스 상세 정보 가져오기
        IndexNewsVO news = service.readOne(id);
        
        if (news != null) {
            // Stock 정보 가져오기
            StockVO stock = service.getStockInfo(news.getStockCode());
            
            // 주식 리스트 가져오기
            List<StockVO> stockList = service.getStockList();
            
            // 모델에 필요한 정보 추가
            model.addAttribute("news", news);     // 뉴스 상세 정보
            model.addAttribute("stock", stock);   // 선택된 종목의 정보
            model.addAttribute("stockList", stockList); // 전체 주식 리스트
            
            log.info("news: " + news);
            log.info("stock: " + stock);
        } else {
            log.warn("News with id " + id + " not found.");
            // 적절한 에러 처리 혹은 리다이렉트를 수행할 수 있음
        }
        
        return "news/indexDetail";
    }
}
