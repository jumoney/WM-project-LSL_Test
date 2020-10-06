package com.lsl.wm.user_writer;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lsl.wm.MyUtils;
import com.lsl.wm.db.UserDAO;
import com.lsl.wm.vo.UserVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


@WebServlet("/profile")
public class ChangeProfileSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserVO loginUser = MyUtils.getLoginUser(request);
		
		String savePath = getServletContext().getRealPath("img") + "/user/" + loginUser.getI_user();
		
		
		System.out.println("savePath : " + savePath);
		// 디렉토리 폴더가 없으면 생성
		File directory = new File(savePath);
		if(!directory.exists()) {
			directory.mkdirs();
		}
		
		int maxFileSize = 10_485_760; //1024 * 1024 * 10 (10mb) //최대 파일 사이즈 크기
		String fileNm = "";
		String saveFileNm = null;
		
		try {
			MultipartRequest mr = new MultipartRequest(request, savePath, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
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
			UserVO param = new UserVO();
			param.setProfile_img(saveFileNm);
			param.setI_user(loginUser.getI_user());
			UserDAO.updUser(param);
		}
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out=response.getWriter();
		
		out.println("<script language='javascript'>");
		out.println("alert('프로필이미지가 변경되었습니다.'); location.href='/writer/mypage_profile'"); // 서블릿에서 script 태그 사용
		out.println("</script>");
		out.flush();
	}

}
