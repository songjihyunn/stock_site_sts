package com.pkt.controller;

import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.pkt.model.Criteria;
import com.pkt.model.NewsVO;
import com.pkt.model.PageMaker;
import com.pkt.model.StockVO;
import com.pkt.service.NewsService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class NewsController {

    private final NewsService newsService;
    private final HttpSession session;

    @GetMapping("/news")
    public String listPage(Criteria cri, Model model) {

        // 전체 뉴스 리스트 조회
        List<NewsVO> newsList = newsService.listAll();

        // 검색 조건이 있을 경우 필터링
        if (cri.getKeyword() != null && !cri.getKeyword().isEmpty()) {
            newsList = newsList.stream()
                    .filter(news -> news.getTitle().contains(cri.getKeyword()) || news.getContent().contains(cri.getKeyword()))
                    .collect(Collectors.toList());
        }

        // 페이징 관련 정보 설정
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(cri);
        pageMaker.setTotalCount(newsList.size()); // 전체 게시물 수는 필터링 후 리스트의 크기로 설정

        // 현재 페이지에 해당하는 뉴스 리스트 추출
        int start = cri.getPageStart();
        int end = Math.min(start + cri.getPerPageNum(), newsList.size());
        List<NewsVO> currentPageList = newsList.subList(start, end);

        // 모델에 데이터 추가
        model.addAttribute("list", currentPageList);
        model.addAttribute("pageMaker", pageMaker);

        return "news/news"; // 반환되는 문자열은 "news/news.jsp"를 의미
    }
    @GetMapping("/newsDetail")
    public String detail(@RequestParam("id") int id, @ModelAttribute("cri") Criteria cri, Model model) {
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(cri);
        
        model.addAttribute("id", id);
        System.out.println("id: " + id);
        
        model.addAttribute("pageMaker", pageMaker);
        System.out.println("pageMaker:" + pageMaker);

        // 뉴스 상세 정보 가져오기
        NewsVO news = newsService.readOne(id);
        if (news != null) {
            // Stock 정보 가져오기
            StockVO stock = newsService.getStockInfo(news.getStockCode());
            
            // 주식 리스트 가져오기
            List<StockVO> stockList = newsService.getStockList();
            
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

        return "news/newsDetail"; // 뉴스 상세 페이지의 view 이름 (예: newsDetail.jsp)
    }
    
}
