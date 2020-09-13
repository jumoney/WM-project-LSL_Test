package com.lsl.wm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.lsl.wm.vo.UserVO;

public class MyUtils {
	public static UserVO getLoginUser(HttpServletRequest request) {
		HttpSession hs = request.getSession();
		return (UserVO)hs.getAttribute("loginUser");
	}
}
