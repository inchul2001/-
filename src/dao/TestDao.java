package dao;

import java.sql.*; 
import java.util.ArrayList;
import java.util.List;

import vo.IndivScore;
import vo.TestMetaData;

import static util.DbUtil.*;

public class TestDao {
	private Connection con = null; 
	
	public TestDao(Connection con) {
		super();
		this.con = con;
	}

	public void scoreInput(IndivScore indivScore) { 
/*이 시점에서 indivScore의 값중 실제로 내가 넣은 정보는  studentId, testId, indivAnswerString 이므로..
score 를 반드시 제가 계산해드려야겟네요..
1. testId로 시험정보를 찾아서 거기있는 	
*/		
	}
	
	public void testMetaDataInput(TestMetaData newTest) {
		PreparedStatement pstmt = null ;
		
		try {
			String sql = "insert into testmetadata"
					+ "(testID, baejumString, answerString, descript, testRange, uploadedfileName, originalfileName, testDate, totalScore) "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?)" ;
			pstmt = con.prepareStatement(sql) ;
			
			pstmt.setString(1, newTest.getTestId());
			pstmt.setString(2, newTest.getBaejumString());
			pstmt.setString(3, newTest.getAnswerString());
			pstmt.setString(4, newTest.getDescription());
			pstmt.setString(5, newTest.getTestRange());
			pstmt.setString(6, newTest.getuploadedFileName());
			pstmt.setString(7, newTest.getoriginalFileName());
			pstmt.setDate(8, newTest.getTestDate());
			pstmt.setFloat(9, newTest.getTotalScore());
			
			System.out.println(pstmt.toString());
			
//			pstmt.execute(sql);
			pstmt.executeUpdate();
			
			
			commit(con);
			
			
		} catch(Exception e ) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
	}
	
	public List<TestMetaData> getAllTests() {
		PreparedStatement pstmt = null ;
		ResultSet rs = null;
		List<TestMetaData> tests = null ;
		TestMetaData test = null ;
		try {
			String sql = "select * from testmetadata order by testDate desc" ;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			tests = new ArrayList<TestMetaData>();
			
			while(rs.next()) {
				test = new TestMetaData();
				test.setTestId(rs.getString("testId"));
				test.setTestDate(rs.getDate("testDate"));
				test.setAnswerString(rs.getString("answerString"));
				test.setBaejumString(rs.getString("baejumString"));
				test.setDescription(rs.getString("descript"));
				test.setoriginalFileName(rs.getString("originalfileName"));
				test.setuploadedFileName(rs.getString("uploadedfileName"));
				test.setTestRange(rs.getString("testRange"));
				test.setTotalScore(rs.getFloat("totalScore"));
				
				tests.add(test);
			}
			
			
		}catch( Exception e) {
			e.printStackTrace();
		}
		return tests;
	}
	

}
