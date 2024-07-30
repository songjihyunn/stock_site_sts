package com.pkt.service;

import java.util.List;

import com.pkt.model.Criteria;
import com.pkt.model.ReplyVO;

public interface ReplyService {
	public List<ReplyVO> listReply(Integer bno);
	public void addReply(ReplyVO vo);		
	public void modifyReply(ReplyVO vo);
	public void removeReply(Integer rno);
	
	public List<ReplyVO> listReplyPage(Integer bno, Criteria cri);
	public int count(Integer bno);
}
