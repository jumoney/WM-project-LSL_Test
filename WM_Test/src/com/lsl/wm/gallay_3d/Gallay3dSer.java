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
import com.lsl.wm.vo.WorkCmtVO;
import com.lsl.wm.vo.WorkLikeDomain;
import com.lsl.wm.vo.WorkVO;


@WebServlet("/gallay/gallay3d")
public class Gallay3dSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//�α����� ����� ������ �޾ƿ´�.
		UserVO loginUser = MyUtils.getLoginUser(request);
		//����ȸ ������ �޾ƿ´�.
		ShowVO param = ShowDAO.selLatestExhibition();
		//����ȸ ��ǰ ����� �����´�.
		ShowListVO vo = new ShowListVO();
		
		vo.setI_show(param.getI_show());
		List<ShowListDomain> list = new ArrayList();
		list = ShowListDAO.selShowList(vo);
		
		String savePath2 = "/resource/user_writer/images/exhibition/";
		
		//����ȸ ��ǰ ����� �����ش�.
		request.setAttribute("workList", list);
		//jsp���� ������� �̹����� ��θ� �����ش�.
		request.setAttribute("workImagePath", savePath2);
		
		String jsp = "/WEB-INF/3d_gallay/3dGallay.jsp"; 
		request.getRequestDispatcher(jsp).forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//�α����� ����� ������ �޾ƿ´�.
		UserVO loginUser = MyUtils.getLoginUser(request);  
		// json ���·� �����ϱ� ���� json��ü ����
		 response.setContentType("application/x-json; charset=UTF-8");
	     PrintWriter out = response.getWriter();
	     //�۰������� �ҷ����� json����̶��
	     if(request.getParameter("method").equals("selI_user")) {
	    	 int i_work = Integer.parseInt(request.getParameter("i_work"));
		     //i_work������ �۰� ������ �����´�.
		     WorkVO param = new WorkVO();
		    param.setI_work(i_work); 
		    param = WorkDAO.selWork(param);
		    //���ƿ� ���� �����´�.
		    WorkLikeDomain domain = new WorkLikeDomain();
		    domain.setI_work(i_work);
		    domain = WorkLikeDAO.selWorkLikeCnt(domain);
		    //���� ���ƿ��� �׸����� ����
		    WorkLikeDomain domain2 = new WorkLikeDomain();
		    domain2.setI_user(loginUser.getI_user());
		    domain2.setI_work(i_work);
		    domain2 = WorkLikeDAO.selWorkLike(domain2);
		    
		    UserVO param2 = new UserVO();
		    param2 = UserDAO.selUser(param.getI_user());
		    
			System.out.println("���̿�ũ��:" + i_work);
			System.out.println("�г���: " + param2.getNickname());
			System.out.println("�̸���: " + param2.getUser_email());
			
			JSONObject jobj = new JSONObject();
			System.out.println("���ƿ�:" + domain2.getIsLike());
			jobj.put("nickName", param2.getNickname());
			jobj.put("user_email", param2.getUser_email());
			jobj.put("workLikeCnt", domain.getWorkLikeCnt());
			jobj.put("isLike", domain2.getIsLike());
			out.print(jobj.toJSONString()); // json �������� ���
	     }
	     //��� ����� ���� json����̶��
	     if(request.getParameter("method").equals("doAddCmt")) {
	    	 int i_work = Integer.parseInt(request.getParameter("i_work"));
	    	 String cmt = request.getParameter("cmt");
			
			WorkCmtVO vo = new WorkCmtVO();
			
			vo.setI_work(i_work);
			vo.setI_user(loginUser.getI_user());
			vo.setCmt(cmt);
			
			WorkCmtDAO.insWorkCmt(vo);
	    	 
			JSONObject jobj = new JSONObject();
			out.print(jobj.toJSONString()); // json �������� ���
	     }
	     
	   //���ƿ� ó���� ���� json����̶��
	     if(request.getParameter("method").equals("doLike")) {
	    	 int i_work = Integer.parseInt(request.getParameter("i_work"));
	    	  //���� ���ƿ��� �׸����� ����
			    WorkLikeDomain domain2 = new WorkLikeDomain();
			    domain2.setI_user(loginUser.getI_user());
			    domain2.setI_work(i_work);
			    domain2 = WorkLikeDAO.selWorkLike(domain2);
			    if(domain2.getIsLike() != 0) {
			    	WorkLikeDAO.delWorkLike(domain2);
			    }else {
			    	WorkLikeDAO.insWorkLike(domain2);
			    }
			    //�ٽ� ���ƿ� ���θ� �޾ƿ´�.
			    domain2 = WorkLikeDAO.selWorkLike(domain2);
		    //���ƿ� ���� �����´�.
		    WorkLikeDomain domain = new WorkLikeDomain();
		    domain.setI_work(i_work);
		    domain = WorkLikeDAO.selWorkLikeCnt(domain);
		    
		    System.out.println("------------doLike------------");
			System.out.println("���̿�ũ��:" + i_work);
			System.out.println("���ƿ俩��:" + domain2.getIsLike());
			System.out.println("���ƿ䰳��:" + domain2.getIsLike());
			
			
			JSONObject jobj = new JSONObject();
			jobj.put("workLikeCnt", domain.getWorkLikeCnt());
			jobj.put("isLike", domain2.getIsLike());
			out.print(jobj.toJSONString()); // json �������� ���
	     }
	     
	    
		
	    // ����� json Ÿ���̶�� �� ��� ( �����ָ� json Ÿ������ �ν����� ���� )

		
		
	}
}