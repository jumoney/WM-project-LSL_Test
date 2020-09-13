package com.lsl.wm.user_writer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lsl.wm.vo.WorkVO;

@WebServlet("/exhibit_page2")
public class ExihibitPage2Ser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String jsp = "/WEB-INF/user_writer/exhibit_page2.jsp";
		request.getRequestDispatcher(jsp).forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int list_count = Integer.parseInt(request.getParameter("exhibit_list_cnt"));
		List<WorkVO> list = new ArrayList();
		
		for(int i=0; i<list_count; i++) {
			WorkVO vo = new WorkVO();
			String title = request.getParameter("input_title_" + i);
			String comment = request.getParameter("input_comment_" + i);
			vo.setTitle(title);
			vo.setComment(comment);
			list.add(vo);
		}
		request.setAttribute("workList", list);
		
		doGet(request, response);
	}

}
