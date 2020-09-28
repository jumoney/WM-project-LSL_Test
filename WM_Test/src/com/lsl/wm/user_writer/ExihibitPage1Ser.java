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
import com.lsl.wm.db.WorkDAO;
import com.lsl.wm.vo.UserVO;
import com.lsl.wm.vo.WorkVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/exhibit_page1")
public class ExihibitPage1Ser extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserVO loginUser = MyUtils.getLoginUser(request);
		List<WorkVO> list = new ArrayList();
		
		String realPath = getServletContext().getRealPath("/");
		//String savePath = realPath + "resource/user_writer/images/exhibition/" + loginUser.getI_user() + "/";
		
		list = WorkDAO.selWork(loginUser.getI_user());
		
		for(int i=0; i<list.size(); i++) {
			System.out.println(list.get(i).getWork_title());
		}
		
		request.setAttribute("list", list);
		//request.setAttribute("savePath", savePath);
		
		
		String jsp = "/WEB-INF/user_writer/exhibit_page1.jsp";
		request.getRequestDispatcher(jsp).forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserVO loginUser = MyUtils.getLoginUser(request);
		String savePath = getServletContext().getRealPath("works") + "/user/" + loginUser.getI_user(); //저장경로
		int maxFileSize = 10_485_760; //1024 * 1024 * 10 (10mb) //최대 파일 사이즈 크기
		String fileNm = "";
		String saveFileNm = null;
		
		
		
		System.out.println("savePath : " + savePath);
		
		//만약 폴더(디렉토리)가 없다면 폴더 생성
		File directory = new File(savePath);
		if(!directory.exists()) {
			directory.mkdirs();
		}
		try {
			MultipartRequest mr = new MultipartRequest(request, savePath
					, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
			
			Enumeration files = mr.getFileNames();
			
			if(files.hasMoreElements()) {
				String key = (String)files.nextElement();
				fileNm = mr.getFilesystemName(key);
				String ext = fileNm.substring(fileNm.lastIndexOf("."));
				saveFileNm = UUID.randomUUID() + ext;				
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
		if(saveFileNm != null) { //DB에 프로필 파일명 저장
			
		}
		
	
		
		
		response.sendRedirect("/exhibit_page2");
		
	
	}

}
