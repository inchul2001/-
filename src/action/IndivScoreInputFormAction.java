package action;

import static util.DbUtil.getConnection;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.IndivScoreDao;
import dao.StudentBasicDao;
import dao.TestDao;
import vo.ActionForward;
import vo.IndivScore;
import vo.StudentBasic;
import vo.TestMetaData;

public class IndivScoreInputFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("euc-kr");
		
		Connection con = getConnection();
		IndivScoreDao indivScoreDao = new IndivScoreDao(con);
		StudentBasicDao studentBasicDao = new StudentBasicDao(con);
		TestDao testDao = new TestDao(con);
		
		if( request.getParameter("recursive") != null ) { 
			/*
			 * insert 도 해야되고...
			 * 내가 클릭해놓은 테스트가 뭐였는지 기억도 좀 해줬으면 좋겟다 ==> 구현 완료.
			 */
			int selectedTestIndex = Integer.parseInt(request.getParameter("recursive") );
			request.setAttribute("alreadySelectedTest", selectedTestIndex);
			
			IndivScore newScore = new IndivScore();
			newScore.setIndivAnswerString(request.getParameter("indivAnswerString"));
			newScore.setScore(Integer.parseInt(request.getParameter("score")));
			newScore.setStudentId(request.getParameter("studentId"));
			newScore.setTestId(request.getParameter("testId"));
			newScore.setComment(request.getParameter("comment"));
			int studentAge = studentBasicDao.getStudentBasicById(request.getParameter("studentId")).getStudentAge();
			newScore.setStudentAge(studentAge);
			
			indivScoreDao.inputIndivScore(newScore);
		}
		
		List<StudentBasic> students = studentBasicDao.getAllStudentBasic(); //studentBasic을 다 받아오긴 했으나 여기선 아이디 이름정도만 필요하지..
		List<TestMetaData> tests = testDao.getAllTests();
		List<IndivScore> scores = indivScoreDao.getAllIndivScores();
		request.setAttribute("students", students);
		request.setAttribute("tests", tests);
		request.setAttribute("scores", scores);
	
		ActionForward forward = new ActionForward();
		forward.setUrl("indivScoreInputForm.jsp");
		return forward;
	}

	
}
