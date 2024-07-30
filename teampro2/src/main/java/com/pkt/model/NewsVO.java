package com.pkt.model;

import lombok.Data;

@Data
public class NewsVO {
	private Integer id;
	private String title;
	private String content;
	private String images;
	private String imageFileNames;
	private String stockCode;
	private String koreanStockName;
	private String englishStockName;
	private Integer wordCount;
	private String positiveWords;
	private Integer positiveCount;
	private String negativeWords;
	private Integer negativeCount;
	private Float positiveRatio;
	private Float negativeRatio;
	private String sentimentPrediction;
	private int viewcnt; //조회수
}
