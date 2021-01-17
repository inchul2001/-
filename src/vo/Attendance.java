package vo;

import java.sql.Date;
import java.sql.Time;

public class Attendance {
	private int attendanceNum ;
	private String studentId ;
	private Date attendDate ;
	private Time comeTime;
	private Time goTime;
	public int getAttendanceNum() {
		return attendanceNum;
	}
	public void setAttendanceNum(int attendanceNum) {
		this.attendanceNum = attendanceNum;
	}
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	public Date getAttendDate() {
		return attendDate;
	}
	public void setAttendDate(Date attendDate) {
		this.attendDate = attendDate;
	}
	public Time getComeTime() {
		return comeTime;
	}
	public void setComeTime(Time comeTime) {
		this.comeTime = comeTime;
	}
	public Time getGoTime() {
		return goTime;
	}
	public void setGoTime(Time goTime) {
		this.goTime = goTime;
	}
	
	
}
