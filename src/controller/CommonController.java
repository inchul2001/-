package controller;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import vo.ActionForward;
import action.*;
@WebServlet("*.common")

public class CommonController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public CommonController() {
        super();
        // TODO Auto-generated constructor stub
    }
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
    	String requestURI = request.getRequestURI();
    	System.out.println("RequestURI :"+ requestURI);
    	// /project/boardWriteForm.bo
    	String contextPath = request.getContextPath();
    	// /project
    	String command = 
        requestURI.substring(contextPath.length());
    	//  /boardWriteForm.bo
    	
    	Action action = null;
    	 //�� Action ��ü ���� ������ �����ϰ� �ִ� �������̽�.
    	//��û�� ó���� �� �ش� ��û�� ó���� Action ��ü���� �ϳ��� �����ؼ�
    	//�ش� ��ü�� Action �������̽��� ���۷��� ������ ������

    	
    	ActionForward forward = null;

    	if( command.equals("/pageCommon/login.common") || command.equals("//pageCommon/login.common") ) {
        	System.out.println("Controller:command: "+command);
    		action = new LoginAction();
    		try {
    			forward = action.execute(request, response);
    		}catch(Exception e){
    			e.printStackTrace();
    		}
    	}    
    	
    	if( command.equals("/pageCommon/signup.common") ||  command.equals("//pageCommon/signup.common")) {
        	System.out.println("Controller:command: "+command);

    		action = new SignupAction();
    		try {
    			forward = action.execute(request, response);
    		}catch(Exception e){
    			e.printStackTrace();
    		}
    	}

    	if( command.equals("/pageCommon/studentBasicManage.common") ||  command.equals("//pageCommon/studentBasicManage.common")) {
    		System.out.println("Controller:command: "+command);
    		
    		action = new StudentBasicManageAction();
    		try {
    			forward = action.execute(request, response);
    		}catch(Exception e){
    			e.printStackTrace();
    		}
    	}
    	
    	if( command.equals("/pageCommon/teacherManage.common") ||  command.equals("//pageCommon/teacherManage.common")) {
        	System.out.println("Controller:command: "+command);

    		action = new TeacherManageAction();
    		try {
    			forward = action.execute(request, response);
    		}catch(Exception e){
    			e.printStackTrace();
    		}
    	}
    	    	
    	if( command.equals("/pageCommon/testUpload.common") ||  command.equals("//pageCommon/testUpload.common")) {
    		System.out.println("Controller:command: "+command);
    		
    		action = new TestUploadAction();
    		try {
    			forward = action.execute(request, response);
    		}catch(Exception e){
    			e.printStackTrace();
    		}
    	}
    	
    	if( command.equals("/pageCommon/lectureMakeForm.common") ||  command.equals("//pageCommon/lectureMakeForm.common")) {
    		System.out.println("Controller:command: "+command);
    		
    		action = new LectureMakeFormAction();
    		try {
    			forward = action.execute(request, response);
    		}catch(Exception e){
    			e.printStackTrace();
    		}
    	}
 
    	if( command.equals("/pageCommon/indivScoreInputForm.common") || command.equals("//pageCommon/indivScoreInputForm.common")) {
    		System.out.println("Controller:command: "+command);
    		
    		action = new IndivScoreInputFormAction();
    		try {
    			forward = action.execute(request, response);
    		}catch(Exception e){
    			e.printStackTrace();
    		}
    	}
    	
    	if( command.equals("/pageCommon/attendance.common") ||  command.equals("//pageCommon/attendance.common")) {
    		System.out.println("Controller:command: "+command);
    		
    		action = new AttendanceAction();
    		try {
    			forward = action.execute(request, response);
    		}catch(Exception e){
    			e.printStackTrace();
    		}
    	}
    	if( command.equals("/pageCommon/toHome.common") ) {
    		System.out.println("Controller:command: "+command);
    		
    		action = new ToHomeAction();
    		try {
    			forward = action.execute(request, response);
    		}catch(Exception e){
    			e.printStackTrace();
    		}
    	}
    	if( command.equals("/pageCommon/logout.common") ) {
    		System.out.println("Controller:command: "+command);
    		
    		action = new LogoutAction();
    		try {
    			forward = action.execute(request, response);
    		}catch(Exception e){
    			e.printStackTrace();
    		}
    	}
  	
    	if(forward != null){					//�̳��� �����尪�� ������ ������ �����ִ� ������ �ϴ°� ������.,
    		System.out.println("forwardURL : "+forward.getUrl());
    		if(forward.isRedirect()){
    			response.sendRedirect(forward.getUrl());
    		}
    		else{
    			RequestDispatcher dispatcher
    			= request.getRequestDispatcher(forward.getUrl());
    			dispatcher.forward(request, response);
    		}
    	}
    	
    	
    	
    	
	}
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(request, response);
	}
}
