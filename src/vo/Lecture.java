package vo;

import java.sql.Date;

public class Lecture {
	private int lectureId;			//자동생성, PK
	private int day;				//0~6의 값을 가진다.
	private int time;				//1~13의 값을 가진다.
	private String classroom;
	private String teacherId;
	private int capacity;
	private Date startDate;
	private Date endDate;
	

	public int getLectureId() {
		return lectureId;
	}
	public int getDay() {
		return day;
	}
	public int getTime() {
		return time;
	}
	public String getClassroom() {
		return classroom;
	}

	public String getTeacherId() {
		return teacherId;
	}
	
	public int getCapacity() {
		return capacity;
	}
	
	public void setLectureId(int a ) {
		this.lectureId = a ;
	}
	public void setDay(int str ) {
		this.day = str ;
	}
	public void setTime(int str ) {
		this.time = str ;
	}
	public void setClassroom(String str ) {
		this.classroom = str ;
	}

	public void setTeacherId(String str ) {
		this.teacherId = str ;
	}
	
	
	public void setCapacity(int a ) {
		this.capacity = a ;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	
	
	
}
