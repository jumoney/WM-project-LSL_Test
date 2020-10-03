package com.lsl.wm.gallay_3d;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lsl.wm.MyUtils;
import com.lsl.wm.db.ShowDAO;
import com.lsl.wm.db.ShowListDAO;
import com.lsl.wm.vo.ShowListDomain;
import com.lsl.wm.vo.ShowListVO;
import com.lsl.wm.vo.ShowVO;
import com.lsl.wm.vo.UserVO;


@WebServlet("/gallay/gallay3d")
public class Gallay3dSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//로그인한 사용자 정보를 받아온다.
		UserVO loginUser = MyUtils.getLoginUser(request);
		//전시회 정보를 받아온다.
		ShowVO param = ShowDAO.selLatestExhibition();
		//전시회 작품 목록을 가져온다.
		ShowListVO vo = new ShowListVO();
		
		vo.setI_show(param.getI_show());
		List<ShowListDomain> list = new ArrayList();
		list = ShowListDAO.selShowList(vo);
		
		String savePath2 = "/resource/user_writer/images/exhibition/";
		
		//전시회 작품 목록을 보내준다.
		request.setAttribute("workList", list);
		//jsp에서 출력해줄 이미지의 경로를 보내준다.
		request.setAttribute("workImagePath", savePath2);
		
		String jsp = "/WEB-INF/3d_gallay/3dGallay.jsp"; 
		request.getRequestDispatcher(jsp).forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}