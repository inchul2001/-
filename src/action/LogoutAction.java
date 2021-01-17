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

public class LogoutAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("euc-kr");
		
		request.setAttribute("logout", "true");
		
		
		ActionForward forward = new ActionForward();
		forward.setUrl("login.jsp");
		return forward;
	}

}
