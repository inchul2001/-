package vo;

import java.sql.Date;

public class TestMetaData {
	private String testId;	//�⺻Ű�̰�, �ڵ����� �ƴϴ�.
	private Date testDate;	//���⼭ date�� sql�� date
	private String baejumString;
	private String answerString;
	private String description;
	private String testRange;
	private String uploadedFileName;	//������ ���ε�� �����̸�(�̰ɷ� �ٿ�ε� ��θ� �������ϰ���)
	private String originalFileName;	//���� ���ߴ� ���� �̸�(�̰ɷ� ǥ�����ְ�)
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
