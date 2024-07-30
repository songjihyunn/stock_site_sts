package com.pkt.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pkt.mapper.NewsMapper;
import com.pkt.mapper.StockMapper;
import com.pkt.model.PortVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/stock/")
@AllArgsConstructor
public class StockController {
	private StockMapper smapper;
	private NewsMapper nmapper;
	
	@GetMapping("stockview")
	public String viewPage(Model model, @RequestParam("id") String stock_id, @RequestParam("stockcode") String code, HttpSession session) {
		log.info("===================stock view====================");
		
		model.addAttribute("stock", smapper.getStockInfo(stock_id));
		model.addAttribute("news", nmapper.getStockNews(code));
		
		String sessionId = (String) session.getAttribute("id");
		model.addAttribute("sessionID", sessionId);
		
		Map<String,Object> map = new HashMap<>();
		map.put("userid", sessionId);
		map.put("stock_id", stock_id);
		
	    int portCount = smapper.getHavePortPolio(map);
	    model.addAttribute("portCount", portCount);
		
		int newsCount = nmapper.stockNewsCount(code);
		model.addAttribute("newsCount",newsCount);
		
		return "/stock/stockview";
	}

    @PostMapping("stockview/addToPortfolio")
    public ResponseEntity<Map<String, Object>> addToPortfolio(@RequestBody PortVO request) {
        Map<String, Object> response = new HashMap<>();
        System.out.println(request);
        try {
            smapper.addToPortfolio(request);
            response.put("success", true);
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
        }
        return ResponseEntity.ok(response);
    }
}
