package dao;

import java.sql.*; 
import java.util.ArrayList;
import java.util.List;

import vo.Lecture;
import vo.Sugang;

import static util.DbUtil.*;

public class LectureDao {
	private Connection con = null; 
	
	public LectureDao(Connection con) {
		super();
		this.con = con;
	}	
	
	public List<String> getAllClassrooms() { //need check
		PreparedStatement pstmt = null ;
		ResultSet rs = null;
		List<String> classrooms = null ;
		
		try {
			String sql ="select * from classroom" ;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			classrooms = new ArrayList<String>();
			
			while(rs.next()) {
				String classroom = rs.getString("classroom");
				
				classrooms.add(classroom);
			}
			
		} catch(Exception e ) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return classrooms;
	}
	
	public List<Lecture> getAllLectures() {//need check
		PreparedStatement pstmt = null ;
		ResultSet rs = null;
		List<Lecture> lectures = null ;
		Lecture lc = null;
		
		try {
			String sql ="select * from lecture" ;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			lectures = new ArrayList<Lecture>();
			
			while(rs.next()) {
				lc = new Lecture() ;
				
				lc.setLectureId(rs.getInt("lectureNum"));
				lc.setDay(rs.getInt("day"));
				lc.setTime(rs.getInt("time"));
				lc.setClassroom(rs.getString("classroom"));
				lc.setTeacherId(rs.getString("teacherId"));
				lc.setCapacity(rs.getInt("capacity"));
				
				lectures.add(lc);
			}
			
		} catch(Exception e ) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return lectures;
	}
	
	public List<String> getAllTeacherIds() {//check need
		PreparedStatement pstmt = null ;
		ResultSet rs = null;
		List<String> teachers = null ;
		String tc = null;
		
		try {
			String sql ="select * from teacher" ;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			teachers = new ArrayList<String>();
			
			while(rs.next()) {
				tc = rs.getString("teacherId");
								
				teachers.add(tc);
			}
			
		} catch(Exception e ) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return teachers;
	}
	
	public void inputLecture(Lecture lc) {//check need
		PreparedStatement pstmt = null ;
		try {
			String sql = "insert into lecture(day, time, classroom, teacherId, capacity ) values(?, ?, ?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, lc.getDay());
			pstmt.setInt(2, lc.getTime());
			pstmt.setString(3, lc.getClassroom());
			pstmt.setString(4, lc.getTeacherId());
			pstmt.setInt(5, lc.getCapacity());

			pstmt.execute();
			System.out.println(pstmt.toString());
			commit(con);
			
		}catch(Exception e ) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return ;
	}
	
	public void inputClassroom(String classroom) { //check need
		PreparedStatement pstmt = null ;
		try {
			String sql = "insert into classroom(classroom) values(?)";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, classroom);
			
			pstmt.execute();
			commit(con);
			
		}catch(Exception e ) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return ;
	}
	
	public List<Lecture> getAllSugangLectureByStudentId(String studentId) {
		PreparedStatement pstmt = null ;
		ResultSet rs = null;
		List<Lecture> lectures = null ;
		Lecture lecture = null;
		
		try {
			String sql = "select * from sugang, lecture where sugang.lectureNum = lecture.lectureNum and studentId= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, studentId);
			rs = pstmt.executeQuery();
			lectures = new ArrayList<Lecture>();
			while(rs.next()) {
				lecture = new Lecture();
				lecture.setDay(rs.getInt("day"));
				lecture.setTime(rs.getInt("time"));
				
				lectures.add(lecture);
			}
		}catch(Exception e ) { e.printStackTrace(); }
		
		return lectures;
	}
	
	public void inputSugang(Sugang sugang) {
		PreparedStatement pstmt = null ;
		
		try {
			String sql = "insert into sugang(studentId, lectureNum) values(?, ?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, sugang.getStudentId());
			pstmt.setInt(2, sugang.getLectureId());
			
			pstmt.execute();
			System.out.println(pstmt.toString());
			
			commit( con ) ;
			
		} catch( Exception e ) {
			e.printStackTrace();
		} finally {
			close(pstmt) ;
		}
		
	}
}
