package util;

import java.sql.*;
import java.util.Properties;

public class DbUtil {
      static{
    	  try{
    		  Class.forName("com.mysql.jdbc.Driver");	//
    		  //Class : �ڹ� API���� �����Ǵ� Ŭ����
    		  //forName : �Ķ���ͷ� ������ Ŭ������ �ν��Ͻ� �޸𸮿� �ø��� ������ �ϴ� �޼ҵ�
    		  //���� ���ϸ� ����Ŭ�� ���ø����̼��� �����ϱ� ���� ����Ŭ ����̹��� �޸𸮷� �ø��� �κ�
    	  }
    	  catch(ClassNotFoundException e){
    		  e.printStackTrace();
    	  }
      }
      public static Connection getConnection(){
    	  
  		String url = "jdbc:mysql://localhost:3306/mathcode?serverTimezone=Asia/Seoul";
		
  		Properties properties = new Properties();
  		properties.setProperty("user", "Admin");
  		properties.setProperty("password", "1234");
  		properties.setProperty("useSSL", "false");
  		properties.setProperty("allowPublicKeyRetrieval", "true");
  		properties.setProperty("autoReconnect", "true");
  	  
    	Connection con=null;
    	try{
    		con = DriverManager.getConnection(url, properties);
    		con.setAutoCommit(false);
    	}
    	catch(SQLException e){
    		e.printStackTrace();
    	}
    	return con;
      }
      public static void close(Connection con){
    	  try{
    		  con.close();
    	 }
    	  catch(Exception e){
    		  e.printStackTrace();
    	  }
      }
      public static void close(Statement stmt){
    	  try{
    		  stmt.close();
    	 }
    	  catch(Exception e){
    		  e.printStackTrace();
    	  }
      }
      
      public static void close(ResultSet rs){
    	  try{
    		  rs.close();
    	 }
    	  catch(Exception e){
    		  e.printStackTrace();
    	  }
    	  
      }
      
      public static void commit(Connection con){
    	  try{
    		  con.commit();
    		  System.out.println("commit success");
    	  }
    	  catch(Exception e){
    		  System.out.println("commit fail");}}
    		  
      public static void rollback(Connection con){
    	  try{
    		  con.rollback();
    		  System.out.println("rollback success");
    	  }
    	  catch(Exception e){
    		  System.out.println("rollback fail");
    	  }
      }
}

