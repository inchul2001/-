package vo;

public class TestInfo {
	
	private int indivScoreNum ;
	private String studentID;	//이건 생략 가능할수도 있음
	private String testId ;
	private int studentAge;
	
	private String baejumString ;
	
	private String correctAnswerString ;
	private String yourAnswerString;
	
	private float totalScore ;
	private float yourScore;
	
	private float totalAverage;
	private float ageAverage;
	
	private String totalDistribution;	
	private String ageDistribution;
	
	private int totalRanking;
	private int ageRanking;
	
	private String comments;

	private String uploadedFileName;	//실제로 업로드된 파일이름(이걸로 다운로드 경로를 만들어야하겟지)
	private String originalFileName;	//내가 정했던 파일 이름(이걸로 표시해주고)
	

	@Override
	public String toString() {
		return "TestInfo [indivScoreNum=" + indivScoreNum + ", studentID=" + studentID + ", testId=" + testId
				+ ", studentAge=" + studentAge + ", baejumString=" + baejumString + ", correctAnswerString="
				+ correctAnswerString + ", yourAnswerString=" + yourAnswerString + ", totalScore=" + totalScore
				+ ", yourScore=" + yourScore + ", totalAverage=" + totalAverage + ", ageAverage=" + ageAverage
				+ ", totalDistribution=" + totalDistribution + ", ageDistribution=" + ageDistribution
				+ ", totalRanking=" + totalRanking + ", ageRanking=" + ageRanking + ", comments=" + comments + "]";
	}

	public int getIndivScoreNum() {
		return indivScoreNum;
	}

	public void setIndivScoreNum(int indivScoreNum) {
		this.indivScoreNum = indivScoreNum;
	}

	public String getStudentID() {
		return studentID;
	}

	public void setStudentID(String studentID) {
		this.studentID = studentID;
	}

	public String getTestId() {
		return testId;
	}

	public void setTestId(String testId) {
		this.testId = testId;
	}

	public int getStudentAge() {
		return studentAge;
	}

	public void setStudentAge(int studentAge) {
		this.studentAge = studentAge;
	}

	public String getBaejumString() {
		return baejumString;
	}

	public void setBaejumString(String baejumString) {
		this.baejumString = baejumString;
	}

	public String getCorrectAnswerString() {
		return correctAnswerString;
	}

	public void setCorrectAnswerString(String correctAnswerString) {
		this.correctAnswerString = correctAnswerString;
	}

	public String getYourAnswerString() {
		return yourAnswerString;
	}

	public void setYourAnswerString(String yourAnswerString) {
		this.yourAnswerString = yourAnswerString;
	}

	public float getTotalScore() {
		return totalScore;
	}

	public void setTotalScore(float totalScore) {
		this.totalScore = totalScore;
	}

	public float getYourScore() {
		return yourScore;
	}

	public void setYourScore(float yourScore) {
		this.yourScore = yourScore;
	}

	public float getTotalAverage() {
		return totalAverage;
	}

	public void setTotalAverage(float totalAverage) {
		this.totalAverage = totalAverage;
	}

	public float getAgeAverage() {
		return ageAverage;
	}

	public void setAgeAverage(float ageAverage) {
		this.ageAverage = ageAverage;
	}

	public String getTotalDistribution() {
		return totalDistribution;
	}

	public void setTotalDistribution(String totalDistribution) {
		this.totalDistribution = totalDistribution;
	}

	public String getAgeDistribution() {
		return ageDistribution;
	}

	public void setAgeDistribution(String ageDistribution) {
		this.ageDistribution = ageDistribution;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public int getTotalRanking() {
		return totalRanking;
	}

	public void setTotalRanking(int totalRanking) {
		this.totalRanking = totalRanking;
	}

	public int getAgeRanking() {
		return ageRanking;
	}

	public void setAgeRanking(int ageRanking) {
		this.ageRanking = ageRanking;
	}

	public String getUploadedFileName() {
		return uploadedFileName;
	}

	public void setUploadedFileName(String uploadedFileName) {
		this.uploadedFileName = uploadedFileName;
	}

	public String getOriginalFileName() {
		return originalFileName;
	}

	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	
	
}
