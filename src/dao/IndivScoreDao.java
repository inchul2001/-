package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import vo.IndivScore;
import vo.StudentBasic;
import vo.TestInfo;
import vo.TestMetaData;

import static util.DbUtil.*;

public class IndivScoreDao {
	private Connection con = null; 
	
	public IndivScoreDao(Connection con) {
		super();
		this.con = con;
	}	
	
	public List<IndivScore> getAllIndivScores() {

		PreparedStatement pstmt = null ;
		ResultSet rs = null;
		List<IndivScore> scores = null ;
		IndivScore score = null;
		
		try {
			String sql ="select * from indivScore" ;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			scores = new ArrayList<IndivScore>();
			
			while(rs.next()) {
				score = new IndivScore() ;
				score.setIndivAnswerString(rs.getString("indivAnswerString"));
				score.setIndivScoreNum(rs.getInt("indivScoreNum"));
				score.setScore(rs.getInt("score"));
				score.setStudentId(rs.getString("studentId"));
				score.setTestId(rs.getString("testId"));
				score.setComment(rs.getString("comment"));
				score.setStudentAge(rs.getInt("studentAge"));
				
				scores.add(score);
			}
			
		}catch(Exception e ) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return scores;
	}

	public void inputIndivScore(IndivScore score) {
		PreparedStatement pstmt = null ;
		
		try {
			String sql = "insert into indivscore(studentId, testId, indivAnswerString, score, comment, studentAge) values(?,?,?,?,?,?)" ;
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, score.getStudentId());
			pstmt.setString(2, score.getTestId());
			pstmt.setString(3, score.getIndivAnswerString());
			pstmt.setFloat(4, score.getScore());
			pstmt.setString(5, score.getComment());
			pstmt.setInt(6, score.getStudentAge());
			
			pstmt.execute();
			System.out.println(pstmt.toString());
			commit(con);
			
		} catch(Exception e ) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
	}
	
	public List<TestInfo> getAllTestInfoByStudentId(String studentId) {

		PreparedStatement pstmt = null ;
		ResultSet rs = null;
		List<IndivScore> indivScores = new ArrayList<IndivScore>();
		IndivScore indivScore = null;
		TestInfo testInfo = null;
		//==================================

		try {
			String sql = "select * from indivScore where studentId = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, studentId);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				indivScore = new IndivScore();
				indivScore.setIndivScoreNum(rs.getInt("indivScoreNum"));
				indivScore.setStudentId(studentId);
				indivScore.setTestId(rs.getString("testId"));
				indivScore.setIndivAnswerString(rs.getString("indivAnswerString"));
				indivScore.setScore(rs.getFloat("score"));
				indivScore.setStudentAge(rs.getInt("studentAge"));
				indivScore.setComment(rs.getString("comment"));
				
				indivScores.add(indivScore);
			}
			
		}catch(Exception e ) {	e.printStackTrace();	}		
		
		List<TestInfo> testInfos = new ArrayList<TestInfo>() ;
		for( int i = 0 ; i < indivScores.size() ; i++) {
			testInfo = convertToTestInfo(indivScores.get(i));
			testInfo = fillTestInfo1(testInfo);
			testInfo = fillTestInfo2(testInfo);
			
			testInfos.add( testInfo );
			testInfo = null;
		}									
		
		return testInfos;
	}
	
	public TestInfo convertToTestInfo(IndivScore yourTest) {
		TestInfo testInfo = new TestInfo() ;
		testInfo.setIndivScoreNum(yourTest.getIndivScoreNum());
		testInfo.setStudentID(yourTest.getStudentId());
		testInfo.setTestId(yourTest.getTestId());
		testInfo.setStudentAge(yourTest.getStudentAge());
		testInfo.setYourAnswerString(yourTest.getIndivAnswerString());
		testInfo.setYourScore(yourTest.getScore());
		testInfo.setComments(yourTest.getComment());
		
		return testInfo;
	}
	
	public TestInfo fillTestInfo1(TestInfo testInfo) {
		TestDao testDao = new TestDao( con ) ;
		List<TestMetaData> allTests = testDao.getAllTests();
		String testId = testInfo.getTestId();
		
		for( int i = 0 ; i < allTests.size() ; i++ ) {
			if(allTests.get(i).getTestId().equals(testId)) {
				testInfo.setBaejumString(allTests.get(i).getBaejumString());
				testInfo.setCorrectAnswerString(allTests.get(i).getAnswerString());
				testInfo.setTotalScore(allTests.get(i).getTotalScore());
				testInfo.setOriginalFileName(allTests.get(i).getoriginalFileName());
				testInfo.setUploadedFileName(allTests.get(i).getuploadedFileName());
				break;
			}
		}
		return testInfo;
		
	}

	public TestInfo fillTestInfo2(TestInfo testInfo) {
		//이 함수 호출할 때  testInfo는 
		/*
		 * indivScoreNum (ok, convert)
		 * studentID (ok, convert)
		 * testId (ok, convert)
		 * studentAge (ok, convert)
		 * baejumString (ok, fill 1 )
		 * correctAnswerString (ok, fill 1 )
		 * yourAnswerString (ok, convert)
		 * totalScore (ok, fill 1 )
		 * yourScore (ok, convert)
		 * comments (ok, convert)
		 * 
		 * 의 값이 채워져있어야 하고, 여기서 채우는 값들은 
		 * 
		 * totalAverage
		 * ageAverage
		 * 
		 * totalDistribution
		 * ageDistribution
		 * 
		 * totalRanking
		 * ageRanking		입니당..!
		 */
		String targetTest = testInfo.getTestId();
		int targetAge = testInfo.getStudentAge();
		
		try {	//이 try문은 전체- 평균, 등수, 분포를 구하는것이 목적임.
			PreparedStatement pstmt = null ;
			ResultSet rs = null ;
			
			String sql = "select *, rank() over (order by score desc ) as ranking from indivscore where testId = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, targetTest);
			rs = pstmt.executeQuery();
			
			int numOfStudent = 0 ;
			float scoreSum = 0 ;
			
			float totalScore = testInfo.getTotalScore();
			int arr[] = new int[10];
			
			while(rs.next()) {
				
				scoreSum += rs.getFloat("score");
				numOfStudent ++;						//평균 구하기 위한 재료
				
				float nowScore = rs.getFloat("score");
//System.out.println(nowScore);
				for( int i = 0 ; i < 10 ; i++) {
//System.out.println(Arrays.toString(arr));
					if( nowScore == 0 )
						arr[0] ++;
					if( (totalScore*i/10 < nowScore) && (nowScore <= totalScore*(i+1)/10) ) {
						arr[i] ++ ;
						break;
					}
				}
				testInfo.setTotalDistribution(Arrays.toString(arr) ); //점수분포 구하기
				
				if( rs.getInt("indivScoreNum") == testInfo.getIndivScoreNum() )
					testInfo.setTotalRanking( rs.getInt("ranking") );	//등수 구하기
				
			}
//System.out.println(numOfStudent);
			testInfo.setTotalAverage( scoreSum / numOfStudent );	//평균 구하기
		
		}catch(Exception e ) {	e.printStackTrace();}
		
		try {	//이 try문은 나이별- 평균, 등수, 분포를 구하는것이 목적임.
			PreparedStatement pstmt = null ;
			ResultSet rs = null ;
			
			String sql = "select *, rank() over (order by score desc ) as ranking from indivscore where testId = ? and studentAge = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, targetTest);
			pstmt.setInt(2, targetAge);
			rs = pstmt.executeQuery();
			
			int numOfStudent = 0 ;
			float scoreSum = 0 ;
			
			float totalScore = testInfo.getTotalScore();
			int arr[] = new int[10];
			
			while(rs.next()) {
				
				scoreSum += rs.getFloat("score");
				numOfStudent ++;						//평균 구하기 위한 재료
				
				float nowScore = rs.getFloat("score");
				for( int i = 0 ; i < 10 ; i++) {
					if( nowScore == 0 )
						arr[0] ++;
					if( totalScore*i/10 < nowScore && nowScore <= totalScore*(i+1)/10 ) {
						arr[i] ++ ;
						break;
					}
				}
				testInfo.setAgeDistribution(Arrays.toString(arr) ); //점수분포 구하기
				
				if( rs.getInt("indivScoreNum") == testInfo.getIndivScoreNum() )
					testInfo.setAgeRanking( rs.getInt("ranking") );	//등수 구하기
				
			}
			testInfo.setAgeAverage( scoreSum / numOfStudent );	//평균 구하기
			
		}catch(Exception e ) {	e.printStackTrace();}		
		return testInfo;
	}
}
