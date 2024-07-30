package com.pkt.model;
 
import java.util.Date;

import lombok.Data;
 
@Data
public class StockVO {
	private Integer id;
	private String company_name;
	private String stockcode;
	private Date listing_date;
	private String market_type;
	private String listing;
	private String finance_analysis;
	
}
