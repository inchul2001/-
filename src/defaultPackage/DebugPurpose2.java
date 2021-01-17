package defaultPackage;

import static util.DbUtil.getConnection;

import java.sql.Connection;
import java.util.Arrays;
import java.util.List;

import dao.AttendanceDao;
import dao.IndivScoreDao;
import dao.LectureDao;
import vo.Attendance;
import vo.Lecture;
import vo.TestInfo;

public class DebugPurpose2 {

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
				scheduleOfWeek[0][targetDay] = time ;	//윗줄에는 와야하는 최대시각을 표시해주고
			if( scheduleOfWeek[1][targetDay] < time )
				scheduleOfWeek[1][targetDay] = time ;	//아랫줄에는 가야하는 최소시각을 표시해주자.	
		}												//이걸로 매주 출첵 판단 기준 배열 완성.
		System.out.println(Arrays.toString(scheduleOfWeek[0]));
		System.out.println(Arrays.toString(scheduleOfWeek[1]));
		
		AttendanceDao attendanceDao = new AttendanceDao( con ) ;
/*		List<Attendance> comeTimes = attendanceDao.getComeTimeATDSOfTheDate(id);
		for( int i = 0 ; i < comeTimes.size(); i++) {
			java.sql.Date tempDate = comeTimes.get(i).getAttendDate();
			int day = tempDate.getDay();
			System.out.println(day);
			
		}
*/	}

}
