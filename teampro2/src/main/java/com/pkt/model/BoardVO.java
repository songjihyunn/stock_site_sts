package com.pkt.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BoardVO {
	private Integer bno;
	private String title;
	private String content;
	private String writer;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date regdate;
	private int viewcnt;
	private String file01;
	private String file02;
	private String file03;
	private String file01_thum;
	private String code;
	private String show_code;
}
