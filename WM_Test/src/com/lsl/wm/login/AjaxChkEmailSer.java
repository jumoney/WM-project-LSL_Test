package com.lsl.wm.login;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lsl.wm.db.UserDAO;
import com.lsl.wm.vo.UserVO;

@WebServlet("/ajaxemail")
public class AjaxChkEmailSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_email = request.getParameter("user_email");
		UserVO param = new UserVO();
		param.setUser_email(user_email);
		param.setUser_pw("");
		
		int result = UserDAO.login(param); // return媛믪씠 3�씠硫� �빐�떦 �땳�꽕�엫 議댁옱, 2硫� �궗�슜媛��뒫
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		out.print(result); // data 媛믪뿉 result ���엯
		
	}
}
