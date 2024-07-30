package com.pkt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.pkt.model.PortVO;

public interface PortMapper {
	
	public int idOk(String userid); // 중복 확인 
	
	public void create(PortVO vo);      // 포트 정보 등록	    
	public void update(PortVO vo);		// 수정
	
	public void delete(@Param("userid") String userid, @Param("company") String company,  @Param("stock_id") String stock_id);
	
	@Select("SELECT * FROM polio WHERE userid = #{userid}")
	List<PortVO> getListByUserId(@Param("userid") String userid);
	 
	@Select("SELECT COUNT(*) FROM polio WHERE userid = #{userid}")
	public void getPortfolioCount(@Param("userid") String userid);
}
