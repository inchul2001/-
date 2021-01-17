package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.StudentBasicDao;
import util.MyDebug;
import vo.ActionForward;
import vo.StudentBasic;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.*;


import static util.DbUtil.close;
import static util.DbUtil.commit;
import static util.DbUtil.getConnection;
import static util.DbUtil.rollback;

public class SignupAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("euc-kr");

		StudentBasic student = new StudentBasic();
		
		student.setStudentAge(Integer.parseInt(request.getParameter("studentAge")));
		student.setStudentId(request.getParameter("studentId"));
		student.setStudentMotherPhone(request.getParameter("studentMotherPhone"));
		student.setStudentName(request.getParameter("studentName"));
		student.setStudentPassword(request.getParameter("studentPassword"));
		student.setStudentPhone(request.getParameter("studentPhone"));
		student.setStudentSchool(request.getParameter("studentSchool"));
		
		Connection con = getConnection();//DB에 연결해서
		StudentBasicDao studentBasicDao = new StudentBasicDao(con);//DAO부르고
		studentBasicDao.inputStudentBasic(student);
		
		ActionForward forward = new ActionForward();
		forward.setUrl("login.jsp");
		return forward;
	}

}
