package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import vo.Attendance;
import vo.IndivScore;

import static util.DbUtil.*;

public class AttendanceDao {
	private Connection con = null; 
	
	public AttendanceDao(Connection con) {
		super();
		this.con = con;
	}	
	
	public List<Attendance> getAllAttendances() {

		PreparedStatement pstmt = null ;
		ResultSet rs = null;
		List<Attendance> attendances = null ;
		Attendance attendance = null;
		
		try {
			String sql ="select * from attendance order by attendanceNum desc" ;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			attendances = new ArrayList<Attendance>();
			
			while(rs.next()) {
				attendance = new Attendance();
				attendance.setAttendanceNum(rs.getInt("attendanceNum"));
				attendance.setAttendDate(rs.getDate("attendDate"));
				attendance.setComeTime(rs.getTime("comeTime"));
				attendance.setGoTime(rs.getTime("goTime"));
				attendance.setStudentId(rs.getString("studentId"));

				attendances.add(attendance);
			}
			
		}catch(Exception e ) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return attendances;
	}
	
	public void inputAttendance(Attendance atdc) {
		PreparedStatement pstmt = null ;
		
		try {
			String sql = "insert into attendance(attendDate, comeTime, goTime, studentId) values(?,?,?,?)" ;
			pstmt = con.prepareStatement(sql);
			
			pstmt.setDate(1, atdc.getAttendDate());
			pstmt.setTime(2, atdc.getComeTime());
			pstmt.setTime(3, atdc.getGoTime());
			pstmt.setString(4, atdc.getStudentId());
			
			pstmt.execute();
			System.out.println(pstmt.toString());
			commit(con);
			
		} catch(Exception e ) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
	}
	
	public List<Attendance> getComeTimeATDSOfTheDate(String id ,Date date) {

		PreparedStatement pstmt = null ;
		ResultSet rs = null;
		List<Attendance> attendances = new ArrayList<Attendance>() ;
		Attendance attendance = null;
		
		try {
			String sql = "select * from attendance where studentId = ? and goTime is null and attendDate = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setDate(2, date);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				attendance = new Attendance();
				attendance.setAttendanceNum(rs.getInt("attendanceNum"));
				attendance.setComeTime(rs.getTime("comeTime"));
				
				attendances.add(attendance);
			}
			
		}catch(Exception e ) {e.printStackTrace();		}
		
		return attendances;
	}
	
	public List<Attendance> getGoTimeATDSOfTheDate(String id, Date date) {

		PreparedStatement pstmt = null ;
		ResultSet rs = null;
		List<Attendance> attendances = new ArrayList<Attendance>() ;
		Attendance attendance = null;
		
		try {
			String sql = "select * from attendance where studentId = ? and comeTime is null and attendDate = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setDate(2, date);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				attendance = new Attendance();
				attendance.setAttendanceNum(rs.getInt("attendanceNum"));
				attendance.setGoTime(rs.getTime("goTime"));
				
				attendances.add(attendance);
			}
			
		}catch(Exception e ) {e.printStackTrace();		}
		
		return attendances;
	}
	
	public List<Attendance> getATDSOfTheDate(String id, Date date) {

		PreparedStatement pstmt = null ;
		ResultSet rs = null;
		List<Attendance> attendances = new ArrayList<Attendance>() ;
		Attendance attendance = null;
		
		try {
			String sql = "select * from attendance where studentId = ? and attendDate = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setDate(2, date);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				attendance = new Attendance();
				attendance.setAttendanceNum(rs.getInt("attendanceNum"));
				attendance.setGoTime(rs.getTime("goTime"));
				attendance.setComeTime(rs.getTime("comeTime"));
				
				attendances.add(attendance);
			}
			
		}catch(Exception e ) {e.printStackTrace();		}
		
		return attendances;
	}
	
	public void modifyAtdc(Attendance atdc) {
		PreparedStatement pstmt = null ;
		
		try {
			String sql = null ;
			if( atdc.getComeTime() != null ) {
				sql = "update attendance set comeTime=? where attendanceNum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setTime(1, atdc.getComeTime());
				pstmt.setInt(2, atdc.getAttendanceNum());
				
			}
			else if( atdc.getGoTime() != null ) {
				sql = "update attendance set goTime=? where attendanceNum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setTime(1, atdc.getGoTime());
				pstmt.setInt(2, atdc.getAttendanceNum());
			}
			
			
			pstmt.execute();
			System.out.println(pstmt.toString());
			commit(con);
			
		}catch( Exception e ) {
			e.printStackTrace();
		}
	}

}
