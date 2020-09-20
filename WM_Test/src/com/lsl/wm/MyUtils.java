package com.lsl.wm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.lsl.wm.vo.UserVO;

public class MyUtils {
	public static UserVO getLoginUser(HttpServletRequest request) {
		HttpSession hs = request.getSession();
		return (UserVO)hs.getAttribute("loginUser"); // 濡쒓렇�씤 �꽌釉붾┸�뿉�꽌 doGet硫붿냼�뱶�뿉�꽌 �샇異쒗븯硫� doPost�뿉�꽌 set�맂 �꽭�뀡�쓣 媛��졇�샂
	}
}
