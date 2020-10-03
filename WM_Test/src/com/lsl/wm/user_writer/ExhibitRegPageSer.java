package com.lsl.wm.user_writer;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lsl.wm.MyUtils;
import com.lsl.wm.db.ShowDAO;
import com.lsl.wm.db.WorkDAO;
import com.lsl.wm.vo.ShowVO;
import com.lsl.wm.vo.UserVO;
import com.lsl.wm.vo.WorkVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


@WebServlet("/exhibitRegPage")
public class ExhibitRegPageSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 로그인한 사용자 정보를 받아온다.
		UserVO loginUser = MyUtils.getLoginUser(request);
		// 전시회 정보를 받아온다.
		ShowVO param = ShowDAO.selLatestExhibition();
		//수정할 작품의 i_work 값을 받아온다.
		int i_work = Integer.parseInt(request.getParameter("i_work"));
		WorkVO vo = new WorkVO();
		vo.setI_work(i_work);
		//작품정보를 가져온다.
		WorkVO workParam = WorkDAO.selWork(vo);

		String savePath = "/resource/show/images/posters/" + param.getI_show() + "/";
		String workImagePath = "/resource/user_writer/images/exhibition/" + loginUser.getI_user() + "/";

		// 전시회 정보를 보내준다.
		request.setAttribute("data", param);
		// jsp에서 출력해줄 포스터의 경로를 보내준다.
		request.setAttribute("imagePath", savePath);
		//작품정보를 보내준다.
		request.setAttribute("workData", workParam);
		//작품 경로
		request.setAttribute("workPath", workImagePath);
		
		String jsp = "/WEB-INF/user_writer/exhibitRegPage.jsp";
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
		//어느 전시회 인지
		int i_show = Integer.parseInt(mr.getParameter("i_show"));
		//어느 작품인지
		int i_work = Integer.parseInt(mr.getParameter("i_work"));
		
		
		
		
		
			WorkVO param = new WorkVO();
			String saveImageName ="";
			//만약에 그림에 수정이있다면
			if(!(mr.getParameter("work_image").equals(""))) {
				String work_image = mr.getParameter("work_image");
				
				/*기존에 파일 삭제*/
				param.setI_work(i_work);
				param = WorkDAO.selWork(param);
				
				File f = new File(savePath + "/" + param.getWork_image());		
				if(f.exists()){
					f.delete();
					System.out.println("파일 삭제됨");
				}else{
					System.out.println("파일 없음");
				}
				
				try {
					Enumeration files = mr.getFileNames();
					
					saveImageName = i_show  + "_" + loginUser.getI_user() + "_" +  work_image; 
					
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
				param.setWork_image(saveImageName);
			}
			
			String work_title = mr.getParameter("input_title");
			String work_ctnt = mr.getParameter("input_comment");
			
			
			
			param.setI_work(i_work);
			param.setI_show(i_show);
			param.setI_user(loginUser.getI_user());
			
			param.setWork_title(work_title);
			param.setWork_ctnt(work_ctnt);
			
			WorkDAO.updWork(param);
		
		
		
			System.out.println("post들어옴");
		
		
		
			
		response.sendRedirect("/exhibit_page2?i_user="+ loginUser.getI_user() + "&i_show=" + i_show);
	
	}

}
