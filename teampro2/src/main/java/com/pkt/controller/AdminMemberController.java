package com.pkt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pkt.mapper.AdminMemberMapper;
import com.pkt.model.AdminCriteria;
import com.pkt.model.AdminPageMaker;
import com.pkt.model.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/")
@AllArgsConstructor
public class AdminMemberController {

    private AdminMemberMapper amapper;

    @GetMapping("member/adminMemberList")
    public String listPage(@ModelAttribute("acri") AdminCriteria acri, Model model, @RequestParam(defaultValue = "1") int page) {
        log.info("==========================ADMIN MEMBER LIST==========================");

        acri.setPage(page); // 페이지 설정
        model.addAttribute("member", amapper.getMemberList(acri)); // 현재 페이지 리스트 출력 내용
        model.addAttribute("total", amapper.memberCount()); // 현재 페이지 리스트 출력 내용

        AdminPageMaker adminpm = new AdminPageMaker();
        adminpm.setAcri(acri);
        adminpm.setTotalCount(amapper.countPaging(acri));
        model.addAttribute("adminpm", adminpm);

        return "admin/member/adminMemberList"; // View 이름 반환
    }

    @GetMapping("member/adminMemberModify")
    public String oneMember(@ModelAttribute("acri") AdminCriteria acri, Model model, 
                          @RequestParam(value = "useremail") String useremail,
                          @RequestParam(defaultValue = "1") int page) {
        log.info("==========================ADMIN MEMBER MODIFY==========================");
		
		AdminPageMaker adminpm = new AdminPageMaker();
		adminpm.setAcri(acri);
		
		model.addAttribute("adminpm", adminpm);
		model.addAttribute("member", amapper.getOneMember(useremail));
		
		return "admin/member/adminMemberModify";
    }

    @PostMapping("member/adminMemberModify")
    public String update(@ModelAttribute MemberVO member, Model model, AdminCriteria acri, RedirectAttributes rttr, 
			             @RequestParam(value = "useremail") String useremail,
			             @RequestParam(value = "page", required = false, defaultValue = "1") int page,
			             @RequestParam(value = "perMemberPage", required = false, defaultValue = "10") int perMemberPage, 
			             @RequestParam(value = "searchType", required = false, defaultValue = "") String searchType, 
			             @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) {
        log.info("==========================ADMIN MEMBER UPDATE==========================");
        amapper.memberModify(member);
        
        rttr.addAttribute("useremail", member.getUseremail());
        rttr.addFlashAttribute("msg", "수정완료!");
        
        rttr.addAttribute("page", page);
        rttr.addAttribute("perMemberPage", perMemberPage);
        rttr.addAttribute("searchType", searchType);
        rttr.addAttribute("keyword", keyword);

        rttr.addFlashAttribute("msg", "수정완료!");
        
        return "redirect:/admin/member/adminMemberModify";
    }


}
