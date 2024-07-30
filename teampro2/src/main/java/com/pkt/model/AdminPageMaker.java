package com.pkt.model;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class AdminPageMaker {
	private int totalCount; // 총 게시물 수
	private int startPage; // 시작 페이지
	private int endPage; // 끝 페이지
	private boolean prev; // 이전 링크
	private boolean next; // 다음 링크
	private int displayPageNum = 5; //블럭 갯수
	private AdminCriteria acri; // limit 메소드 이용
	
	private void calcData() {
		endPage = (int) (Math.ceil(acri.getPage() / (double) displayPageNum) * displayPageNum);
		//endPage를 구하고 startPage를 구하는게 여기서는 더 편리하다.
		//endPage = 현재 페이지 번호 / 블럭 개수 * 블럭 개수
		//현재 페이지가 3 : Math.ceil(3/10) * 10 = 10
		//현재 페이지가 1 : Math.ceil(1/10) * 10 = 10
		//현재 페이지가 20 : Math.ceil(20/10) * 10 = 20
		//현재 페이지가 21 : Math.ceil(21/10) * 10 = 30	

		startPage = (endPage - displayPageNum) + 1;
		//현재 페이지가 21 : startPage = (30 - 10) + 1 = 21 

		// 마지막 블럭일 경우 계산 처리
		int tempEndPage = (int) (Math.ceil(totalCount / (double) acri.getPerPageNum()));
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}

		prev = startPage == 1 ? false : true; //시작 페이지가 1이 아니라면 true
		next = endPage * acri.getPerPageNum() >= totalCount ? false : true;
		//endPage = 10 , perPageNum = 10 , totalCount = 101 이라면 next = true 되어야 한다. 
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		
		//위 메소드 호출
		calcData();
	}

	// get방식 - url 주소 변수 값 - 처리 용이하게..
	public String makeQuery(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
			.queryParam("page", page)
			.queryParam("perPageNum", acri.getPerPageNum())
			.build();

		return uriComponents.toUriString();
	}
	// search 추가
	public String makeSearch(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
			.queryParam("page", page)
			.queryParam("perPageNum", acri.getPerPageNum())
			.queryParam("searchType", acri.getSearchType())
			.queryParam("keyword", acri.getKeyword())
			//.queryParam("keyword", encoding(cri.getKeyword()))
			.build();

		return uriComponents.toUriString();
	}

	// get 방식으로 값을 넘겼을때 한글이 깨질 경우 처리 추가
	private String encoding(String keyword) {
		if (keyword == null || keyword.trim().length() == 0) {
			return "";
		}

		try {
			return URLEncoder.encode(keyword, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			return "";
		}
	}

}