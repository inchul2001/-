package defaultPackage;

import java.sql.Date;
import java.sql.Time;

public class TestAboutDate {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
/*
		Date d = new Date(0, 0,0);
		System.out.println(d); //1899-12-31
		for(int i = 0 ; i < 100 ; i++) {
			d.setDate(d.getDate()+1);
			System.out.println(d);
		}
	*/
		Time t = new Time(0, 0,0);
		System.out.println(t);
		for(int i = 0 ; i < 100 ; i++ ) {
			t.setHours(t.getHours()+1);
			System.out.println(t);
		}
	}

}
