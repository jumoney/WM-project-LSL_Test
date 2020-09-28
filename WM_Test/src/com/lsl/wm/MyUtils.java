package com.lsl.wm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.lsl.wm.vo.UserVO;

public class MyUtils {
	public static UserVO getLoginUser(HttpServletRequest request) {
		HttpSession hs = request.getSession();
		return (UserVO)hs.getAttribute("loginUser"); // 로그인 서블릿에서 doGet메소드에서 호출하면 doPost에서 set된 세션을 가져옴
	}
}
