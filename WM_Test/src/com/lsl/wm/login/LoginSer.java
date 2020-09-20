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
			response.sendRedirect("/main"); // 濡쒓렇�씤�쓣 �뻽�뒗�뜲 login�솕硫댁쑝濡� 媛��젮怨� �븷�븣
		} else { // 濡쒓렇�씤�쓣 �븯吏� 紐삵뻽�쓣 �븣 �떎�떆 濡쒓렇�씤�럹�씠吏�濡� �씠�룞
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
		
		if(result != 1) {
			String msg = null;
			switch(result) {
			case 2:
				msg = "鍮꾨�踰덊샇瑜� �솗�씤�빐 二쇱꽭�슂";
				break;
			case 3:
				msg = "�븘�씠�뵒瑜� �솗�씤�빐 二쇱꽭�슂";
				break;
			default :
				msg = "�뿉�윭媛� 諛쒖깮�븯���뒿�땲�떎.";
			}
			request.setAttribute("user_email", user_email);
			request.setAttribute("msg", msg);
			doGet(request, response);
			return;
		}
		HttpSession hs = request.getSession();
		hs.setAttribute("loginUser", param); // �꽭�뀡�뿉 UserDAO�뿉�꽌 param�뿉 set�븳 �뼐�뱾�쓣 �꽭�뀡�뿉 set
		
		response.sendRedirect("/main"); // 濡쒓렇�씤 �꽦怨듭떆 諛붾줈 main�럹�씠吏�濡� �씠�룞
		
	}

}
