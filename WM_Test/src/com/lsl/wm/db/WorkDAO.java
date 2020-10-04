package com.lsl.wm.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lsl.wm.vo.ShowVO;
import com.lsl.wm.vo.UserVO;
import com.lsl.wm.vo.WorkVO;

public class WorkDAO {
	
	public static int insWork(WorkVO param) {
		String sql = " INSERT INTO t_work " 
				+ " (i_user, i_show, work_images, work_title, work_ctnt) " 
				+ " VALUES " 
				+ " (?, ?, ?, ?, ?) ";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_user());
				ps.setInt(2, param.getI_show());
				ps.setNString(3, param.getWork_image());
				ps.setNString(4, param.getWork_title());
				ps.setNString(5, param.getWork_ctnt());
			
			}
		});
	}
	//가장 마지막에 저장된 i_work를 가져오는 메소드
	public static WorkVO selLatestWork(WorkVO param) {
		String sql = " SELECT "
				+ " MAX(i_work) as i_work "
				+ " FROM t_work "
				+ " WHERE i_user = ? ";
		
		WorkVO vo = new WorkVO();
		
		JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {
			
			@Override
			public void prepared(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_user());
			}
			
			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				while(rs.next()) {
					vo.setI_work(rs.getInt("i_work"));
				
				}
				return 1;
			}
		});
		
		return vo;
	}
	
	//작품 리스트를 가져오는 메소드
	public static List<WorkVO> selWorkList(WorkVO param) {
		String sql = " SELECT i_work, i_user, work_title, work_images, work_ctnt, i_show"
				   + " FROM t_work ";
		
		if(param.getI_user() != 0 || param.getI_show() != 0) {
			sql += " WHERE ";
			if(param.getI_user() != 0 && param.getI_show() != 0) {
				sql += " i_user = ? AND i_show = ?";
			}else {
				if(param.getI_user() != 0) {
					sql += " i_user = ? ";
				}
				if(param.getI_show() != 0) {
					sql += " i_show = ? ";
				}
			}
		}
				  
		
		List<WorkVO> list = new ArrayList();
		
		JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {
			
			@Override
			public void prepared(PreparedStatement ps) throws SQLException {
			
				if (param.getI_user() != 0 && param.getI_show() != 0) {
					ps.setInt(1, param.getI_user());
					ps.setInt(2, param.getI_show());
				} else {
					if (param.getI_user() != 0) {
						ps.setInt(1, param.getI_user());
					}
					if (param.getI_show() != 0) {
						ps.setInt(1, param.getI_show());
					}
				}
				
			}
			
			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				while(rs.next()) {
					WorkVO vo = new WorkVO();
					vo.setI_user(rs.getInt("i_user"));
					vo.setI_work(rs.getInt("i_work"));
					vo.setWork_title(rs.getString("work_title"));
					vo.setWork_ctnt(rs.getString("work_ctnt"));
					vo.setWork_image(rs.getString("work_images"));
					vo.setI_show(rs.getInt("i_show"));
					
					list.add(vo);
				}
				return 1;
			}
		});
		
		return list;
	}
	
	//작품 리스트를 가져오는 메소드
	public static WorkVO selWork(WorkVO param) {
			String sql = " SELECT i_work, i_user, work_title, work_images, work_ctnt"
					   + " FROM t_work ";
			
			if(param.getI_user() != 0 || param.getI_show() != 0 || param.getI_work() != 0) {
				sql += " WHERE ";
				if(param.getI_user() != 0 && param.getI_show() != 0 && param.getI_work() != 0) {
					sql += " i_user = ? AND i_show = ? AND i_work = ?";
				}else {
					if(param.getI_user() != 0) {
						sql += " i_user = ? ";
					}
					if(param.getI_show() != 0) {
						sql += " i_show = ? ";
					}
					if(param.getI_work() != 0) {
						sql += " i_work = ? ";
					}
				}
			}
					  
			
			WorkVO vo = new WorkVO();
			
			JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {
				
				@Override
				public void prepared(PreparedStatement ps) throws SQLException {
				
					if (param.getI_user() != 0 && param.getI_show() != 0 && param.getI_work() != 0) {
						ps.setInt(1, param.getI_user());
						ps.setInt(2, param.getI_show());
						ps.setInt(3, param.getI_work());
					} else {
						if (param.getI_user() != 0) {
							ps.setInt(1, param.getI_user());
						}
						if (param.getI_show() != 0) {
							ps.setInt(1, param.getI_show());
						}
						if (param.getI_work() != 0) {
							ps.setInt(1, param.getI_work());
						}
					}
					
				}
				
				@Override
				public int executeQuery(ResultSet rs) throws SQLException {
					while(rs.next()) {
						vo.setI_user(rs.getInt("i_user"));
						vo.setI_work(rs.getInt("i_work"));
						vo.setWork_title(rs.getString("work_title"));
						vo.setWork_ctnt(rs.getString("work_ctnt"));
						vo.setWork_image(rs.getString("work_images"));
							
					}
					return 1;
				}
			});
			
			return vo;
		}
		
		public static int updWork(WorkVO param) {
			String sql = " UPDATE t_work " 
					+ " SET " 
					+ " work_title = ?, " 
					+ " work_ctnt = ?, ";
			if(param.getWork_image() != null) {
				sql += " work_images = ?, ";
			}
					
					sql += " m_dt = NOW() "
					+ " WHERE i_work = ? ";
			
			return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
				
				@Override
				public void update(PreparedStatement ps) throws SQLException {
					ps.setString(1, param.getWork_title());
					ps.setString(2, param.getWork_ctnt());
					if(param.getWork_image() != null) {
						ps.setNString(3, param.getWork_image());
						ps.setInt(4, param.getI_work());
					}else {
						ps.setInt(3, param.getI_work());
					}
					
				}
			});
		}
	
	public static int delWork(WorkVO param) {
		String sql = " DELETE " 
				+ " FROM t_work " 
				+ " WHERE i_work = ? AND i_user = ?";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_work());
				ps.setInt(2, param.getI_user());
			
			}
		});
	}
	
}
