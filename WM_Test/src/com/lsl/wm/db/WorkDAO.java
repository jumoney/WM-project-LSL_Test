package com.lsl.wm.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lsl.wm.vo.UserVO;
import com.lsl.wm.vo.WorkVO;

public class WorkDAO {
	
	public static int insWork(WorkVO param) {
		String sql = " INSERT INTO t_work " 
				+ " (i_user, work_images, work_title, work_ctnt) " 
				+ " VALUES " 
				+ " ( ?, ?, ?, ?) ";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_user());
				ps.setNString(2, param.getWork_image());
				ps.setNString(3, param.getWork_title());
				ps.setNString(4, param.getWork_ctnt());
			
			}
		});
	}
	
	public static List<WorkVO> selWork(final int i_user) {
		String sql = " SELECT i_work, i_user, work_title, work_images, work_ctnt"
				   + " FROM t_work "
				   + " WHERE i_user = ? ";
		
		List<WorkVO> list = new ArrayList();
		
		JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {
			
			@Override
			public void prepared(PreparedStatement ps) throws SQLException {
				ps.setInt(1, i_user);
			}
			
			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				while(rs.next()) {
					WorkVO vo = new WorkVO();
					vo.setI_user(i_user);
					vo.setI_work(rs.getInt("i_work"));
					vo.setWork_title(rs.getString("work_title"));
					vo.setWork_ctnt(rs.getString("work_ctnt"));
					vo.setWork_image(rs.getString("work_images"));
					
					list.add(vo);
				}
				return 1;
			}
		});
		
		return list;
	}
	

}
