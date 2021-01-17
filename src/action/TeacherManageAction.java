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
			//�̶��� ����������=>������������ ��� ���ϱ� ������ ���ε��ϴ� ������ ���� �Ѵ�.
			Teacher tc = new Teacher();
			String uploadPath = request.getRealPath("upload");
			int size = 10 * 1024 *1024 ;
			
			try {
				//Multipart-form ���� ���� �Ķ���͵��� Ƽ�� ��ü�� ���� & ������ ���⼭ ���� ���ε������� ���ε� 
				MultipartRequest multi = new MultipartRequest( request, uploadPath, size, "euc-kr", new DefaultFileRenamePolicy());

				String fileName = (String)multi.getFileNames().nextElement();
				tc.setOriginalPictureName(multi.getOriginalFileName(fileName));
				tc.setUploadedPictureName(multi.getFilesystemName(fileName));
				tc.setHanMaDi(multi.getParameter("hanMaDi"));
				tc.setTeacherId(multi.getParameter("teacherId"));
				tc.setYakRyeok(multi.getParameter("yakRyeok"));
				//50: ���� ���ε� �Ϸ�. 52~57:teacher��ü �غ�Ϸ�
			} catch( Exception e ) {
				e.printStackTrace();
			}
			
			teacherDao.inputTeacher(tc); //�Ʊ� �غ�� teacher��ü�� �����ͺ��̽��� ����
		}
		
		//if���� �ٱ��̴�. ��Ƽ��Ʈ���� �ƴϾ ����-���� �����Ե� �ҷ�����
		List<Teacher> teachers = teacherDao.getAllTeachers();
		request.setAttribute("teachers", teachers);
		
		ActionForward forward = new ActionForward();
		forward.setUrl("teacherManage.jsp");
		return forward;
	}

}
