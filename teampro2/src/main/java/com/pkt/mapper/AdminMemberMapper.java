package com.pkt.mapper;

import java.util.List;

import com.pkt.model.AdminCriteria;
import com.pkt.model.MemberVO;

public interface AdminMemberMapper {
	public List<MemberVO> getMemberList(AdminCriteria acri);
	public MemberVO getOneMember(String useremail);
	public int memberCount();
	public void memberModify(MemberVO member);
	
	public List<MemberVO> listPage(int page);				//페이징
	public List<MemberVO> listCriteria(AdminCriteria acri);	//페이징
	public int listCountCriteria(AdminCriteria acri);
	public List<MemberVO> listSearch(AdminCriteria acri);
	public int listSearchCount(AdminCriteria acri);
	public int countPaging(AdminCriteria acri);
	
}