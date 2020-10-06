package com.lsl.wm.user_writer;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lsl.wm.MyUtils;
import com.lsl.wm.db.UserDAO;
import com.lsl.wm.vo.UserVO;

@WebServlet("/changeNickname")
public class ChangeNicknameSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserVO loginUser = MyUtils.getLoginUser(request);
		
		String nickname = request.getParameter("nickname");
		
		UserVO param = new UserVO();
		param.setI_user(loginUser.getI_user());
		param.setNickname(nickname);
		
		UserDAO.updUser(param);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out=response.getWriter();
		
		out.println("<script language='javascript'>");
		out.println("alert('닉네임이 변경되었습니다. 로그아웃 됩니다.'); location.href='/logout'"); // 서블릿에서 script 태그 사용
		out.println("</script>");
		out.flush();
	}

}
