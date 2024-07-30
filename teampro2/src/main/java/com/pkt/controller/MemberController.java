package com.pkt.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.pkt.mapper.MemberMapper;
import com.pkt.model.LoginDTO;
import com.pkt.model.MemberVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/")
@AllArgsConstructor
public class MemberController {

	private MemberMapper mapper;

	@GetMapping("/id_ok") // 이메일 중복 확인
	public @ResponseBody int idOk(String useremail) {
		log.info("id_ok get ...........");
		return mapper.idOk(useremail); // 중복: 1, 중복 아님: 0
	}

	@GetMapping("/join") // 회원가입 페이지 요청
	public void joinGET(MemberVO member) {
		log.info("join get ...........");
	}

	@PostMapping("/join") // 회원가입 처리
	public String joinPOST(MemberVO member, RedirectAttributes rttr) {
		log.info("join post ...........");
		member.setConnecttype("로컬");
		mapper.create(member);
		return "redirect:/";
	}

	@GetMapping("/login") // 로그인 페이지 요청
	public void loginGET() {
		log.info("login get ...........");
	}

	@PostMapping("/login") // 로그인 처리
	public String loginPOST(LoginDTO dto, HttpSession session, RedirectAttributes rttr) {
		MemberVO vo = mapper.login(dto);
		
		if (vo != null) { // 회원이 존재할 경우
			session.setAttribute("id", vo.getUseremail());
			log.info("ID:" + vo.getUseremail());
			session.setAttribute("connecttype", vo.getConnecttype()); // 로그인 유형 설정
			session.setAttribute("name", vo.getUsername());
			session.setAttribute("level", vo.getLevel());

			return "redirect:/";
		} else {
			rttr.addFlashAttribute("msg", "잘못된 로그인 정보입니다.");
			return "redirect:login";
		}
	}
	
	@GetMapping("/logout") // 로그아웃 처리
	public String logout(HttpSession session) {
		session.invalidate(); // 세션 무효화
		return "redirect:/";
	}
	
	@GetMapping("/joinup") // 회원 정보 수정 페이지 요청
	public void joinupGET(HttpSession session, Model model) {
		log.info("joinup get ...........");
		String session_id = (String) session.getAttribute("id");

		MemberVO member = mapper.read(session_id);
		model.addAttribute("member", member);
	}

	@PostMapping("/joinup") // 회원 정보 수정 처리
	public String joinupPOST(MemberVO member, String userpw2, RedirectAttributes rttr) {
		log.info("joinup post ...........");

		if (!userpw2.equals("") && userpw2.equals(member.getUserpw())) { // 비밀번호 수정 시
			mapper.updatePass(member);
		} else { // 일반 정보 수정 시
			mapper.update(member);
		}

		rttr.addFlashAttribute("msg", "modify");
		return "redirect:joinup";
	}
	
	@GetMapping("/ok") // 이메일 확인 처리
	public @ResponseBody String okEmail(String confirmation, String verificationCode) {
		log.info("okEmail get ...........");
	    
		// 입력된 코드와 확인 코드를 비교
		if (confirmation.equals(verificationCode)) {
			return "yes"; // 일치할 경우 "yes" 반환
		} else {
			return "no"; // 불일치할 경우 "no" 반환
		}
	}
	
	@GetMapping("/kakao") // 카카오 로그인 처리
	public @ResponseBody int kakaoLogin(MemberVO vo, HttpSession session) {
		log.info("kakao login ...............");

		int result = mapper.idOk(vo.getUseremail()); // 이메일 중복 여부 확인: 중복일 경우 1, 아닐 경우 0
		if (result == 0) { // 새로운 회원일 경우
			vo.setConnecttype("카카오");
			vo.setUsername(vo.getUsername());
			vo.setUserpw("1234567890"); // 기본 비밀번호 설정
			mapper.createKakao(vo); // 카카오 회원 가입 처리
		}

		vo = mapper.read(vo.getUseremail());

		session.setAttribute("id", vo.getUseremail());
		session.setAttribute("connecttype", vo.getConnecttype()); // 로그인 유형 설정
		session.setAttribute("name", vo.getUsername());
		session.setAttribute("level", "1");
		return result;
	}

	@GetMapping("/kakaoLogout") // 카카오 로그아웃 처리
	public @ResponseBody String kakaoLogout(HttpSession session) {
		log.info("kakao logout .....................");
		session.invalidate();
		return "kakaoLogout";
	}
	
	@GetMapping("/naverLogin") // 네이버 로그인 페이지 요청
	public void naverLogin() {
		log.info("naver 로그인 .....................");
	}

	@GetMapping("/naver") // 네이버 로그인 처리
	public String naverLogin(MemberVO vo, String phone, HttpSession session) {
		log.info("naver 로그인 처리 ...............");

		// 전화번호 분리하여 저장
		String tp[] = phone.split("-");
		vo.setPhone1(tp[0]);
		vo.setPhone2(tp[1]);
		vo.setPhone3(tp[2]);

		int result = mapper.idOk(vo.getUseremail()); // 이메일 중복 여부 확인: 중복일 경우 1, 아닐 경우 0
		if (result == 0) { // 새로운 회원일 경우
			vo.setConnecttype("네이버");
			vo.setUserpw("1234567890"); // 기본 비밀번호 설정
			log.info(vo);
			mapper.createNaver(vo); // 네이버 회원 가입 처리
		}

		vo = mapper.read(vo.getUseremail());

		session.setAttribute("id", vo.getUseremail());
		session.setAttribute("connecttype", vo.getConnecttype()); // 로그인 유형 설정
		session.setAttribute("name", vo.getUsername());
		session.setAttribute("level", "1");
		return "redirect:/";
	} 
	
	@GetMapping("/find") // 아이디/비밀번호 찾기 페이지 요청
	public void findget() {
		log.info("find get ...........");
	}

	@PostMapping("/findUserId") // 아이디 찾기 처리
	public String findUserId(String phone2, String phone3, Model model) {
	    MemberVO user = mapper.findUserId(phone2, phone3);
	    model.addAttribute("user", user);

	    if (user != null && user.getUseremail() != null) {
	        model.addAttribute("message", "아이디는 " + user.getUseremail() + " 입니다.");
	    } else {
	        model.addAttribute("message", "일치하는 사용자를 찾을 수 없습니다.");
	    }

	    return "redirect:/member/find";
	}
	
	@PostMapping("/findUserPass") // 비밀번호 찾기 처리
	public String findUserPass(@RequestParam("email") String email, Model model) {
	    MemberVO userpass = mapper.findUserPass(email);
	    model.addAttribute("userpass", userpass);

	    if (userpass != null && userpass.getUserpw() != null) {
	        model.addAttribute("message", "비밀번호는 " + userpass.getUserpw() + " 입니다.");
	    } else {
	        model.addAttribute("message", "일치하는 사용자를 찾을 수 없습니다.");
	    }
	    return "redirect:/member/find";
	}
}
