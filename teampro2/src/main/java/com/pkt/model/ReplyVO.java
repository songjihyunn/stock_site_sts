package com.pkt.model;

import lombok.Data;

@Data
public class ReplyVO {
	private Integer rno;
	private Integer bno;
	private String replytext;
	private String replyer;
	private String regdate;
}
