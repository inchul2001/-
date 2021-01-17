package vo;

import java.sql.Date;
import java.sql.Time;

public class Example {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		java.util.Date d1 = new java.util.Date();
		System.out.println(d1);	//Sun Dec 27 14:36:09 KST 2020
		
		java.sql.Date d2 = new java.sql.Date(2004, 10, 2);
		System.out.println(d2);//3904-11-02
		
		java.sql.Time d3 = new java.sql.Time(15, 15, 15) ;
		System.out.println(d3);//15:15:15

		d2 = new java.sql.Date(d1.getTime());
		System.out.println(d2);//2020-12-27

		d3 = new java.sql.Time(d1.getTime());
		System.out.println(d3);//14:36:09

	}

}
