package com.lsl.wm.login;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lsl.wm.SecurityUtils;
import com.lsl.wm.db.UserDAO;
import com.lsl.wm.vo.UserVO;

@WebServlet("/join")
public class JoinSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String jsp = "/WEB-INF/login/join.jsp";
		request.getRequestDispatcher(jsp).forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_email = request.getParameter("user_email");
		String nickname = request.getParameter("nickname");
		String user_pw = request.getParameter("user_pw");
		String encrypt_pw = SecurityUtils.encryptString(user_pw);
		String user_year = request.getParameter("user_year");
		String user_month = request.getParameter("user_month");
		String user_date = request.getParameter("user_date");
		String news = request.getParameter("news");
		if(news == null) {
			news = "0"; // 소식받기 체크박스 체크를 하지않으면 null값이 넘어옴, 체크시 value값인 1이 넘어옴
		}

		UserVO param = new UserVO();
		param.setUser_email(user_email);
		param.setNickname(nickname);
		param.setUser_pw(encrypt_pw);
		param.setUser_year(user_year);
		param.setUser_month(user_month);
		param.setUser_date(user_date);
		param.setNews(news);
		
		int result = UserDAO.insUser(param);
		



		response.setContentType("text/html; charset=utf-8");
		PrintWriter out=response.getWriter();
		
		out.println("<script language='javascript'>");
		out.println("alert('회원가입을 축하드립니다!'); location.href='/login'"); // 서블릿에서 script 태그 사용
		out.println("</script>");
		out.flush();
		// sendRedirect 안됨
		// location.href 사용 해야함
		
		
		
	}

}
