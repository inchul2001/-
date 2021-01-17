package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ActionForward;
import vo.Teacher;
import vo.TestMetaData;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.TeacherDao;
import dao.TestDao;

import static util.DbUtil.close;
import static util.DbUtil.commit;
import static util.DbUtil.getConnection;
import static util.DbUtil.rollback;
import vo.ActionForward;

public class TeacherManageAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("euc-kr");
		
		Connection con = getConnection();
		TeacherDao teacherDao = new TeacherDao(con);
		String contentType = request.getContentType();
		if( !(contentType.contentEquals("application/x-www-form-urlencoded") ) ) {
			//이때는 선생페이지=>선생님페이지 라는 얘기니까 파일을 업로드하는 과정이 들어가야 한다.
			Teacher tc = new Teacher();
			String uploadPath = request.getRealPath("upload");
			int size = 10 * 1024 *1024 ;
			
			try {
				//Multipart-form 으로 받은 파라메터들을 티쳐 객체에 저장 & 파일은 여기서 직접 업로드폴더에 업로드 
				MultipartRequest multi = new MultipartRequest( request, uploadPath, size, "euc-kr", new DefaultFileRenamePolicy());

				String fileName = (String)multi.getFileNames().nextElement();
				tc.setOriginalPictureName(multi.getOriginalFileName(fileName));
				tc.setUploadedPictureName(multi.getFilesystemName(fileName));
				tc.setHanMaDi(multi.getParameter("hanMaDi"));
				tc.setTeacherId(multi.getParameter("teacherId"));
				tc.setYakRyeok(multi.getParameter("yakRyeok"));
				//50: 파일 업로드 완료. 52~57:teacher객체 준비완료
			} catch( Exception e ) {
				e.printStackTrace();
			}
			
			teacherDao.inputTeacher(tc); //아까 준비된 teacher객체를 데이터베이스에 저장
		}
		
		//if문의 바깥이다. 멀티파트폼이 아니어도 할일-현존 선생님들 불러오기
		List<Teacher> teachers = teacherDao.getAllTeachers();
		request.setAttribute("teachers", teachers);
		
		ActionForward forward = new ActionForward();
		forward.setUrl("teacherManage.jsp");
		return forward;
	}

}
