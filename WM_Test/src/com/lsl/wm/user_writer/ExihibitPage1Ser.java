package com.lsl.wm.user_writer;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lsl.wm.MyUtils;
import com.lsl.wm.db.ShowDAO;
import com.lsl.wm.db.ShowListDAO;
import com.lsl.wm.db.WorkDAO;
import com.lsl.wm.vo.ShowListVO;
import com.lsl.wm.vo.ShowVO;
import com.lsl.wm.vo.UserVO;
import com.lsl.wm.vo.WorkVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/exhibit_page1")
public class ExihibitPage1Ser extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//로그인한 사용자 정보를 받아온다.
		UserVO loginUser = MyUtils.getLoginUser(request);
		//전시회 정보를 받아온다.
		ShowVO param = ShowDAO.selLatestExhibition();
		
		String savePath = "/resource/show/images/posters/" + param.getI_show() + "/";
		
		//전시회 정보를 보내준다.
		request.setAttribute("data", param);
		//jsp에서 출력해줄 포스터의 경로를 보내준다.
		request.setAttribute("imagePath", savePath);
		
		String jsp = "/WEB-INF/user_writer/exhibit_page1.jsp";
		request.getRequestDispatcher(jsp).forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserVO loginUser = MyUtils.getLoginUser(request);
		//저장경로 지정
		String savePath = getServletContext().getRealPath("resource") + "/user_writer/images/exhibition/" + loginUser.getI_user() + "/";

		//만약 폴더(디렉토리)가 없다면 폴더 생성
		File directory = new File(savePath);
		if(!directory.exists()) {
			directory.mkdirs();
		}
		
		int maxFileSize = 10_485_760; //1024 * 1024 * 10 (10mb) //최대 파일 사이즈 크기
		String fileNm = "";
		String saveFileNm = null;
		
		//여러 파일을 받기 위해 멀티 리퀘스트 객체 선언 일반 request도 이걸로 받아야한다.
		MultipartRequest mr = new MultipartRequest(request, savePath
				, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
		
		/*jsp로 부터 작품 정보를 받아온다.*/
		//리스트가 몇개 인지
		int list_cnt = Integer.parseInt(mr.getParameter("list_cnt"));
		//어느 전시회 인지
		int i_show = Integer.parseInt(mr.getParameter("i_show"));
		
		//폼에서 넘어온 정보를 DB의 t_work에 넣어준다
		for(int i=0; i<list_cnt; i++) {
			String work_image = mr.getParameter("work_image_idx_" + i);
			String work_title = mr.getParameter("input_title_" + i);
			String work_ctnt = mr.getParameter("input_comment_" + i);
			//실제 저장될 파일 이름 (전시회idx_유저idx_파일명) 위에 work_iamge는 파일명만 받아온 것이다.
			String saveImageName = i_show  + "_" + loginUser.getI_user() + "_" +  work_image; 
			
			WorkVO param = new WorkVO();
			param.setI_show(i_show);
			param.setI_user(loginUser.getI_user());
			param.setWork_image(saveImageName);
			param.setWork_title(work_title);
			param.setWork_ctnt(work_ctnt);
			
			WorkDAO.insWork(param);
			param.setI_user(loginUser.getI_user());
			//가장 최근에 들어간 i_work값을 가져온다.
			param = WorkDAO.selLatestWork(param);
			//넘어온 정보를 전시회 리스트(t_show_list)에 널어준다.
			ShowListVO vo2 = new ShowListVO(); 
			vo2.setI_show(i_show);
			vo2.setI_work(param.getI_work());
			System.out.println(param.getI_work());
			ShowListDAO.insShowList(vo2);
		}
		
		
		
		System.out.println("savePath : " + savePath);
		
		try {
			Enumeration files = mr.getFileNames();
			
			while(files.hasMoreElements()) {
				String key = (String)files.nextElement();
				fileNm = mr.getFilesystemName(key);
				String ext = fileNm.substring(fileNm.lastIndexOf("."));
				saveFileNm = i_show  + "_" + loginUser.getI_user() + "_" + fileNm;				
				System.out.println("key : " + key);
				System.out.println("fileNm : " + fileNm);
				System.out.println("saveFileNm : " + saveFileNm);				
				File oldFile = new File(savePath + "/" + fileNm);
			    File newFile = new File(savePath + "/" + saveFileNm);
			    oldFile.renameTo(newFile);				  
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
			
		response.sendRedirect("/exhibit_page2");
	
	}

}
