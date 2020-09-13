package com.lsl.wm.login;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lsl.wm.MyUtils;
import com.lsl.wm.SecurityUtils;
import com.lsl.wm.db.UserDAO;
import com.lsl.wm.vo.UserVO;

@WebServlet("/login")
public class LoginSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserVO loginUser = MyUtils.getLoginUser(request);
		
		if(loginUser != null) {
			response.sendRedirect("/main");
		} else {
			String jsp = "/WEB-INF/login/login.jsp";	
			request.getRequestDispatcher(jsp).forward(request, response);			
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_email = request.getParameter("user_email");
		String user_pw = request.getParameter("user_pw");
		String encrypt_pw = SecurityUtils.encryptString(user_pw);
		
		UserVO param = new UserVO();
		param.setUser_email(user_email);
		param.setUser_pw(encrypt_pw);
		
		int result = UserDAO.login(param);
		
		HttpSession hs = request.getSession();
		hs.setAttribute("loginUser", param);
		
		if(result == 1) {
			response.sendRedirect("/main");
			return;
		}
		
		if(result != 1) {
			String msg = null;
			switch(result) {
			case 2:
				msg = "비밀번호를 확인해 주세요";
				break;
			case 3:
				msg = "아이디를 확인해 주세요";
				break;
			default :
				msg = "에러가 발생하였습니다.";
			}
			request.setAttribute("user_email", user_email);
			request.setAttribute("msg", msg);
			doGet(request, response);
			return;
		}
		
		
	}

}
