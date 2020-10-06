package com.lsl.wm.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class DbCon {
	public static Connection getCon() throws Exception {
		String url = "jdbc:mysql://localhost:3306/root?serverTimezone=Asia/Seoul";
		String id = "root";
		String pw = "koreait2020";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, id, pw);
		System.out.println("�젒�냽 �꽦怨�");
		return con;
	}
	
	public static void close(Connection con, PreparedStatement ps, ResultSet rs) {
		if(rs != null) {try{rs.close();}catch(Exception e) {e.printStackTrace();}}
		if(ps != null) {try{ps.close();}catch(Exception e){}}
		if(con != null) {try{con.close();}catch(Exception e){}}
	}
	public static void close(Connection con, PreparedStatement ps) {
		close(con, ps, null);
	}
}
