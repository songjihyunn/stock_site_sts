package com.pkt.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pkt.mapper.StockMapper;

@Controller
public class AdminIndexController {

	private static final Logger logger = LoggerFactory.getLogger(AdminIndexController.class);
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String adminIndex(Locale locale, Model model) {
		logger.info("====================adminindex====================");
		
		
		return "/admin/adminIndex";
	}
}
