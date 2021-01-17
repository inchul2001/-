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
			forward.setUrl("adminMain.jsp");										//����� �α���
		}
		
		else {																		//�װ� �ƴ϶�� �л�ȸ���� ���ε�
			Connection con = getConnection();										//DB�� �����ؼ�
			StudentBasicDao studentBasicDao = new StudentBasicDao(con);				//DAO�θ���
			StudentBasic studentBasic = studentBasicDao.getStudentBasicById(id);	//���̵�� �л� ã�Ƽ�
			
			if( studentBasic.getStudentPassword().equals(passwd) || request.getParameter("recursive") != null) {					//��й�ȣ Ȯ���� �´ٸ� �ʿ��� ������ �����Ѵ�.
				
				IndivScoreDao indivScoreDao = new IndivScoreDao( con ) ;
				List<TestInfo> testInfos = indivScoreDao.getAllTestInfoByStudentId(id);
				request.setAttribute("testInfos", testInfos);						//�̷μ� ����� ���õ� ��� ���� �Ѱ��־���.
//========================================================================================================				
				LectureDao lectureDao = new LectureDao( con ) ;
				List<Lecture> lectures = lectureDao.getAllSugangLectureByStudentId(id);
				
				int[][] scheduleOfWeek = {{14, 14, 14, 14, 14, 14, 14},{0, 0, 0, 0, 0, 0, 0}};
				for( int i = 0 ; i < lectures.size() ; i++ ) {
					int targetDay = lectures.get(i).getDay();
					int time = lectures.get(i).getTime();
					if( scheduleOfWeek[0][targetDay] > time )
						scheduleOfWeek[0][targetDay] = time ;						//���ٿ��� �;��ϴ� �ִ�ð��� ǥ�����ְ�
					if( scheduleOfWeek[1][targetDay] < time )
						scheduleOfWeek[1][targetDay] = time ;						//�Ʒ��ٿ��� �����ϴ� �ּҽð��� ǥ��������.	
				}																	//�̰ɷ� ���� ��ý �Ǵ� ���� �迭 �ϼ�.
				
				List<AttendanceStatus> atdcStats = new ArrayList<AttendanceStatus>();
				java.util.Date javaToday = new java.util.Date();
				java.sql.Date sqlDate = new java.sql.Date(javaToday.getTime());		//���� ��¥�� ���ϰ�.
/*				
				for( int i = 0 ; i < 90 ; i++ ) {									//���� �����ؼ� ���� 90�� ���� AttendanceStatus�� ������.
					* ���� = ���� �����ؼ� ���� 90��
					 * ������ = �̹���, ������, ��������
					 * 
					 * 
					 */
				sqlDate.setMonth(sqlDate.getMonth()+1);
				sqlDate.setDate(0);									//�̹��� ������ sqlDate�� ����� ���̰�,
				
				
				for( int i = 0 ; i < 92 ; i++) {
					AttendanceStatus atdcStat = new AttendanceStatus();
					atdcStat.setDate(sqlDate);
					int dotw = sqlDate.getDay(); //dotw = day of the week , ����
					atdcStat.setDay(dotw);
					atdcStat.pseudoSetShouldComeTime(scheduleOfWeek[0][dotw]);
					atdcStat.pseudoSetShouldGoTime(scheduleOfWeek[1][dotw]);		//set�� �װ� �����. Date, day, shouldComeTime, shouldGoTime
					
					atdcStats.add(atdcStat);
					
					sqlDate.setDate(sqlDate.getDate()-1);
				}
				
				
				for( int i = 0 ; i < atdcStats.size() ; i++) {						//�Ʊ� ���� 90�ϰ��� AttendanceStatus���� ���� set�� �ȵ� �ΰ��� ��������� set������...
					AttendanceDao attendanceDao = new AttendanceDao( con ) ;
					List<Attendance> atdcs = null;
					
					atdcs = attendanceDao.getComeTimeATDSOfTheDate(id, atdcStats.get(i).getDate());	//�ش� ��¥��
					for( int j = 0 ; j < atdcs.size() ; j++ ) 
						atdcStats.get(i).pseudoSetEarlyComeTime(atdcs.get(j).getComeTime());		//�� �ð��� ���� �������� ���� �����ϰ�,
					
					atdcs = attendanceDao.getGoTimeATDSOfTheDate(id, atdcStats.get(i).getDate());
					for( int j = 0 ; j < atdcs.size() ; j++ ) 
						atdcStats.get(i).pseudoSetLateGoTime(atdcs.get(j).getGoTime());				//�� �ð��� ���� �������� ���� �����ϰ�,
					
					atdcs = attendanceDao.getATDSOfTheDate(id, atdcStats.get(i).getDate());		
					atdcStats.get(i).setAtdcOfTheDay(atdcs);										//����� ���� �� ��� ��ϵ� �����ϰ�!
				}																	//�̷μ� ������ set�� ������.
				
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
				studentBasic = studentBasicDao.getStudentBasicById(id);				//55�ٿ� �ִ� �̰� ���� �ٽ� �ؾ��Ѵ�.
				request.setAttribute("studentBasic", studentBasic); 				//�������� ���޿Ϸ�.
				
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
