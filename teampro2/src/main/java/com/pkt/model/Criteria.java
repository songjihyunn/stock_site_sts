package com.pkt.model;

import lombok.Data;

@Data
public class Criteria {
	private int page;	//페이지
	private int perPageNum;	//한 페이지당 출력할 게시물
	private String searchType; //검색타입
	private String keyword; //검색어

	public Criteria() {
		this.page = 1; //첫 페이지 초기화
		this.perPageNum = 5; //한 페이지당 출력 할 게시물 수
	}

	// limit 시작 값
	public int getPageStart() {
		return (this.page - 1) * this.perPageNum;
	}
}
