package defaultPackage;

import static util.DbUtil.getConnection;

import java.sql.Connection;
import java.util.List;

import dao.IndivScoreDao;
import vo.TestInfo;

public class DebugPurpose {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Connection con = getConnection();
		IndivScoreDao dao = new IndivScoreDao( con );
		
		List<TestInfo> list = dao.getAllTestInfoByStudentId("psg2002");
		for( int i = 0 ; i < list.size() ; i++ ) {
			System.out.println(list.get(i).toString() );
		}
		
		
	}

}
