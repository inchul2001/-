package defaultPackage;

import java.sql.* ;
import java.util.Properties;

public class Test {
	public static void main(String[] args) {
		//String driver = "oracle.jdbc.driver.OracleDriver";
		String driver = "com.mysql.jdbc.Driver";
		
		//String url = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC&useSSL=false";
		String url = "jdbc:mysql://localhost:3306/mathcode?serverTimezone=Asia/Seoul";
		
		
		Properties properties = new Properties();
		properties.setProperty("user", "Admin");
		properties.setProperty("password", "1234");
		properties.setProperty("useSSL", "false");
		properties.setProperty("autoReconnect", "true");

		
		try {
			Class.forName(driver);
			System.out.println("jdbc driver 로딩 성공");
			
			DriverManager.getConnection(url, properties);
			System.out.println("mysql 연결 성공");
		} catch (ClassNotFoundException e) {
			System.out.println("jdbc driver 로딩 실패");
		} catch (SQLException e) {
			System.out.println("mysql 연결 실패");
		}
	}
}