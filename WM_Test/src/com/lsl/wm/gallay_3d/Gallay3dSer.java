package com.lsl.wm.gallay_3d;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.lsl.wm.MyUtils;
import com.lsl.wm.db.ShowDAO;
import com.lsl.wm.db.ShowListDAO;
import com.lsl.wm.db.UserDAO;
import com.lsl.wm.db.WorkCmtDAO;
import com.lsl.wm.db.WorkDAO;
import com.lsl.wm.db.WorkLikeDAO;
import com.lsl.wm.vo.ShowListDomain;
import com.lsl.wm.vo.ShowListVO;
import com.lsl.wm.vo.ShowVO;
import com.lsl.wm.vo.UserVO;
import com.lsl.wm.vo.WorkCmtDomain;
import com.lsl.wm.vo.WorkCmtVO;
import com.lsl.wm.vo.WorkLikeDomain;
import com.lsl.wm.vo.WorkVO;


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
		//로그인한 사용자 정보를 받아온다.
		UserVO loginUser = MyUtils.getLoginUser(request);  
		// json 형태로 리턴하기 위한 json객체 생성
		 response.setContentType("application/x-json; charset=UTF-8");
	     PrintWriter out = response.getWriter();
	     //작가정보를 불러오는 json통싱이라면
	     if(request.getParameter("method").equals("selI_user")) {
	    	 int i_work = Integer.parseInt(request.getParameter("i_work"));
		     //i_work값으로 작가 정보를 가져온다.
		     WorkVO param = new WorkVO();
		    param.setI_work(i_work); 
		    param = WorkDAO.selWork(param);
		    //좋아요 수를 가져온다.
		    WorkLikeDomain domain = new WorkLikeDomain();
		    domain.setI_work(i_work);
		    domain = WorkLikeDAO.selWorkLikeCnt(domain);
		    //내가 좋아요한 그림인지 여부
		    WorkLikeDomain domain2 = new WorkLikeDomain();
		    domain2.setI_user(loginUser.getI_user());
		    domain2.setI_work(i_work);
		    domain2 = WorkLikeDAO.selWorkLike(domain2);
		    
		    UserVO param2 = new UserVO();
		    param2 = UserDAO.selUser(param.getI_user());
		    
			System.out.println("아이워크값:" + i_work);
			System.out.println("닉네임: " + param2.getNickname());
			System.out.println("이메일: " + param2.getUser_email());
			
			JSONObject jobj = new JSONObject();
			System.out.println("좋아요:" + domain2.getIsLike());
			jobj.put("nickName", param2.getNickname());
			jobj.put("user_email", param2.getUser_email());
			jobj.put("workLikeCnt", domain.getWorkLikeCnt());
			jobj.put("isLike", domain2.getIsLike());
			jobj.put("profilePath", "/img/user/" + param.getI_user() + "/" + param2.getProfile_img());
			out.print(jobj.toJSONString()); // json 형식으로 출력
	     }
	     
	     //댓글 등록을 위한 json통신이라면
	     if(request.getParameter("method").equals("doAddCmt")) {
	    	 int i_work = Integer.parseInt(request.getParameter("i_work"));
	    	 String cmt = request.getParameter("cmt");
			
			WorkCmtVO vo = new WorkCmtVO();
			
			vo.setI_work(i_work);
			vo.setI_user(loginUser.getI_user());
			vo.setCmt(cmt);
			
			WorkCmtDAO.insWorkCmt(vo);
			
			//댓글 리스트를 받아온다.
			List<WorkCmtDomain> list = new ArrayList();
			vo.setI_work(i_work);
			list = WorkCmtDAO.selWorkCmtList(vo);
			
			//리스트를 보내기 위해 Gson라이브러리를 활용
			String gson = new Gson().toJson(list);
	    	 
            try {
                //ajax로 리턴해주는 부분
                response.getWriter().write(gson);
            } catch (JsonIOException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
	     }
	     
	   //댓글을 불러오기 위한 json통신이라면
	     if(request.getParameter("method").equals("doReadCmt")) {
	    	 int i_work = Integer.parseInt(request.getParameter("i_work"));
	    	 	
			WorkCmtVO vo = new WorkCmtVO();
			
			//댓글 리스트를 받아온다.
			List<WorkCmtDomain> list = new ArrayList();
			vo.setI_work(i_work);
			list = WorkCmtDAO.selWorkCmtList(vo);
			
			//리스트를 보내기 위해 Gson라이브러리를 활용
			String gson = new Gson().toJson(list);
	    	 
            try {
                //ajax로 리턴해주는 부분
                response.getWriter().write(gson);
            } catch (JsonIOException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
	     }
	     
	   //좋아요 처리를 위한 json통신이라면
	     if(request.getParameter("method").equals("doLike")) {
	    	 int i_work = Integer.parseInt(request.getParameter("i_work"));
	    	  //내가 좋아요한 그림인지 여부
			    WorkLikeDomain domain2 = new WorkLikeDomain();
			    domain2.setI_user(loginUser.getI_user());
			    domain2.setI_work(i_work);
			    domain2 = WorkLikeDAO.selWorkLike(domain2);
			    if(domain2.getIsLike() != 0) {
			    	WorkLikeDAO.delWorkLike(domain2);
			    }else {
			    	WorkLikeDAO.insWorkLike(domain2);
			    }
			    //다시 좋아요 여부를 받아온다.
			    domain2 = WorkLikeDAO.selWorkLike(domain2);
		    //좋아요 수를 가져온다.
		    WorkLikeDomain domain = new WorkLikeDomain();
		    domain.setI_work(i_work);
		    domain = WorkLikeDAO.selWorkLikeCnt(domain);
		    
		    System.out.println("------------doLike------------");
			System.out.println("아이워크값:" + i_work);
			System.out.println("좋아요여부:" + domain2.getIsLike());
			System.out.println("좋아요개수:" + domain2.getIsLike());

			JSONObject jobj = new JSONObject();
			jobj.put("workLikeCnt", domain.getWorkLikeCnt());
			jobj.put("isLike", domain2.getIsLike());
			out.print(jobj.toJSONString()); // json 형식으로 출력
	     }
	     
	    
		
	    // 응답시 json 타입이라는 걸 명시 ( 안해주면 json 타입으로 인식하지 못함 )

		
		
	}
}