package vo;

import java.sql.Date;

public class TestMetaData {
	private String testId;	//기본키이고, 자동생성 아니다.
	private Date testDate;	//여기서 date는 sql의 date
	private String baejumString;
	private String answerString;
	private String description;
	private String testRange;
	private String uploadedFileName;	//실제로 업로드된 파일이름(이걸로 다운로드 경로를 만들어야하겟지)
	private String originalFileName;	//내가 정했던 파일 이름(이걸로 표시해주고)
	private float totalScore;
	
	
	
	@Override
	public String toString() {
		return "TestMetaData [testId=" + testId + ", testDate=" + testDate + ", baejumString=" + baejumString
				+ ", answerString=" + answerString + ", description=" + description + ", testRange=" + testRange
				+ ", uploadedFileName=" + uploadedFileName + ", originalFileName=" + originalFileName + ", totalScore="
				+ totalScore + "]";
	}
	public String getTestId() {
		return testId;
	}
	public void setTestId(String testId) {
		this.testId = testId;
	}
	
	public String getBaejumString() {
		return baejumString;
	}
	public void setBaejumString(String baejumString) {
		this.baejumString = baejumString;
	}
	public String getAnswerString() {
		return answerString;
	}
	public void setAnswerString(String answerString) {
		this.answerString = answerString;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getTestRange() {
		return testRange;
	}
	public void setTestRange(String testRange) {
		this.testRange = testRange;
	}
	public String getuploadedFileName() {
		return uploadedFileName;
	}
	public void setuploadedFileName(String uploadedfileName) {
		this.uploadedFileName = uploadedfileName;
	}	
	
	public String getoriginalFileName() {
		return originalFileName;
	}
	public void setoriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public Date getTestDate() {
		return testDate;
	}
	public void setTestDate(Date date) {
		this.testDate = date;
	}
	public float getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(float totalScore) {
		this.totalScore = totalScore;
	}
	
	
}
