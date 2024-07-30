package com.pkt.model;

import lombok.Data;

@Data
public class PortVO {

	private String userid; 
	private String company;
	private String stock_id;
	
	 @Override
	 public boolean equals(Object o) {
	    if (this == o) return true;
	    if (o == null || getClass() != o.getClass()) return false;
	    	PortVO portVO = (PortVO) o;

	        // company 필드를 기준으로 equals 메서드 구현
	        return company != null ? company.equals(portVO.company) : portVO.company == null;
	 }

	 @Override
	 public int hashCode() {
		 // company 필드를 기준으로 hashCode 메서드 구현
		 return company != null ? company.hashCode() : 0;
	}
}
