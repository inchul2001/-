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
			 * insert �� �ؾߵǰ�...
			 * ���� Ŭ���س��� �׽�Ʈ�� �������� ��ﵵ �� �������� ���ٴ� ==> ���� �Ϸ�.
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
		
		List<StudentBasic> students = studentBasicDao.getAllStudentBasic(); //studentBasic�� �� �޾ƿ��� ������ ���⼱ ���̵� �̸������� �ʿ�����..
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
