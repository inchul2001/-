package dao;

import java.sql.*; 
import java.util.ArrayList;
import java.util.List;

import vo.IndivScore;
import vo.Sugang;
import vo.TestMetaData;
import vo.Teacher; 

import static util.DbUtil.*;

public class TeacherDao {
	private Connection con = null; 
	
	public TeacherDao(Connection con) {
		super();
		this.con = con;
	}
	
	public List<Teacher> getAllTeachers() {
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		List<Teacher> teachers = null ;
		Teacher tc = null ;
		
		try {
			String sql = "select * from teacher" ;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			teachers = new ArrayList<Teacher>() ;
			
			while( rs.next() ) {
				tc = new Teacher() ;
				tc.setHanMaDi(rs.getString("hanMaDi"));
				tc.setOriginalPictureName(rs.getString("originalPictureName"));
				tc.setTeacherId(rs.getString("teacherId"));
				tc.setUploadedPictureName(rs.getString("uploadedPictureName"));
				tc.setYakRyeok(rs.getString("yakRyeok"));
				
				teachers.add(tc);
			}
		} catch( Exception e ) {
			e.printStackTrace();
		}
		return teachers;
	}
	
	public void inputTeacher(Teacher tc) {
		PreparedStatement pstmt = null ;
		
		try {
			String sql = "insert into teacher(teacherId, uploadedPictureName, originalPictureName, yakRyeok, hanMaDi) values(?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, tc.getTeacherId() );
			pstmt.setString(2, tc.getUploadedPictureName() );
			pstmt.setString(3, tc.getOriginalPictureName() );
			pstmt.setString(4, tc.getYakRyeok() );
			pstmt.setString(5, tc.getHanMaDi());
			
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
