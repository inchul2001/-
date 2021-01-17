package util;

public class MyDebug {
	public void print(String s ) {
		String str = this.getClass().getName();
		System.out.println(str+":"+s);
	}

}
