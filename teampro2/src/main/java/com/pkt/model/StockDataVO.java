package com.pkt.model;

import lombok.Data;

@Data
public class StockDataVO {
	private String stock_code;
	private double price;
	private int stock_id;
	
	public StockDataVO() {
		
	}
	
	public StockDataVO(String stock_code, double price, int stock_id) {
		this.stock_code = stock_code;
		this.price = price;
		this.stock_id = stock_id;
	}
}
