package com.lsl.wm.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lsl.wm.vo.WorkCmtDomain;
import com.lsl.wm.vo.WorkCmtVO;
import com.lsl.wm.vo.WorkVO;

public class WorkCmtDAO {
	
	public static int insWorkCmt(WorkCmtVO param) {
		String sql = " INSERT INTO t_work_cmt " 
				+ " (i_work, i_user, cmt) " 
				+ " VALUES " 
				+ " (?, ?, ?) ";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_work());
				ps.setInt(2, param.getI_user());
				ps.setNString(3, param.getCmt());
			}
		});
	}
	
	//��� ����Ʈ�� �������� �޼ҵ�
		public static List<WorkCmtDomain> selWorkCmtList(WorkCmtVO param) {
			String sql = " SELECT B.nickname, A.cmt, A.r_dt, A.i_user"
					   + " FROM t_work_cmt A "
					   + " JOIN t_user B "
					   + " ON A.i_user = B.i_user "
					   + " WHERE i_work = ? "
					   + " ORDER BY A.r_dt DESC ";

			List<WorkCmtDomain> list = new ArrayList();
			
			JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {
				
				@Override
				public void prepared(PreparedStatement ps) throws SQLException {
					ps.setInt(1, param.getI_work());
				}
				
				@Override
				public int executeQuery(ResultSet rs) throws SQLException {
					while(rs.next()) {
						WorkCmtDomain vo = new WorkCmtDomain();
						vo.setNickname(rs.getString("nickname"));
						vo.setCmt(rs.getString("cmt"));
						vo.setI_user(rs.getInt("i_user"));

						list.add(vo);
					}
					return 1;
				}
			});
			
			return list;
		}
}