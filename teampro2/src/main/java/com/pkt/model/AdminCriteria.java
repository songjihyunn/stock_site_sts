package com.pkt.model;

import lombok.Data;

@Data
public class AdminCriteria {
	private int page;
	private int perPageNum;
	private String searchType;
	private String keyword;

	public AdminCriteria() {
		this.page = 1;
		this.perPageNum = 5;
	}

	public int getPageStart() {
		return (this.page - 1) * this.perPageNum;
	}
}
