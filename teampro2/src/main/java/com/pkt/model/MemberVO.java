package com.pkt.model;

import lombok.Data;

@Data
public class MemberVO {
	private String useremail; //메일주소를 아이디로 처리
	private String userpw;
	private String username;
	private String connecttype; //로컬,카카오,네이버 로그인 처리 방법
	private String emailresult; //로컬 메일주소 인증처리 여부
	private String phone1;
	private String phone2;
	private String phone3;
	private String signdate;
	private String zipcode;
	private String zipcode1;
	private String zipcode2;
	private String zipcode3;
	private String zipcode4;
	private String level;
}
