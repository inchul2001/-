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
	 * ���⼭ �� ���� 
	1.request�� ������� testMetaData�� ������ �����ͺ��̽��� �����ϰ�,
	2.������ ������ ��������ǻ�Ϳ� �����ϰ�,
	3.�ٽ� ������ �ּҴ� testMeataDataInputForm.jsp�� �Ǵ� ��������..
	4.with testMetaDataInputForm���� �ʿ��� ������!
	*/

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// TODO Auto-generated method stub
		request.setCharacterEncoding("euc-kr");
		
		Connection con = getConnection();
		TestDao testDao = new TestDao(con);
		System.out.println(request.getContentType());
		if( !request.getContentType().equals("application/x-www-form-urlencoded") ) {
		System.out.println("�������");		
	
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

		//40~70 : ���ο� �׽�Ʈ��Ÿ�����͸� �����ϴ� ���..

//==============���� ������ ������: ������ ���� �׽�Ʈ��Ÿ�����͸� �ҷ����� �װ� �����ؼ� Ŭ���̾�Ʈ�� �����ִ°�.. 
		List<TestMetaData> tests = testDao.getAllTests();
		request.setAttribute("tests", tests);
//==============
		
		ActionForward forward = new ActionForward();
		forward.setUrl("testMetaDataInputForm.jsp");
		return forward;
	}

}
