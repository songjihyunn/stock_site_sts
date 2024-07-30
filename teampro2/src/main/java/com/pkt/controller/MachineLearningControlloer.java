package com.pkt.controller;
 
import java.util.Locale;
 
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
 
@Controller
public class MachineLearningControlloer {
 
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "mlkr", method = RequestMethod.GET)
	public String mlkr(Locale locale, Model model) {
		logger.info("====================machine learning kr====================");
		
		return "/ml/mlkr";
	}
 
	@RequestMapping(value = "mlus", method = RequestMethod.GET)
	public String mlus(Locale locale, Model model) {
		logger.info("====================machine learning us====================");
		
		return "/ml/mlus";
	}
 
	@RequestMapping(value = "stock_graph", method = RequestMethod.GET)
	public String stock_graph(Locale locale, Model model) {
		logger.info("====================stock graph====================");
		
		return "stock_graph";
	}
 
}