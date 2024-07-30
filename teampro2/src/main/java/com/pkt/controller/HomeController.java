package com.pkt.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pkt.mapper.StockMapper;
import com.pkt.service.IndexNewsService;
import com.pkt.model.IndexNewsVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class HomeController {
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
    
    private final StockMapper smapper;
    private final IndexNewsService service;
    private final HttpSession session;
    
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String home(Locale locale, Model model) {
        logger.info("====================index====================");
        
        // 주식 정보 관련 모델 추가
        model.addAttribute("list", smapper.getStockList());
        model.addAttribute("total", smapper.getAllStockCount());
        
        // 인덱스 뉴스 정보 관련 모델 추가
        List<IndexNewsVO> indexnews = service.listAll();
        model.addAttribute("indexnews", indexnews);
        
        return "index";
    }
}
