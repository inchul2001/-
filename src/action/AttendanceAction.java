package action;

import static util.DbUtil.getConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AttendanceDao;
import dao.StudentBasicDao;
import vo.ActionForward;
import vo.Attendance;
import vo.StudentBasic;

public class AttendanceAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("euc-kr");
		
		Connection con = getConnection();
		StudentBasicDao studentBasicDao = new StudentBasicDao( con );
		AttendanceDao attendanceDao =new AttendanceDao( con ) ;
		
		if( request.getParameter("recursive") != null) {
			if( request.getParameter("recursive").equals("createNew") ) {
				Attendance inputAttendance = new Attendance();
				java.util.Date today = new java.util.Date();
				java.sql.Date attendDate = new java.sql.Date(today.getTime());
				
				java.sql.Time comeTime = null;
				java.sql.Time goTime = null;

				if( request.getParameter("comeOrGo").equals("come") ) {
					comeTime = new java.sql.Time(today.getTime());
				} else {	//request.getParameter("comeOrGo").equals("go")
					goTime = new java.sql.Time(today.getTime());
				}
				inputAttendance.setAttendDate(attendDate);
				inputAttendance.setComeTime(comeTime);
				inputAttendance.setGoTime(goTime);
				inputAttendance.setStudentId(request.getParameter("studentId"));
				
				attendanceDao.inputAttendance(inputAttendance);
			}
			if( request.getParameter("recursive").equals("modifyOld") ) {
				Attendance inputAttendance = new Attendance();
				inputAttendance.setAttendanceNum(Integer.parseInt(request.getParameter("attendanceNum")));
				
				if(request.getParameter("comeTime") != null ) {
					String rawDateString = request.getParameter("comeTime");
					String[] timeArray = rawDateString.split(":");
					Time inputTime = new Time(Integer.parseInt(timeArray[0]), Integer.parseInt(timeArray[1]), Integer.parseInt(timeArray[2]));
					inputAttendance.setComeTime(inputTime);
					
				}else {
					String rawDateString = request.getParameter("goTime");
					String[] timeArray = rawDateString.split(":");
					Time inputTime = new Time(Integer.parseInt(timeArray[0]), Integer.parseInt(timeArray[1]), Integer.parseInt(timeArray[2]));					
					inputAttendance.setGoTime(inputTime);
					
				}
				attendanceDao.modifyAtdc(inputAttendance);;
			}
		}
		
		List<StudentBasic> students = studentBasicDao.getAllStudentBasic();
		List<Attendance> attendances = attendanceDao.getAllAttendances();
		request.setAttribute("students", students);
		request.setAttribute("attendances", attendances);
		
		ActionForward forward = new ActionForward();
		forward.setUrl("attendance.jsp");
		return forward;
	}

	
}
