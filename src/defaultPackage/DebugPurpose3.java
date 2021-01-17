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
				scheduleOfWeek[0][targetDay] = time ;						//���ٿ��� �;��ϴ� �ִ�ð��� ǥ�����ְ�
			if( scheduleOfWeek[1][targetDay] < time )
				scheduleOfWeek[1][targetDay] = time ;						//�Ʒ��ٿ��� �����ϴ� �ּҽð��� ǥ��������.	
		}																	//�̰ɷ� ���� ��ý �Ǵ� ���� �迭 �ϼ�.
		
		List<AttendanceStatus> atdcStats = new ArrayList<AttendanceStatus>();
		java.util.Date javaToday = new java.util.Date();
		java.sql.Date sqlDate = new java.sql.Date(javaToday.getTime());		//���� ��¥�� ���ϰ�.
		
		for( int i = 0 ; i < 10 ; i++ ) {									//���� �����ؼ� ���� 90�� ���� AttendanceStatus�� ������.
			AttendanceStatus atdcStat = new AttendanceStatus();
			atdcStat.setDate(sqlDate);
			int dotw = sqlDate.getDay(); //dotw = day of the week , ����
			atdcStat.setDay(dotw);
			atdcStat.pseudoSetShouldComeTime(scheduleOfWeek[0][dotw]);
			atdcStat.pseudoSetShouldGoTime(scheduleOfWeek[1][dotw]);		//set�� �װ� �����. Date, day, shouldComeTime, shouldGoTime
			
			atdcStats.add(atdcStat);
			
			System.out.println(sqlDate.toString());
			System.out.println(atdcStats.get(i).toString());
			sqlDate.setDate(sqlDate.getDate()-1);
		}
		for( int i = 0 ; i < atdcStats.size() ; i++) {						//�Ʊ� ���� 90�ϰ��� AttendanceStatus���� ���� set�� �ȵ� �ΰ��� ��������� set������...
			AttendanceDao attendanceDao = new AttendanceDao( con ) ;
			List<Attendance> atdcs = null;
			atdcs = attendanceDao.getComeTimeATDSOfTheDate(id, atdcStats.get(i).getDate());	//�ش� ��¥��
			for( int j = 0 ; j < atdcs.size() ; j++ ) 
				atdcStats.get(i).pseudoSetEarlyComeTime(atdcs.get(j).getComeTime());
			atdcs = attendanceDao.getGoTimeATDSOfTheDate(id, atdcStats.get(i).getDate());
			for( int j = 0 ; j < atdcs.size() ; j++ ) 
				atdcStats.get(i).pseudoSetLateGoTime(atdcs.get(j).getGoTime());
		}																	//�̷μ� ������ set�� ������.
		for( int i = 0 ; i < atdcStats.size() ; i++) {
			System.out.println(atdcStats.get(i).toString());
		}
	}

}
