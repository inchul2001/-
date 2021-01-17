package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import java.sql.Connection;
import java.util.*;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ActionForward;
import vo.StudentBasic;
import vo.Teacher;
import vo.TestMetaData;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.StudentBasicDao;
import dao.TeacherDao;
import dao.TestDao;

import static util.DbUtil.close;
import static util.DbUtil.commit;
import static util.DbUtil.getConnection;
import static util.DbUtil.rollback;
import vo.ActionForward;

public class StudentBasicManageAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("euc-kr");
		
		Connection con = getConnection();
		StudentBasicDao studentBasicDao = new StudentBasicDao( con );
		if( request.getParameter("recursive") != null ) {
			StudentBasic student = new StudentBasic();
			student.setStudentId(request.getParameter("studentId"));
			student.setStudentPassword(request.getParameter("studentPassword"));
			student.setStudentName(request.getParameter("studentName"));
			student.setStudentAge(Integer.parseInt(request.getParameter("studentAge") ) );
			student.setStudentSchool(request.getParameter("studentSchool"));
			student.setStudentPhone(request.getParameter("studentPhone"));
			student.setStudentMotherPhone(request.getParameter("studentMotherPhone"));
			
			studentBasicDao.modifyStudentBasic(student);
		}
		List<StudentBasic> students = studentBasicDao.getAllStudentBasic();
		request.setAttribute("students", students);

		ActionForward forward = new ActionForward();
		forward.setUrl("adminStudentBasicInfoManage.jsp");
		return forward;
	}

}
