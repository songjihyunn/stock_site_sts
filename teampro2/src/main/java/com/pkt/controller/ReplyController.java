package com.pkt.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.pkt.model.Criteria;
import com.pkt.model.PageMaker;
import com.pkt.model.ReplyVO;
import com.pkt.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/replies/")
@AllArgsConstructor
public class ReplyController {
	private ReplyService service;

	//글 등록
	@RequestMapping(value = "", method = RequestMethod.POST)
	public String register(@RequestBody ReplyVO vo, Model model, HttpSession session) {
		log.info("댓글 등록..................");
		// 세션에서 로그인된 사용자의 이메일 가져오기
	    String connectType = (String) session.getAttribute("connecttype");
	    String userEmail = null;
	    
	    if ("로컬".equals(connectType)) {
	        userEmail = (String) session.getAttribute("id");
	    } else {
	        userEmail = (String) session.getAttribute("email");
	    }
	    
	    model.addAttribute("userEmail", userEmail);
	    log.info("userEmail:" + userEmail);
		service.addReply(vo);

		return "success";
	}

	//글 목록
	@RequestMapping(value = "/all/{bno}", method = RequestMethod.GET)
	public List<ReplyVO> list(@PathVariable("bno") Integer bno) {

		return service.listReply(bno);
	}

	//글 수정
	@RequestMapping(value = "/{rno}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public String update(@PathVariable("rno") Integer rno, @RequestBody ReplyVO vo, Model model, HttpSession session) {
		
		// 세션에서 로그인된 사용자의 이메일 가져오기
	    String connectType = (String) session.getAttribute("connecttype");
	    String userEmail = null;
	    
	    if ("로컬".equals(connectType)) {
	        userEmail = (String) session.getAttribute("id");
	    } else {
	        userEmail = (String) session.getAttribute("email");
	    }
	    
	    model.addAttribute("userEmail", userEmail);
	    log.info("userEmail:" + userEmail);
		
		vo.setRno(rno);
		service.modifyReply(vo);

		return "success";
	}

	//글 삭제
	@RequestMapping(value = "/{rno}", method = RequestMethod.DELETE)
	public String remove(@PathVariable("rno") Integer rno, Model model, HttpSession session) {
		// 세션에서 로그인된 사용자의 이메일 가져오기
	    String connectType = (String) session.getAttribute("connecttype");
	    String userEmail = null;
	    
	    if ("로컬".equals(connectType)) {
	        userEmail = (String) session.getAttribute("id");
	    } else {
	        userEmail = (String) session.getAttribute("email");
	    }
	    
	    model.addAttribute("userEmail", userEmail);
	    log.info("userEmail:" + userEmail);
		
		
		service.removeReply(rno);

		return "success";
	}

	//페이징 처리
	@RequestMapping(value = "/{bno}/{page}", method = RequestMethod.GET)
	public Map<String, Object> listPage2(
		@PathVariable("bno") Integer bno,
		@PathVariable("page") Integer page) {

		Criteria cri = new Criteria();
		cri.setPage(page);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);

		int replyCount = service.count(bno);
		pageMaker.setTotalCount(replyCount);

		List<ReplyVO> list = service.listReplyPage(bno, cri);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("list", list);
		map.put("pageMaker", pageMaker);

		return map;
	}
}
