package com.lsl.wm.user_writer;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lsl.wm.MyUtils;
import com.lsl.wm.db.ShowDAO;
import com.lsl.wm.db.ShowListDAO;
import com.lsl.wm.db.WorkDAO;
import com.lsl.wm.vo.ShowListDomain;
import com.lsl.wm.vo.ShowVO;
import com.lsl.wm.vo.UserVO;
import com.lsl.wm.vo.WorkVO;

@WebServlet("/exhibit_page2")
public class ExihibitPage2Ser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String jsp = "/WEB-INF/user_writer/exhibit_page2.jsp";
		//로그인한 사용자 정보를 받아온다.
		UserVO loginUser = MyUtils.getLoginUser(request);
		//전시회 정보를 받아온다.
		ShowVO showParam = ShowDAO.selLatestExhibition();
		//exhibit_page1 서블릿 파일에서 넘어온 i_user, i_show값을 받는다.
		int i_user = loginUser.getI_user();
		int i_show = showParam.getI_show();
		
		System.out.println("넘어온 파라미터값:" + i_user);
		//넘어온 파라미터 값을 넣어줄 WorkVO 객체
		WorkVO vo = new WorkVO();
		
		ShowVO vo2 = new ShowVO();
		
		//값을 넣는다.
		vo.setI_user(i_user);
		vo.setI_show(i_show);
		
		vo2.setI_show(i_show);
		
		//selWorkList i_user와 i_work가 일치하는 메소드를 사용하여 작품 목록을 받늗다
		List<WorkVO> list = WorkDAO.selWorkList(vo);
		
		ShowVO param = ShowDAO.selShow(vo2);
		
		for(int i=0; i<list.size(); i++) {
			System.out.println(list.get(i).getWork_title());
		}
		//list를 jsp로 보내기 위해 담아준다.
		//작품정보
		request.setAttribute("workList", list);
		//전시회 정보
		request.setAttribute("showParam", param);
		
		request.getRequestDispatcher(jsp).forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserVO loginUser = MyUtils.getLoginUser(request);
		
		/*삭제 기능 구현부*/
		int i_show = Integer.parseInt(request.getParameter("i_show"));
		//삭제할 작품의 i_work값을 가져온다.
		int i_work = Integer.parseInt(request.getParameter("i_work"));
		int i_user = loginUser.getI_user();
		
		WorkVO param = new WorkVO();
		
		param.setI_show(i_show);
		param.setI_work(i_work);
		param.setI_user(i_user);
		
		param = WorkDAO.selWork(param);
		
		System.out.println("가져온 이미지 제목 " + param.getWork_image());
		//먼저 파일을 삭제 한다.
		String savePath = getServletContext().getRealPath("resource") + "/user_writer/images/exhibition/" + loginUser.getI_user() + "/";
		System.out.println("path : " + savePath);
		

		File f = new File(savePath + "/" + param.getWork_image());		
		if(f.exists()){
			f.delete();
			System.out.println("파일 삭제됨");
		}else{
			System.out.println("파일 없음");
		}
		
		WorkDAO.delWork(param);
		/*전시회 리스트 에서도 삭제한다.*/
		ShowListDomain vo = new ShowListDomain();
		vo.setI_work(i_work);
		
		ShowListDAO.delShowList(vo);
		
		System.out.println("넘어온 값" + i_work);
		
		response.sendRedirect("/exhibit_page2?i_user="+ i_user + "&i_show=" + i_show);
		
		
	}

}
