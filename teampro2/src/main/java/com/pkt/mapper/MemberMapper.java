package com.pkt.mapper;

import com.pkt.model.LoginDTO;
import com.pkt.model.MemberVO;

public interface MemberMapper {

	public int idOk(String useremail); // 중복 확인 
    public void create(MemberVO vo);  // 회원가입 
    public MemberVO login(LoginDTO dto); // 로그인 
    public MemberVO read(String useremail); // 로그인 상태 확인 
    public void update(MemberVO vo); // 회원 정보 수정 
    public void updatePass(MemberVO vo); // 비밀번호 수정
    public void createKakao(MemberVO vo); // 카카오 회원가입 
    public void createNaver(MemberVO vo); // 네이버 회원가입 
    public MemberVO findUserId(String phone2, String phone3); // 아이디 찾기
    public MemberVO findUserPass(String useremail); // 비밀번호 찾기

}

