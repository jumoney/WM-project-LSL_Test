package com.lsl.wm.vo;

public class UserVO {
	private int i_user;
	private String user_email; // 이메일
	private String nickname; // 닉네임
	private String user_pw; // 로그인 비밀번호
	private String user_year; // 년
	private String user_month; // 월
	private String user_date; // 일
	private String news; // 소식여부
	
	
	public int getI_user() {
		return i_user;
	}
	public void setI_user(int i_user) {
		this.i_user = i_user;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_year() {
		return user_year;
	}
	public void setUser_year(String user_year) {
		this.user_year = user_year;
	}
	public String getUser_month() {
		return user_month;
	}
	public void setUser_month(String user_month) {
		this.user_month = user_month;
	}
	public String getUser_date() {
		return user_date;
	}
	public void setUser_date(String user_date) {
		this.user_date = user_date;
	}
	public String getNews() {
		return news;
	}
	public void setNews(String news) {
		this.news = news;
	}
	
}
