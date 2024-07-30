package com.pkt.controller;

import java.sql.Connection;
import java.sql.DriverManager;


public class Test {
	//�ڹ� 1.6 �̻���ʹ� ���񽺷δ� ������� JDBC Driver�� �ڵ����� ��ϵ˴ϴ�.
		//�׷��� Class.forName("com.mysql.jdbc.Driver") ���� �ڵ带 ȣ������ �ʾƵ� �˴ϴ�. :)
		//http://docs.oracle.com/javase/6/docs/api/java/util/ServiceLoader.html
		//private static final String DRIVER = "com.mysql.jdbc.Driver";
		private static final String URL = "jdbc:mariadb://localhost:3306/pro3"; //spring : ����Ÿ���̽��� 
		private static final String USER = "root";
		private static final String PW = "1111";


		@org.junit.Test //�� �κ� ������ ����ٸ� JUnit 4 �߰�
		public void testConnection() throws Exception{

			//Class.forName(DRIVER);
			try{
				Connection con = DriverManager.getConnection(URL,USER,PW); 
				System.out.println(con); //��ü�� ������ �ִ� �ּҰ��� ��µȴ�.

				con.close(); 
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
}
