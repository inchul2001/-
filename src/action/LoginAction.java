package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AttendanceDao;
import dao.IndivScoreDao;
import dao.LectureDao;
import dao.StudentBasicDao;
import dao.TeacherDao;
import util.MyDebug;
import vo.ActionForward;
import vo.Attendance;
import vo.AttendanceStatus;
import vo.Lecture;
import vo.StudentBasic;
import vo.Sugang;
import vo.Teacher;
import vo.TestInfo;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.*;


import static util.DbUtil.close;
import static util.DbUtil.commit;
import static util.DbUtil.getConnection;
import static util.DbUtil.rollback;


public class LoginAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("euc-kr");
		
		String id ;
		String passwd ="";
		if(( request.getParameter("inputid") != null) && (request.getParameter("inputpassword") != null )) {
			id = request.getParameter("inputid");
			passwd = request.getParameter("inputpassword");
		} else {
			id = request.getParameter("studentId");
		}
		
		ActionForward forward = new ActionForward();

		if( id.equals("admin") && passwd.equals("1234") ) {
			forward.setUrl("adminMain.jsp");										//원장님 로그인
		}
		
		else {																		//그게 아니라면 학생회원일 것인데
			Connection con = getConnection();										//DB에 연결해서
			StudentBasicDao studentBasicDao = new StudentBasicDao(con);				//DAO부르고
			StudentBasic studentBasic = studentBasicDao.getStudentBasicById(id);	//아이디로 학생 찾아서
			
			if( studentBasic.getStudentPassword().equals(passwd) || request.getParameter("recursive") != null) {					//비밀번호 확인후 맞다면 필요한 정보를 전달한다.
				
				IndivScoreDao indivScoreDao = new IndivScoreDao( con ) ;
				List<TestInfo> testInfos = indivScoreDao.getAllTestInfoByStudentId(id);
				request.setAttribute("testInfos", testInfos);						//이로서 시험과 관련된 모든 값을 넘겨주엇다.
//========================================================================================================				
				LectureDao lectureDao = new LectureDao( con ) ;
				List<Lecture> lectures = lectureDao.getAllSugangLectureByStudentId(id);
				
				int[][] scheduleOfWeek = {{14, 14, 14, 14, 14, 14, 14},{0, 0, 0, 0, 0, 0, 0}};
				for( int i = 0 ; i < lectures.size() ; i++ ) {
					int targetDay = lectures.get(i).getDay();
					int time = lectures.get(i).getTime();
					if( scheduleOfWeek[0][targetDay] > time )
						scheduleOfWeek[0][targetDay] = time ;						//윗줄에는 와야하는 최대시각을 표시해주고
					if( scheduleOfWeek[1][targetDay] < time )
						scheduleOfWeek[1][targetDay] = time ;						//아랫줄에는 가야하는 최소시각을 표시해주자.	
				}																	//이걸로 매주 출첵 판단 기준 배열 완성.
				
				List<AttendanceStatus> atdcStats = new ArrayList<AttendanceStatus>();
				java.util.Date javaToday = new java.util.Date();
				java.sql.Date sqlDate = new java.sql.Date(javaToday.getTime());		//오늘 날짜를 구하고.
/*				
				for( int i = 0 ; i < 90 ; i++ ) {									//오늘 포함해서 이전 90일 간의 AttendanceStatus를 만들자.
					* 기존 = 오늘 포함해서 이전 90일
					 * 수정본 = 이번달, 저번달, 저저번달
					 * 
					 * 
					 */
				sqlDate.setMonth(sqlDate.getMonth()+1);
				sqlDate.setDate(0);									//이번달 말일이 sqlDate에 저장될 것이고,
				
				
				for( int i = 0 ; i < 92 ; i++) {
					AttendanceStatus atdcStat = new AttendanceStatus();
					atdcStat.setDate(sqlDate);
					int dotw = sqlDate.getDay(); //dotw = day of the week , 요일
					atdcStat.setDay(dotw);
					atdcStat.pseudoSetShouldComeTime(scheduleOfWeek[0][dotw]);
					atdcStat.pseudoSetShouldGoTime(scheduleOfWeek[1][dotw]);		//set을 네개 해줬다. Date, day, shouldComeTime, shouldGoTime
					
					atdcStats.add(atdcStat);
					
					sqlDate.setDate(sqlDate.getDate()-1);
				}
				
				
				for( int i = 0 ; i < atdcStats.size() ; i++) {						//아까 만든 90일간의 AttendanceStatus에서 아직 set이 안된 두개의 멤버변수를 set해주자...
					AttendanceDao attendanceDao = new AttendanceDao( con ) ;
					List<Attendance> atdcs = null;
					
					atdcs = attendanceDao.getComeTimeATDSOfTheDate(id, atdcStats.get(i).getDate());	//해당 날짜의
					for( int j = 0 ; j < atdcs.size() ; j++ ) 
						atdcStats.get(i).pseudoSetEarlyComeTime(atdcs.get(j).getComeTime());		//온 시간중 가장 빠른것을 따로 저장하고,
					
					atdcs = attendanceDao.getGoTimeATDSOfTheDate(id, atdcStats.get(i).getDate());
					for( int j = 0 ; j < atdcs.size() ; j++ ) 
						atdcStats.get(i).pseudoSetLateGoTime(atdcs.get(j).getGoTime());				//간 시간중 가장 늦은것을 따로 자장하고,
					
					atdcs = attendanceDao.getATDSOfTheDate(id, atdcStats.get(i).getDate());		
					atdcStats.get(i).setAtdcOfTheDay(atdcs);										//사실은 오고 간 모든 기록도 저장하고!
				}																	//이로서 나머지 set도 끝났다.
				
				request.setAttribute("attendanceStatuses", atdcStats);
				
//========================================================================================================				
				if( request.getParameter("recursive") != null ) {
					if( request.getParameter("recursive").equals("fromStudentSelfModify") ) {
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
					
					if( request.getParameter("recursive").equals("fromSugangSincheong") ) {
						String studentId = request.getParameter("studentId");
						String lectureId = request.getParameter("lectureId");
						System.out.println( "studentId : " + studentId +  "lectureId : "+lectureId);
						Sugang inputSugang = new Sugang();
						inputSugang.setStudentId(studentId);
						inputSugang.setLectureId(Integer.parseInt(lectureId) );
						
						lectureDao.inputSugang(inputSugang);
					}
				}
				studentBasic = studentBasicDao.getStudentBasicById(id);				//55줄에 있는 이걸 지금 다시 해야한다.
				request.setAttribute("studentBasic", studentBasic); 				//개인정보 전달완료.
				
				TeacherDao teacherDao = new TeacherDao( con ) ;
				List<Teacher> teachers = teacherDao.getAllTeachers();
				request.setAttribute("teachers", teachers);
				
				List<Lecture> allLectures = lectureDao.getAllLectures();
				request.setAttribute("lectures", allLectures);
				
				forward.setUrl("studentMain.jsp");
				
			}
			else
				forward.setUrl("login.jsp");
		}
		return forward;
	}

}
