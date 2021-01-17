package defaultPackage;

import static util.DbUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import dao.IndivScoreDao;
import vo.AttendanceStatus;
import vo.TestInfo;

public class DebugAboutTime {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		List<AttendanceStatus> atdcStats = new ArrayList<AttendanceStatus>();
		java.util.Date javaToday = new java.util.Date();
		System.out.println(javaToday);
		java.sql.Date sqlDate = new java.sql.Date(javaToday.getTime());
		System.out.println(sqlDate);

		sqlDate.setMonth(sqlDate.getMonth()+1);
		sqlDate.setDate(0);
		
		System.out.println(sqlDate);
	}

}
