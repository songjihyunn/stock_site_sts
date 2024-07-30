package com.pkt.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pkt.mapper.BoardMapper;
import com.pkt.model.BoardVO;
import com.pkt.model.Criteria;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service //스프링 빈으로 인식되기 위해 선언
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{
	
	private BoardMapper mapper;

	@Override
	public void regist(BoardVO board) {
		log.info("board - insert =======");
		mapper.create(board);
	}

	@Override
	public BoardVO readOne(Integer bno) {
		log.info("board - read =======");
		
		mapper.updateViewCnt(bno);
		return mapper.read(bno);
	}

	@Override
	public void modify(BoardVO board) {
		log.info("board - modify =======");
		mapper.update(board);
	}

	@Override
	public void remove(Integer bno) {
		log.info("board - remove =======");
		mapper.delete(bno);
	}

	@Override
	public List<BoardVO> listAll() {
		log.info("board - list =======");
		return mapper.getList();
	}
	
	@Override
	public List<BoardVO> listCriteria(Criteria cri) {
		return mapper.listCriteria(cri);
	}
	
	@Override
	public int listCountCriteria(Criteria cri) {
		return mapper.countPaging(cri);
	}
	
	@Override
	public List<BoardVO> listSearchCriteria(Criteria cri) {
		return mapper.listSearch(cri);
	}

	@Override
	public int listSearchCount(Criteria cri) {
		return mapper.listSearchCount(cri);
	}
	
	@Override
    public List<BoardVO> searchBoards(String keyword) {
        return mapper.searchBoards(keyword);
    }
}
