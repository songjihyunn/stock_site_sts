package com.pkt.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.pkt.mapper.ReplyMapper;
import com.pkt.model.Criteria;
import com.pkt.model.ReplyVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service //스프링 빈으로 인식되기 위해 선언
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService{
	private ReplyMapper mapper;

	@Override
	public List<ReplyVO> listReply(Integer bno) {
		return mapper.list(bno);
	}

	@Override
	public void addReply(ReplyVO vo) {
		mapper.create(vo);		
	}

	@Override
	public void modifyReply(ReplyVO vo) {
		mapper.update(vo);
	}

	@Override
	public void removeReply(Integer rno) {
		mapper.delete(rno);
	}
	
	@Override
	public List<ReplyVO> listReplyPage(Integer bno, Criteria cri) {
		//Map: 인터페이스
		//HashMap: Map을 구현한 클래스 중 하나
		Map<String, Object> m = new HashMap<>(); 

		m.put("bno", bno);
		m.put("cri", cri);

		return mapper.listPage(m);
	}

	@Override
	public int count(Integer bno) {
		return mapper.count(bno);
	}
}
