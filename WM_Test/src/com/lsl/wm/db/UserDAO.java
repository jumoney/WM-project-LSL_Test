package com.lsl.wm.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.lsl.wm.vo.UserVO;

public class UserDAO {
	public static int insUser(UserVO param) {
		String sql = " INSERT INTO t_user " 
				+ " (user_email, nickname, user_pw, user_year, user_month, user_date, news) " 
				+ " VALUES " 
				+ " ( ?, ?, ?, ?, ?, ?, ?) ";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setNString(1, param.getUser_email());
				ps.setNString(2, param.getNickname());
				ps.setNString(3, param.getUser_pw());
				ps.setNString(4, param.getUser_year());
				ps.setNString(5, param.getUser_month());
				ps.setNString(6, param.getUser_date());
				ps.setNString(7, param.getNews());
			}
		});
	}
	
	public static int login(UserVO param) {
		String sql = " SELECT i_user, user_pw "
				   + " FROM t_user "
				   + " WHERE user_email = ? ";
		
		return JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {
			
			@Override
			public void prepared(PreparedStatement ps) throws SQLException {
				ps.setNString(1, param.getUser_email());
			}
			
			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				if(rs.next()) {
					String dbPw = rs.getNString("user_pw");
					if(dbPw.equals(param.getUser_pw())) {
						int i_user = rs.getInt("i_user");
						
						param.setUser_pw(null);
						param.setI_user(i_user);
						return 1; // 로그인 성공
					} else {
						return 2; // 비밀번호 틀림
					}
				} else return 3; // 아이디 없음
			}
		});
	}
	public static int nickNameChk(UserVO param) {
		String sql = " SELECT nickname "
				   + " FROM t_user "
				   + " WHERE nickname = ? ";
		
		return JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {
			
			@Override
			public void prepared(PreparedStatement ps) throws SQLException {
				ps.setNString(1, param.getNickname());
			}
			
			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				if(rs.next()) {
					return 0; 
				} else {
					return 1;
				}
			}
		});
	}
}
