package com.pkt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pkt.mapper.StockMapper;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class FinancialController {
	
	@RequestMapping("/financial")
    public String iframePage(Model model) {
        model.addAttribute("message", "Enter financial");
        return "financial";
    }
	@RequestMapping("/portpolio")
	public String iframePages(Model model) {
	      
        model.addAttribute("message", "Enter findcompany");
        return "portpolio";
        }
	@RequestMapping("/polio")
	public String iframePaging(Model model) {
	      
        model.addAttribute("message", "Enter findcompany");
        return "polio";
        }
	
	private StockMapper mapper;
	@RequestMapping("/admin/financia_admin")
	public String iframePaged(Model model) {
		
		model.addAttribute("list", mapper.getStockList());
        model.addAttribute("message", "Enter findcompany");
        return "/admin/financia_admin";
        }
}
