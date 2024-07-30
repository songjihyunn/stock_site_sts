package com.pkt.controller;

import java.sql.Connection;
import java.sql.DriverManager;


public class Test {
	//자바 1.6 이상부터는 서비스로더 기반으로 JDBC Driver가 자동으로 등록됩니다.
		//그래서 Class.forName("com.mysql.jdbc.Driver") 류의 코드를 호출하지 않아도 됩니다. :)
		//http://docs.oracle.com/javase/6/docs/api/java/util/ServiceLoader.html
		//private static final String DRIVER = "com.mysql.jdbc.Driver";
		private static final String URL = "jdbc:mariadb://localhost:3306/pro3"; //spring : 데이타베이스명 
		private static final String USER = "root";
		private static final String PW = "1111";


		@org.junit.Test //이 부분 오류가 생긴다면 JUnit 4 추가
		public void testConnection() throws Exception{

			//Class.forName(DRIVER);
			try{
				Connection con = DriverManager.getConnection(URL,USER,PW); 
				System.out.println(con); //객체가 가지고 있는 주소값이 출력된다.

				con.close(); 
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
}
