package action;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ActionForward;
import vo.TestMetaData;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.TestDao;

import static util.DbUtil.close;
import static util.DbUtil.commit;
import static util.DbUtil.getConnection;
import static util.DbUtil.rollback;

public class TestUploadAction implements Action{
	/*
	 * 여기서 할 일은 
	1.request에 들어있을 testMetaData의 값들을 데이터베이스에 저장하고,
	2.시험지 파일은 서버측컴퓨터에 저장하고,
	3.다시 돌려줄 주소는 testMeataDataInputForm.jsp가 되는 것이지요..
	4.with testMetaDataInputForm에서 필요한 정보들!
	*/

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// TODO Auto-generated method stub
		request.setCharacterEncoding("euc-kr");
		
		Connection con = getConnection();
		TestDao testDao = new TestDao(con);
		System.out.println(request.getContentType());
		if( !request.getContentType().equals("application/x-www-form-urlencoded") ) {
		System.out.println("오예통과");		
	
			TestMetaData test = new TestMetaData();
			
			String uploadPath = request.getRealPath("upload");
			int size = 10 * 1024 *1024 ;
			
			try {
				MultipartRequest multi = new MultipartRequest( request, uploadPath, size, "euc-kr", new DefaultFileRenamePolicy());

				test.setTestId(multi.getParameter("testId"));
				String dateString = multi.getParameter("testDate");
				
				SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date utilDate = transFormat.parse(dateString);
	
				test.setTestDate(new java.sql.Date(utilDate.getTime()));
				test.setTestRange(multi.getParameter("testRange"));
				test.setDescription(multi.getParameter("description"));
				String fileName = (String)multi.getFileNames().nextElement();
				test.setoriginalFileName(multi.getOriginalFileName(fileName));
				test.setuploadedFileName(multi.getFilesystemName(fileName));
				test.setAnswerString(multi.getParameter("testAnswerString"));
				test.setBaejumString(multi.getParameter("testBaejumString"));
				test.setTotalScore(Float.parseFloat(multi.getParameter("totalScore") ) );
				
							
			} catch( Exception e ) {
				e.printStackTrace();
			}
			
			testDao.testMetaDataInput(test);
		}

		//40~70 : 새로운 테스트메타데이터를 저장하는 모습..

//==============여기 구현할 내용은: 여지껏 만든 테스트메타데이터를 불러오고 그걸 저장해서 클라이언트에 보내주는것.. 
		List<TestMetaData> tests = testDao.getAllTests();
		request.setAttribute("tests", tests);
//==============
		
		ActionForward forward = new ActionForward();
		forward.setUrl("testMetaDataInputForm.jsp");
		return forward;
	}

}
