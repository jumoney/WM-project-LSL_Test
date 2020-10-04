package com.lsl.wm.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.lsl.wm.vo.WorkLikeDomain;
import com.lsl.wm.vo.WorkLikeVO;
import com.lsl.wm.vo.WorkVO;

public class WorkLikeDAO {
	public static int insWorkLike(WorkLikeVO param) {
		String sql = " INSERT INTO t_work_like " 
				+ " (i_user, i_work) " 
				+ " VALUES " 
				+ " (?, ?) ";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_user());
				ps.setInt(2, param.getI_work());
			}
		});
	}
	
	//
		public static WorkLikeDomain selWorkLike(WorkLikeDomain param) {
				String sql = " SELECT count(i_user) as cnt"
						   + " FROM t_work_like "
						   + " WHERE i_user = ? AND i_work = ?";
						  
				JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {
					
					@Override
					public void prepared(PreparedStatement ps) throws SQLException {
						ps.setInt(1, param.getI_user());
						ps.setInt(2, param.getI_work());
					}
					
					@Override
					public int executeQuery(ResultSet rs) throws SQLException {
						while(rs.next()) {
							param.setIsLike(rs.getInt("cnt"));
						}
						return 0;
					}
				});
				
				return param;
			}
		
		public static WorkLikeDomain selWorkLikeCnt(WorkLikeVO param) {
			String sql = " SELECT count(i_user) as cnt"
					   + " FROM t_work_like "
					   + " WHERE i_work = ?";
					  
			
			WorkLikeDomain domain = new WorkLikeDomain();
			domain.setWorkLikeCnt(0);
			
			JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {
				
				@Override
				public void prepared(PreparedStatement ps) throws SQLException {
					ps.setInt(1, param.getI_work());
				}
				
				@Override
				public int executeQuery(ResultSet rs) throws SQLException {
					while(rs.next()) {
						domain.setWorkLikeCnt(rs.getInt("cnt"));
					}
					return 0;
				}
			});
			
			return domain;
		}
		
		public static int delWorkLike(WorkLikeVO param) {
			String sql = " DELETE " 
					+ " FROM t_work_like " 
					+ " WHERE " 
					+ " i_user = ? AND i_work = ? ";
			
			return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
				
				@Override
				public void update(PreparedStatement ps) throws SQLException {
					ps.setInt(1, param.getI_user());
					ps.setInt(2, param.getI_work());
				}
			});
		}
	
}
