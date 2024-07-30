package com.pkt.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pkt.mapper.AdminBoardMapper;
import com.pkt.model.AdminCriteria;
import com.pkt.model.AdminPageMaker;
import com.pkt.model.BoardVO;
import com.pkt.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/")
@AllArgsConstructor
public class AdminBoardController {
	
	private AdminBoardMapper amapper;
	private ReplyService service;
	
	@GetMapping("board/adminBoardList")
    public String listPage(@ModelAttribute("acri") AdminCriteria acri, Model model, @RequestParam(defaultValue = "1") int page) {
        log.info("==========================ADMIN BOARD LIST==========================");

        acri.setPage(page); // 페이지 설정
        model.addAttribute("board", amapper.getBoardList(acri)); // 현재 페이지 리스트 출력 내용
        model.addAttribute("total", amapper.boardCount()); // 현재 페이지 리스트 출력 내용

        AdminPageMaker adminpm = new AdminPageMaker();
        adminpm.setAcri(acri);
        adminpm.setTotalCount(amapper.countPaging(acri));
        model.addAttribute("adminpm", adminpm);

        return "admin/board/adminBoardList"; // View 이름 반환
    }
	
	@GetMapping("board/adminBoardView")
	public String viewPage(@ModelAttribute("acri") AdminCriteria acri, @RequestParam(defaultValue = "1") int page,
			Model model, BoardVO board, int bno) {
		log.info("==========================ADMIN BOARD VIEW==========================");
	    
		AdminPageMaker adminpm = new AdminPageMaker();
		adminpm.setAcri(acri);
		model.addAttribute("adminpm", adminpm);
		model.addAttribute("boardVO", amapper.getOneBoard(bno));
		
		return "admin/board/adminBoardView";
	}
	
	@PostMapping("board/adminBoardView")
	public String remove(@ModelAttribute("acri") AdminCriteria acri,
			String show_code,
			RedirectAttributes rttr,
	        @RequestParam(value = "bno", defaultValue = "1") Integer bno,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            @RequestParam(value = "perPageNum", required = false, defaultValue = "10") int perPageNum, 
            @RequestParam(value = "searchType", required = false, defaultValue = "") String searchType, 
            @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) {
	    log.info("==========================ADMIN BOARD UPDATE==========================");

		Map<String,Object> map = new HashMap<>();
		
		map.put("show_code", show_code);
		map.put("bno", bno);
		
		System.out.println("show_code:"+show_code);
		System.out.println("bno:"+bno);
		
	    amapper.update(map);
	    
		AdminPageMaker adminpm = new AdminPageMaker();
		adminpm.setAcri(acri);

        rttr.addAttribute("page", page);
        rttr.addAttribute("perPageNum", perPageNum);
        rttr.addAttribute("searchType", searchType);
        rttr.addAttribute("keyword", keyword);
		
	    rttr.addAttribute("bno", bno);
	    rttr.addFlashAttribute("msg", "수정 완료!");
	    
	    return "redirect:/admin/board/adminBoardView";
	}

}
