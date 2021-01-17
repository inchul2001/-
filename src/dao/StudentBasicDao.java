package dao;

import java.sql.*; 
import java.util.ArrayList;
import java.util.List;

import vo.StudentBasic;

import static util.DbUtil.*;

public class StudentBasicDao {
	private Connection con = null; 
	
	public StudentBasicDao(Connection con) {
		super();
		this.con = con;
	}	
	
	public StudentBasic getStudentBasicById(String id) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StudentBasic studentBasic = null;
		
		try {
			String sql = "select * from studentBasic where studentid= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				studentBasic = new StudentBasic();
				studentBasic.setStudentId(rs.getString("studentId"));
				studentBasic.setStudentPassword(rs.getString("studentPassword"));
				studentBasic.setStudentName(rs.getString("studentName"));
				studentBasic.setStudentAge(rs.getInt("studentAge"));
				studentBasic.setStudentSchool(rs.getString("studentSchool"));
				studentBasic.setStudentPhone(rs.getString("studentPhone"));
				studentBasic.setStudentMotherPhone(rs.getString("studentMotherPhone"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rs);
		}
		return studentBasic;
	}
	
	public void inputStudentBasic(StudentBasic st) {
		PreparedStatement pstmt = null ;
		
		try {
			String sql = "insert into studentbasic(studentId, studentPassword, studentName, studentAge, studentSchool, studentPhone, studentMotherPhone ) values(?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, st.getStudentId());
			pstmt.setString(2, st.getStudentPassword());
			pstmt.setString(3, st.getStudentName());
			pstmt.setInt(4, st.getStudentAge());
			pstmt.setString(5, st.getStudentSchool());
			pstmt.setString(6, st.getStudentPhone());
			pstmt.setString(7, st.getStudentMotherPhone());
			
			pstmt.execute();
			commit(con);
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
	}
	
	public void modifyStudentBasic(StudentBasic st) {
		PreparedStatement pstmt = null ;

		try {
			String sql ="update studentbasic set studentPassword=?, studentName=?, "
					+ "studentAge=?, studentSchool=?, studentPhone=?, studentMotherPhone=? "
					+ "where studentId=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, st.getStudentPassword());
			pstmt.setString(2, st.getStudentName());
			pstmt.setInt(3, st.getStudentAge());
			pstmt.setString(4, st.getStudentSchool());
			pstmt.setString(5, st.getStudentPhone());
			pstmt.setString(6, st.getStudentMotherPhone());
			pstmt.setString(7, st.getStudentId());
			
//			System.out.println(pstmt.toString());
	
			pstmt.execute();
			commit(con);
			
		}catch(Exception e ) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return;
		
	}
	
	public List<StudentBasic> getAllStudentBasic() {
		PreparedStatement pstmt = null ;
		ResultSet rs = null;
		List<StudentBasic> students = null ;
		StudentBasic st = null ;
		
		try {
			String sql ="select * from studentbasic" ;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			students = new ArrayList<StudentBasic>();
			
			while( rs.next() ) {
				st = new StudentBasic();
				st.setStudentAge(rs.getInt("studentAge"));
				st.setStudentId(rs.getString("studentId"));
				st.setStudentMotherPhone(rs.getString("studentMotherPhone"));
				st.setStudentName(rs.getString("studentName"));
				st.setStudentPassword(rs.getString("studentPassword"));
				st.setStudentPhone(rs.getString("studentPhone"));
				st.setStudentSchool(rs.getString("studentSchool"));
				
				students.add(st);
			}
		} catch(Exception e ) { 
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return students;
	}
}
