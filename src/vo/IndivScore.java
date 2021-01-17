package vo;

public class IndivScore {
	
	private int indivScoreNum; //PrimaryKey이고, 자동생성
	private String studentId;
	private String testId;
	private String indivAnswerString;
	private float score ;
	private int studentAge;
	private String comment;
	
	public int getIndivScoreNum() {
		return indivScoreNum;
	}
	public void setIndivScoreNum(int indivScoreNum) {
		this.indivScoreNum = indivScoreNum;
	}
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	public String getTestId() {
		return testId;
	}
	public void setTestId(String testId) {
		this.testId = testId;
	}
	public String getIndivAnswerString() {
		return indivAnswerString;
	}
	public void setIndivAnswerString(String indivAnswerString) {
		this.indivAnswerString = indivAnswerString;
	}
	public float getScore() {
		return score;
	}
	public void setScore(float score) {
		this.score = score;
	}
	
	public int getStudentAge() {
		return studentAge;
	}
	public void setStudentAge(int studentAge) {
		this.studentAge = studentAge;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	
	
	
	
}
