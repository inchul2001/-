package vo;

public class StudentBasic {
	private String studentId;
	private String studentPassword;
	private String studentName;
	private int studentAge;
	private String studentSchool;	
	private String studentPhone;
	private String studentMotherPhone;
	
	public void print() {
		System.out.println("ValueObject-StudentBasic : ");
		System.out.println(" studentId : " + studentId );
		System.out.println(" studentPassword : " + studentPassword );
		System.out.println(" studentName : " + studentName );
		System.out.println(" studentAge : " + studentAge );
		System.out.println(" studentSchool : " + studentSchool );
		System.out.println(" studentPhone : " + studentPhone );
		System.out.println(" studentMotherPhone : " + studentMotherPhone );
		System.out.println();
		
	}	
	
	public String getStudentSchool() {
		return studentSchool;
	}
	public void setStudentSchool(String studentSchool) {
		this.studentSchool = studentSchool;
	}
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getStudentPassword() {
		return studentPassword;
	}
	public void setStudentPassword(String studentPassword) {
		this.studentPassword = studentPassword;
	}
	public int getStudentAge() {
		return studentAge;
	}
	public void setStudentAge(int studentAge) {
		this.studentAge = studentAge;
	}
	public String getStudentPhone() {
		return studentPhone;
	}
	public void setStudentPhone(String studentPhone) {
		this.studentPhone = studentPhone;
	}
	public String getStudentMotherPhone() {
		return studentMotherPhone;
	}
	public void setStudentMotherPhone(String studentMotherPhone) {
		this.studentMotherPhone = studentMotherPhone;
	}
	
	
	

}
