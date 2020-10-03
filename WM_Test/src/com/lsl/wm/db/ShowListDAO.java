package com.lsl.wm.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lsl.wm.vo.ShowListDomain;
import com.lsl.wm.vo.ShowListVO;
import com.lsl.wm.vo.WorkVO;

public class ShowListDAO {

	public static int insShowList(ShowListVO param) {
		String sql = " INSERT INTO t_show_list " 
				+ " (i_show, i_work) " 
				+ " VALUES " 
				+ " (?, ?) ";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_show());
				ps.setInt(2, param.getI_work());
			
			}
		});
	}
	
	//작품 리스트를 가져오는 메소드
		public static List<ShowListDomain> selShowList(ShowListVO param) {
			String sql = " SELECT B.i_work, B.i_user, B.work_title, B.work_images, B.work_ctnt"
					   + " FROM t_show_list A"
					   + " JOIN t_work B ON A.i_work = B.i_work "
					   + " WHERE A.i_show = ? ";
					  
			
			List<ShowListDomain> list = new ArrayList();
			
			JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {
				
				@Override
				public void prepared(PreparedStatement ps) throws SQLException {
					ps.setInt(1, param.getI_show());
				}
				
				@Override
				public int executeQuery(ResultSet rs) throws SQLException {
					while(rs.next()) {
						ShowListDomain vo = new ShowListDomain();
						vo.setI_user(rs.getInt("i_user"));
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
		
		public static int delShowList(ShowListDomain param) {
			String sql = " DELETE " 
					+ " FROM t_show_list"
					+ " WHERE i_work = ?";
			
			return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
				
				@Override
				public void update(PreparedStatement ps) throws SQLException {
					ps.setInt(1, param.getI_work());
				}
			});
		}
	
}
