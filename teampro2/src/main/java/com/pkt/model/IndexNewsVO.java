package com.pkt.model;

import lombok.Data;

@Data
public class IndexNewsVO {
	private int id;
	private String title;
	private String content;
	private String[] images;
	private String imageFileNames;
	private String stockCode;
	private String koreanStockName;
	private String englishStockName;
	private String date;
}
