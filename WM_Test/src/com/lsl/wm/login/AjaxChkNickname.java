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

@WebServlet("/ajaxnickname")
public class AjaxChkNickname extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nickname = request.getParameter("nickname");
		UserVO param = new UserVO();
		param.setNickname(nickname);
		
		int result = UserDAO.nickNameChk(param); // return媛믪씠 0�씠硫� �빐�떦 �땳�꽕�엫 議댁옱, 1�씠硫� �궗�슜 媛��뒫
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		out.print(result);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
