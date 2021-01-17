package action;

import static util.DbUtil.getConnection;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.LectureDao;
import vo.ActionForward;
import vo.Lecture;

public class LectureMakeFormAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("euc-kr");
		
		Connection con = getConnection();
		LectureDao lectureDao = new LectureDao(con);
		
		if( request.getParameter("recursive") != null ) {
			Lecture lecture = new Lecture() ;
			
			lecture.setDay(Integer.parseInt(request.getParameter("day")));
			lecture.setTime(Integer.parseInt(request.getParameter("time")));
			lecture.setClassroom(request.getParameter("classroom"));
			lecture.setTeacherId(request.getParameter("teacherId"));
			lecture.setCapacity(Integer.parseInt(request.getParameter("capacity")));
	
			lectureDao.inputLecture(lecture);
			
			if( request.getParameter("newClassroom") != null ) 
				lectureDao.inputClassroom(request.getParameter("classroom"));
		}
		
		List<Lecture> lectures = lectureDao.getAllLectures();
		List<String> classrooms = lectureDao.getAllClassrooms();
		List<String> teachers = lectureDao.getAllTeacherIds();
		request.setAttribute("lectures", lectures);
		request.setAttribute("classrooms", classrooms);
		request.setAttribute("teachers", teachers);
		
		ActionForward forward = new ActionForward();
		forward.setUrl("lectureMakeForm.jsp");
		return forward;
	}

}
