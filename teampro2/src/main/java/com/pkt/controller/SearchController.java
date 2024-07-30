package com.pkt.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.pkt.model.BoardVO;
import com.pkt.model.Criteria;
import com.pkt.model.IndexNewsVO;
import com.pkt.model.NewsVO;
import com.pkt.model.PageMaker;
import com.pkt.service.BoardService;
import com.pkt.service.IndexNewsService;
import com.pkt.service.NewsService;

@Controller
public class SearchController {

    @Autowired
    private BoardService boardService;

    @Autowired
    private NewsService newsService;
    
    @Autowired
    private IndexNewsService indexService;

    @GetMapping("/search")
    public String search(@RequestParam("keyword") String keyword, Model model, @ModelAttribute("cri") Criteria cri ) {
        // 게시판 검색 결과
        List<BoardVO> boardResults = boardService.searchBoards(keyword);
        model.addAttribute("boardResults", boardResults);
        
        System.out.println("boardResults: " + boardResults);
        
     // 페이징 정보 설정
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(cri); // Criteria 설정
        model.addAttribute("pageMaker", pageMaker);
        
        System.out.println("pageMaker: "+ pageMaker);
        
        // 뉴스 검색 결과
        List<NewsVO> newsResults = newsService.searchNews(keyword); // news 테이블에서 검색
        model.addAttribute("newsResults", newsResults);
        
        List<IndexNewsVO> indexNewsResults = indexService.searchIndexNews(keyword); // indexnews 테이블에서 검색
        model.addAttribute("indexNewsResults", indexNewsResults);
        
        // newsResults와 indexNewsResults를 합친 리스트 생성
        List<Object> combinedResults = new ArrayList<>();
        combinedResults.addAll(newsResults);
        combinedResults.addAll(indexNewsResults);

        model.addAttribute("combinedResults", combinedResults);

        model.addAttribute("keyword", keyword); // 검색어도 모델에 추가
        System.out.println("keyword:" + keyword);

        return "search";
    }
}
