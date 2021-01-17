package defaultPackage;

import static util.DbUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import dao.AttendanceDao;
import dao.LectureDao;
import vo.Attendance;
import vo.AttendanceStatus;
import vo.Lecture;

public class DebugPurpose3 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String id = "dongjun";
		Connection con = getConnection();			
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
		
		for( int i = 0 ; i < 10 ; i++ ) {									//오늘 포함해서 이전 90일 간의 AttendanceStatus를 만들자.
			AttendanceStatus atdcStat = new AttendanceStatus();
			atdcStat.setDate(sqlDate);
			int dotw = sqlDate.getDay(); //dotw = day of the week , 요일
			atdcStat.setDay(dotw);
			atdcStat.pseudoSetShouldComeTime(scheduleOfWeek[0][dotw]);
			atdcStat.pseudoSetShouldGoTime(scheduleOfWeek[1][dotw]);		//set을 네개 해줬다. Date, day, shouldComeTime, shouldGoTime
			
			atdcStats.add(atdcStat);
			
			System.out.println(sqlDate.toString());
			System.out.println(atdcStats.get(i).toString());
			sqlDate.setDate(sqlDate.getDate()-1);
		}
		for( int i = 0 ; i < atdcStats.size() ; i++) {						//아까 만든 90일간의 AttendanceStatus에서 아직 set이 안된 두개의 멤버변수를 set해주자...
			AttendanceDao attendanceDao = new AttendanceDao( con ) ;
			List<Attendance> atdcs = null;
			atdcs = attendanceDao.getComeTimeATDSOfTheDate(id, atdcStats.get(i).getDate());	//해당 날짜의
			for( int j = 0 ; j < atdcs.size() ; j++ ) 
				atdcStats.get(i).pseudoSetEarlyComeTime(atdcs.get(j).getComeTime());
			atdcs = attendanceDao.getGoTimeATDSOfTheDate(id, atdcStats.get(i).getDate());
			for( int j = 0 ; j < atdcs.size() ; j++ ) 
				atdcStats.get(i).pseudoSetLateGoTime(atdcs.get(j).getGoTime());
		}																	//이로서 나머지 set도 끝났다.
		for( int i = 0 ; i < atdcStats.size() ; i++) {
			System.out.println(atdcStats.get(i).toString());
		}
	}

}
