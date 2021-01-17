package vo;

import java.sql.Date;
import java.sql.Time;
import java.util.List;

public class AttendanceStatus {		//�̰� n���� ������ arrayList�� ���������� Ŭ���̾�Ʈ�� �������� �����̴�..
	private Date date;
	private int day;		//�Ͽ����� 0 ~ ������� 6
	
	private Time shouldComeTime;	//sugang ���̺��� ��������  scheduleOfWeek Array�� �ϼ�, ������ ä��� ���� �������� scheduleOfWeek �������� ä�� ����.
	private Time shouldGoTime;		// �̶�, �ڷ����� ������ �ɰ��ε�.. �� ��ü�� pseudoSetter�� ���� 1~13 ������ int�� 9:00 ~ 22:00 ���� �Է¹޵��� �ߴ�. (��Ȯ���� 10�о� ����)
	
	private Time earlyComeTime;		//attendance ���̺��� �����ϴ� ���ۿ� ���µ�...
	private Time lateGoTime;		//���� ��¥ + �ùٸ� �л� ���̵�. �� ���� �����͵��� �ҷ�����, �³׸� ����Ʈ�� ��Ƽ� for�� ������ ���ۿ� ����.
	
	private List<Attendance> atdcOfTheDay ;
	
	// a.after(b) ��a�� b���� �ʴٸ� true
	public String statusCalc() {
		String answer = null ;
		if( shouldComeTime == null || shouldGoTime == null)
			answer ="���� ���� ��";
		else if( earlyComeTime == null && lateGoTime == null)
			answer = "�Ἦ";
		else if( shouldComeTime.after(earlyComeTime) && shouldGoTime.before(lateGoTime) )
			answer = "�⼮";
		else if( shouldComeTime.before(earlyComeTime) && shouldGoTime.before(lateGoTime) )
			answer = "����";
		else if( shouldComeTime.before(earlyComeTime) && shouldGoTime.after(lateGoTime) )
			answer = "����&����";
		else if( shouldComeTime.after(earlyComeTime) && shouldGoTime.after(lateGoTime) )
			answer = "����";
		
		return answer ;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = new Date( date.getTime());
	}

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public Time getShouldComeTime() {
		return shouldComeTime;
	}

	public void pseudoSetShouldComeTime(int time) {
		if( ( time == 0 ) || ( time == 14 ) ) {
			this.shouldComeTime = null;
		} else {
			this.shouldComeTime = new Time(8+time,10,0);
		}
	}

	public Time getShouldGoTime() {
		return shouldGoTime;
	}

	public void pseudoSetShouldGoTime(int time) {
		if( ( time == 0 ) || ( time == 14) ) {
			this.shouldGoTime = null;
		} else {
			this.shouldGoTime = new Time(8+time,50,0);
		}
		
	}

	public Time getEarlyComeTime() {
		return earlyComeTime;
	}

	public void pseudoSetEarlyComeTime(Time earlyComeTime) {
		if( this.earlyComeTime!= null && earlyComeTime != null) {
			if( this.earlyComeTime.after(earlyComeTime))
				this.earlyComeTime = earlyComeTime;			
		}
		else if( earlyComeTime != null )
			this.earlyComeTime = earlyComeTime;
	}

	public Time getLateGoTime() {
		return lateGoTime;
	}

	public void pseudoSetLateGoTime(Time lateGoTime) {
		if( this.lateGoTime!= null && lateGoTime != null) {
			if( this.lateGoTime.before(lateGoTime))
				this.lateGoTime = lateGoTime;
		} else if (lateGoTime != null) {
			this.lateGoTime = lateGoTime;
		}
	}

	@Override
	public String toString() {
		return "\n\nAttendanceStatus [date=" + date + ", day=" + day + "\n, shouldComeTime=" + shouldComeTime
				+ ", shouldGoTime=" + shouldGoTime + "\n, earlyComeTime=" + earlyComeTime + ", lateGoTime=" + lateGoTime
				+ "\n, statusCalc()=" + statusCalc() + "\n, getDate()=" + getDate() + ", getDay()=" + getDay()
				+ "\n, getShouldComeTime()=" + getShouldComeTime() + ", getShouldGoTime()=" + getShouldGoTime()
				+ "\n, getEarlyComeTime()=" + getEarlyComeTime() + ", getLateGoTime()=" + getLateGoTime()
				+ "\n, getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}

	public List<Attendance> getAtdcOfTheDay() {
		return atdcOfTheDay;
	}

	public void setAtdcOfTheDay(List<Attendance> atdcOfTheDay) {
		this.atdcOfTheDay = atdcOfTheDay;
	}
	
	
	
}
