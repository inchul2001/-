package vo;

import java.sql.Date;
import java.sql.Time;
import java.util.List;

public class AttendanceStatus {		//이거 n개로 구성된 arrayList를 최종적으로 클라이언트에 전달해줄 생각이다..
	private Date date;
	private int day;		//일요일은 0 ~ 토요일은 6
	
	private Time shouldComeTime;	//sugang 테이블의 내용으로  scheduleOfWeek Array를 완성, 요일을 채우고 나면 나머지는 scheduleOfWeek 기준으로 채울 생각.
	private Time shouldGoTime;		// 이때, 자료형이 문제가 될것인데.. 이 객체에 pseudoSetter를 만들어서 1~13 사이의 int를 9:00 ~ 22:00 으로 입력받도록 했다. (정확히는 10분씩 여유)
	
	private Time earlyComeTime;		//attendance 테이블을 참조하는 수밖에 없는데...
	private Time lateGoTime;		//같은 날짜 + 올바른 학생 아이디. 를 갖는 데이터들을 불러오고, 걔네를 리스트에 담아서 for문 돌리는 수밖에 없다.
	
	private List<Attendance> atdcOfTheDay ;
	
	// a.after(b) ㅁa가 b보다 늦다면 true
	public String statusCalc() {
		String answer = null ;
		if( shouldComeTime == null || shouldGoTime == null)
			answer ="수업 없는 날";
		else if( earlyComeTime == null && lateGoTime == null)
			answer = "결석";
		else if( shouldComeTime.after(earlyComeTime) && shouldGoTime.before(lateGoTime) )
			answer = "출석";
		else if( shouldComeTime.before(earlyComeTime) && shouldGoTime.before(lateGoTime) )
			answer = "지각";
		else if( shouldComeTime.before(earlyComeTime) && shouldGoTime.after(lateGoTime) )
			answer = "지각&조퇴";
		else if( shouldComeTime.after(earlyComeTime) && shouldGoTime.after(lateGoTime) )
			answer = "조퇴";
		
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
