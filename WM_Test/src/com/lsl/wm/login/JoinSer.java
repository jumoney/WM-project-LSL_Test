package com.lsl.wm.login;

import java.io.IOException;
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
			news = "0";
		}
		
		System.out.println("user_email : " + user_email);
		System.out.println("nickname : " + nickname);
		System.out.println("enryptPw : " + encrypt_pw);
		System.out.println("user_year : " + user_year);
		System.out.println("user_month : " + user_month);
		System.out.println("user_date : " + user_date);
		System.out.println("news : " + news);
		
		UserVO param = new UserVO();
		param.setUser_email(user_email);
		param.setNickname(nickname);
		param.setUser_pw(encrypt_pw);
		param.setUser_year(user_year);
		param.setUser_month(user_month);
		param.setUser_date(user_date);
		param.setNews(news);
		
		int result = UserDAO.insUser(param);
		System.out.println("result = " + result);

		response.sendRedirect("/login");
	}

}
