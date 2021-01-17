<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.*"%>

<%@page import="vo.AttendanceStatus" %>
<%@page import="vo.TestInfo"%>
<%@page import="vo.StudentBasic"%>
<%@page import="vo.Lecture"%>
<%@page import="vo.Teacher"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%
List<AttendanceStatus> atdcStats = (List<AttendanceStatus>) request.getAttribute("attendanceStatuses");
List<TestInfo> testInfos = (List<TestInfo>) request.getAttribute("testInfos");
StudentBasic studentBasic = (StudentBasic) request.getAttribute("studentBasic");

List<Lecture> lectures = (List<Lecture>) request.getAttribute("lectures");
List<Teacher> teachers = (List<Teacher>) request.getAttribute("teachers");
%>

<!DOCTYPE html>
<html>
<script>//자바 atdcStatus 를 자바스크립트로 옮기기.
	class AttendanceStatus {
		constructor(date, day, shouldComeTime, shouldGoTime, earlyComeTime, lateGoTime, status ,attendances) {
			this.date = new Date(date), this.day = day, 
			this.shouldComeTime = shouldComeTime , this.shouldGoTime = shouldGoTime, 
			this.earlyComeTime = earlyComeTime , this.lateGoTime = lateGoTime, this.status = status,
			this.attendances = attendances
		}

	}
	class Attendance {
		constructor( attendanceNum , comeTime, goTime ) {
			this.attendanceNum = attendanceNum, this.comeTime = comeTime, this.goTime = goTime		
		}
	}
	
	var atdcStats = new Array();
	let atdcStat;
	var atdcs;
	let atdc;
	<%
	if( atdcStats != null ) 
		for( int i = 0 ; i < atdcStats.size() ; i++ ) {
			Date date = atdcStats.get(i).getDate();
			int day = atdcStats.get(i).getDay();
			Time shouldComeTime = atdcStats.get(i).getShouldComeTime();
			Time shouldGoTime = atdcStats.get(i).getShouldGoTime();
			Time earlyComeTime = atdcStats.get(i).getEarlyComeTime();
			Time lateGoTime = atdcStats.get(i).getLateGoTime();
			String status = atdcStats.get(i).statusCalc();
			%>
			
			atdcs = new Array();
			<%
			for( int j = 0 ; j < atdcStats.get(i).getAtdcOfTheDay().size(); j++) {
				int attendanceNum = atdcStats.get(i).getAtdcOfTheDay().get(j).getAttendanceNum();
				Time comeTime = atdcStats.get(i).getAtdcOfTheDay().get(j).getComeTime();
				Time goTime = atdcStats.get(i).getAtdcOfTheDay().get(j).getGoTime();
				%>
				atdc = new Attendance(<%=attendanceNum%>,'<%=comeTime%>','<%=goTime%>');
				atdcs.push(atdc);
				<%
			}
			%>
			atdcStat = new AttendanceStatus('<%=date %>', <%=day %>, 
					'<%=shouldComeTime %>', '<%=shouldGoTime %>', 
					'<%=earlyComeTime %>', '<%=lateGoTime %>', '<%=status %>', atdcs);
			atdcStats.push(atdcStat);
			<%
		}
	%>
	var todayDate = new Date();		//얘의 용도는 아직 오지 않은 날들을 판별해서 결석 => 수업있는날로 바꿔주는것.
	todayDate.setHours(9,0,0,0);
	for( var  i = 0 ; i < atdcStats.length ; i++ ) {
		if( atdcStats[i].date > todayDate) 
			if( atdcStats[i].status == "결석")
				atdcStats[i].status = '학원 오는 날';
	}
	var calendarTargetMonth = new Date();
</script>

<script>//자바 testInfos 를 자바스크립트로 옮기기.
class TestInfo {
	constructor(indivScoreNum, studentId, testId, studentAge, baejumString, correctAnswerString, yourAnswerString, totalScore, yourScore, totalAverage, ageAverage, totalDistribution, ageDistribution, totalRanking, ageRanking, comments, uploadedFileName, originalFileName ) {
		this.indivScoreNum = indivScoreNum, this.studentId = studentId,
		this.testId = testId, this.studentAge = studentAge, 
		
		this.baejumString = baejumString.split('#'),
		this.correctAnswerString = correctAnswerString.split('#'), 
		this.yourAnswerString = yourAnswerString.split('#'), 
		
		this.totalScore = totalScore, this.yourScore = yourScore, 
		this.totalAverage = totalAverage, this.ageAverage = ageAverage, 
		
		this.totalDistribution = totalDistribution.substring(1, totalDistribution.length-1).split(', '), 
		this.ageDistribution = ageDistribution.substring(1, totalDistribution.length-1).split(', '),
		
		this.totalRanking = totalRanking, this.ageRanking = ageRanking,
		this.comments = comments;
		
		this.uploadedFileName = uploadedFileName;
		this.originalFileName = originalFileName;
		
		this.baejumString.pop();
		this.correctAnswerString.pop();
		this.yourAnswerString.pop();		//완-벽... 형 변환까지 모두 마쳤다..!
	}
}
var testInfos = new Array();
let testInfo;
<%
if( testInfos != null )
	for(int i = 0 ; i < testInfos.size() ; i++ ) {
		int indivScoreNum = testInfos.get(i).getIndivScoreNum();
		String studentId = testInfos.get(i).getStudentID();
		String testId = testInfos.get(i).getTestId();
		int studentAge = testInfos.get(i).getStudentAge();
		
		String baejumString = testInfos.get(i).getBaejumString();
		
		String correctAnswerString = testInfos.get(i).getCorrectAnswerString();
		String yourAnswerString = testInfos.get(i).getYourAnswerString();
		
		float totalScore = testInfos.get(i).getTotalScore();
		float yourScore = testInfos.get(i).getYourScore();
		
		float totalAverage = testInfos.get(i).getTotalAverage();
		float ageAverage =  testInfos.get(i).getAgeAverage();
		
		String totalDistribution = testInfos.get(i).getTotalDistribution();
		String ageDistribution = testInfos.get(i).getAgeDistribution();
		
		int totalRanking = testInfos.get(i).getTotalRanking();
		int ageRanking = testInfos.get(i).getAgeRanking();
		
		String comments = testInfos.get(i).getComments();
		
		String uploadedFileName = testInfos.get(i).getUploadedFileName();
		String originalFileName = testInfos.get(i).getOriginalFileName();
		
		%>
		testInfo = new TestInfo(<%=indivScoreNum %>, '<%=studentId %>', '<%=testId %>', <%=studentAge %>, '<%=baejumString %>' ,
								'<%=correctAnswerString %>', '<%=yourAnswerString %>', <%=totalScore %>, <%=yourScore %>, 
								<%=totalAverage %>, <%=ageAverage %>, '<%=totalDistribution %>', '<%=ageDistribution %>', 
								<%=totalRanking %>, <%=ageRanking %>, '<%=comments %>', '<%=uploadedFileName%>','<%=originalFileName%>');
		testInfos.push(testInfo)
		<%

	}
%>
</script>

<script>//자바 studentBasic 을 자바스크립트로 옮기기.
var studentId = '<%=studentBasic.getStudentId() %>';
var studentPassword = '<%=studentBasic.getStudentPassword() %>';
var studentName = '<%=studentBasic.getStudentName() %>';
var studentAge = <%=studentBasic.getStudentAge() %>;
var studentSchool = '<%=studentBasic.getStudentSchool() %>';
var studentPhone = '<%=studentBasic.getStudentPhone() %>';
var studentMotherPhone = '<%=studentBasic.getStudentMotherPhone() %>';
</script>

<script>//자바 lectures 를 자바스크립트로 옮기기.
class Lecture {
	constructor(lectureId, day, time, classroom, teacherId, capacity){
		this.lectureId = lectureId, this.day = day, this.time = time, 
		this.classroom = classroom, this.teacherId = teacherId, this.capacity = capacity 
	}
}
var lectures = new Array();
let lecture ;
<%
for( int i = 0 ; i < lectures.size() ; i++) {
	int lectureId = lectures.get(i).getLectureId();
	int day = lectures.get(i).getDay();
	int time = lectures.get(i).getTime();
	String classroom = lectures.get(i).getClassroom();
	String teacherId = lectures.get(i).getTeacherId();
	int capacity = lectures.get(i).getCapacity();
	
	%>
	lecture = new Lecture(<%=lectureId%>, <%=day%>, <%=time%>, '<%=classroom%>', '<%=teacherId%>', <%=capacity%>);
	lectures.push(lecture);
	<%
}
%>

</script>

<script>//자바 teachers를 자바스크립트로 옮기기..
class Teacher{
	constructor(teacherId, uploadedPictureName, yakRyeok, hanMaDi) {
		this.teacherId = teacherId, this.uploadedPictureName = uploadedPictureName, 
		this.yakRyeok = yakRyeok, this.hanMaDi = hanMaDi
	}
}
var teachers = new Array();
let teacher ;

<%
for( int i = 0 ; i < teachers.size() ; i++ ) {
	String teacherId = teachers.get(i).getTeacherId();
	String uploadedPictureName = teachers.get(i).getUploadedPictureName();
	String yakRyeok = teachers.get(i).getYakRyeok();
	String hanMaDi = teachers.get(i).getHanMaDi();
	
	%> 
	teacher = new Teacher('<%=teacherId%>','<%=uploadedPictureName%>','<%=yakRyeok%>','<%=hanMaDi%>') ;
	teachers.push(teacher);
	<%
}
%>
</script>

<head><meta charset="EUC-KR">
<title>학생 로그인 화면입니다.</title>
</head>
<body>
<!-- --------------------------------------------아래 6줄: 솔직히 뭐가 뭔지 모르겠지만 여기에 두자.--------------------------------------------------- -->
<!-- 부트스트랩 --> 
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script> 
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script> 
<!-- 차트 --> 
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script> 

<script>//===============================================아래: summaryHTMLCode의 내용
function summaryShow() {
	alert("summaryShow() 호출됨");
	var summaryHTMLCode = '<div id="testStatisticsPos"></div><div id="calendarPos"></div>';
	mainContentsPos.innerHTML = summaryHTMLCode;
	oneTestStatisticsShow(0);
	calendarMaker(todayDate);
}
</script>

<script>//===============================================아래: testDetailHTMLCode
function testShow() {
	alert("testShow() 호출됨");
	var testDetailHTMLCode = 	'<div>' + 
								'<table border=1><tr><td><div id="testStatisticsPos"></div></td>' + 
										   '</tr><tr><td><div id="answerSheetPos"></div></td>' + 
										   '</tr><tr><td><div id="testListPos"></div></td>' + 
								'</tr></table>' + 
							'</div>';
	mainContentsPos.innerHTML = testDetailHTMLCode;
	oneTestStatisticsShow(0);
	answerSheetShow(0);
	testListShow();
}
</script>

<script>//===============================================아래: attendDetailHTMLCode(시작도 안함)
function attendShow() {
	alert("attendShow() 호출됨");
	calendarTargetMonth = new Date();
	var attendDetailHTMLCode = '<table></tr><td colspan=2><div id="calendarPos"></div></td></tr>'
								+'<tr><td><input type="button" value="이전달" onclick="previousMonthClicked(calendarTargetMonth)"></td>'
								+'<td><input type="button" value="다음달" onclick="nextMonthClicked(calendarTargetMonth)"></td></tr>'
								+'</table><div id="dateInfoPos"></div>';
	mainContentsPosition.innerHTML = attendDetailHTMLCode;
	calendarMaker(calendarTargetMonth);
	
}
</script>

<script>//===============================================아래: basicInfoModifyHTMLCode
function infoModiFyShow() {
	alert("infoModiFyShow() 호출됨");
	var basicInfoModifyHTMLCode =
		'<div><form action="login.common" method="post"><input type="hidden" name="recursive" value="fromStudentSelfModify"><table border=1>' + 
		'<tr><td></td><td>현재값</td><td>변경값</td></tr>' + 
		'<tr><td>학생Id</td><td>'+studentId+'</td><td><input type="text" disabled></td></tr>' + 
		'<tr><td>비밀번호</td><td>'+studentPassword+'</td><td><input type="text" name="studentPassword"></td></tr>' + 
		'<tr><td>이름</td><td>'+studentName+'</td><td><input type="text" name="studentName"></td></tr>' + 
		'<tr><td>나이</td><td>'+studentAge+'</td><td><input type="number" name="studentAge"></td></tr>' + 
		'<tr><td>학교</td><td>'+studentSchool+'</td><td><input type="text" name="studentSchool"></td></tr>' + 
		'<tr><td>핸드폰</td><td>'+studentPhone+'</td><td><input type="text" name="studentPhone"></td></tr>' + 
		'<tr><td>부모님연락처</td><td>'+studentMotherPhone+'</td><td><input type="text" name="studentMotherPhone"></td></tr>' + 
		'<tr><td colspan=3><input type="hidden" name="studentId" value="'+studentId+'"><input type="submit" value="제출하기"></td></tr>' + 
		'</table></form></div>' ;
	mainContentsPosition.innerHTML = basicInfoModifyHTMLCode;
}
</script>

<script>//===============================================아래: sugangSincheong()
function sugangSincheong() {
	var sugangHTMLCode = '<div><table><tr><td colspan=4>선생님 선택하기</td></tr><tr>';
	for( var i = 0 ; i < teachers.length ; i++ ) {
		sugangHTMLCode +='<td><table border=1><tr><td><img src="../upload/'+teachers[i].uploadedPictureName+'" alt="" width="58px" height="43px"></td></tr>'
						+'<tr><td>'+teachers[i].teacherId+'</td></tr>'
						+'<tr><td>'+teachers[i].yakRyeok+'</td></tr>'
						+'<tr><td>'+teachers[i].hanMaDi+'</td></tr>'
						+'<tr><td><input type="button" value="선택" onclick="afterTeacherSelected('+i+')"></td></tr></table></td>';
		if( i % 4 == 3 ) 
			sugangHTMLCode += '</tr><tr>';

	}
	sugangHTMLCode += '</tr></table></div><div id="timeTablePos"></div>';
	
	mainContentsPos.innerHTML = sugangHTMLCode;
}

</script>

<script>//===============================================아래: sideMenuHTMLCode, hideMenuHTMLCode, showMenuHTMLCode
function sideMenuHTMLCodeMaker() {
	sideMenuHTMLCode +=
		'<table border=1><tr><td><input type=button value="메인화면" onclick="summaryShow()" mcIndex="1"></td></tr>'
		+'<tr><td><input type=button value="시험상세" onclick="testShow()" mcIndex="2"></td></tr>'
		+'<tr><td><input type=button value="출결상세" onclick="attendShow()" mcIndex="3"></td></tr>'
		+'<tr><td><input type=button value="정보수정" onclick="infoModiFyShow()" mcIndex="4"></td></tr>'
		+'<tr><td><input type=button value="수강신청" onclick="sugangSincheong()" mcIndex="5"></td></tr>'
		+'<tr><td><button><a href="logout.common">로그아웃</a></button></td></tr>' ;
	sideMenuPosition.innerHTML = sideMenuHTMLCode;
};

function showMenu() {
	showMenuHTMLCode ='';
	showMenuButtonPosition.innerHTML = showMenuHTMLCode;
	
	hideMenuHTMLCode += '<input type=button value="사이드 메뉴 닫기 " onclick="hideMenu()">';
	hideMenuButtonPosition.innerHTML = hideMenuHTMLCode;
	
	isSideMenuAppear = "true";
	sideMenuHTMLCodeMaker();
};

function hideMenu() {
	hideMenuHTMLCode = '';
	hideMenuButtonPosition.innerHTML = hideMenuHTMLCode;
	
	showMenuHTMLCode += '<input type=button value="사이드 메뉴 열기" onclick="showMenu()">';
	showMenuButtonPosition.innerHTML = showMenuHTMLCode;
	
	isSideMenuAppear = "false";
	sideMenuHTMLCode ='';
	sideMenuPosition.innerHTML = sideMenuHTMLCode;
};

</script>

<!-------------------------------------- 아래: 각종 2차 호출 함수들. ---------------------------------------->
<!--  -->
<script>//===============================================oneTestStatisticsShow(testIndex)
function oneTestStatisticsShow(testIndex) {
	var selectedTest = testInfos[testIndex];
	var HTMLCode = 
		'<table><tr><td><table border=1>'
		+ '<tr><td colspan=3>선택된 시험</td></tr>'
		+ '<tr><td colspan=3><div id="graphPos"></div></td></tr><tr>'
		+ '<td id="rankingPos"></td><td id="averagePos"></td><td>동년배통계치 보기<input type=checkBox onclick="selectTotalOrAge(this, '+testIndex+')"></td>'
				
		+ '</tr></table></td></tr>'
		+ '<tr><td><table border=1>'
		+ '<tr><td>시험ID</td><td>'+selectedTest.testId+'</td>'
		+ '<td>응시번호</td><td>'+selectedTest.indivScoreNum+'</td></tr>'
		+ '<tr><td>점수/총점</td><td>'+selectedTest.yourScore+'/'+selectedTest.totalScore+'</td>'
		+ '<td>기타</td><td>'+selectedTest.comments+'</td></tr>'
		+ '</table></td></tr></table>';
	document.getElementById("testStatisticsPos").innerHTML = HTMLCode;
	
	var numberOfApplicants = 0 ;
	drawGraph(selectedTest.totalDistribution);
	for( var i = 0 ; i < selectedTest.totalDistribution.length; i++) 
		numberOfApplicants +=  parseInt(selectedTest.totalDistribution[i]) ;
	document.getElementById("rankingPos").innerHTML = selectedTest.totalRanking + '/' + numberOfApplicants + ' 등';
	document.getElementById("averagePos").innerHTML = '평균: ' +selectedTest.totalAverage;
}
</script>
<!--  -->
<script>//=======================================================selectTotalOrAge(obj, testIndex)
function selectTotalOrAge(obj, testIndex) {
	var selectedTest = testInfos[testIndex];
	var numberOfApplicants = 0 ;
	if ( obj.checked ){
		alert("방금 체크함");
		drawGraph(selectedTest.ageDistribution);
		for( var i = 0 ; i < selectedTest.ageDistribution.length; i++) 
			numberOfApplicants +=  parseInt(selectedTest.ageDistribution[i]) ;
		document.getElementById("rankingPos").innerHTML = selectedTest.ageRanking + '/' + numberOfApplicants + ' 등';
		document.getElementById("averagePos").innerHTML = '평균: ' +selectedTest.ageAverage;
	}else {
		alert("방금 체크해제함");
		drawGraph(selectedTest.totalDistribution);
		for( var i = 0 ; i < selectedTest.totalDistribution.length; i++) 
			numberOfApplicants +=  parseInt(selectedTest.totalDistribution[i]) ;
		document.getElementById("rankingPos").innerHTML = selectedTest.totalRanking + '/' + numberOfApplicants + ' 등';
		document.getElementById("averagePos").innerHTML = '평균: ' +selectedTest.totalAverage;
	}
}
</script>
<!--  -->
<script>//================================================answerSheetShow(testIndex)
function answerSheetShow(testIndex) {
	var selectedTest = testInfos[testIndex];
	var baejum = selectedTest.baejumString ;
	var cAnswer = selectedTest.correctAnswerString ;
	var uAnswer = selectedTest.yourAnswerString ;
	var HTMLCode = '';
	if (selectedTest.baejumString.length <= 15 ){
		HTMLCode +='<table border=1><tr><td>문제번호</td><td>배점</td><td>정답</td><td>답안</td></tr>';
		for(var i = 0 ; i < baejum.length ; i++ ) {
			if( i < cAnswer.length ) {	//객관식이라는 뜻이겟군.
				HTMLCode += '<tr><td>객관식 '+( i+1 )+'번</td><td>'
							+ baejum[i] + '</td><td>'+cAnswer[i] +'</td><td>'
							+ uAnswer[i] +'</td></tr>';
			} else {											//주관식은 이렇게 표시한다.
				HTMLCode += '<tr><td>주관식'+( i + 1 - cAnswer.length)+'번</td><td>'
							+ baejum[i] + '</td><td>-</td><td>'
							+ (uAnswer[i] == 1 ? 'O' : 'X' ) +'</td></tr>';
	}	}	}
	else {
		HTMLCode += '<table border=1><tr><td>문제번호</td><td>배점</td><td>정답</td><td>답안</td>'
				   +'<td>문제번호</td><td>배점</td><td>정답</td><td>답안</td></tr>';
		for( var i = 0 ; i < 15 ; i++) {

			if( ( i < cAnswer.length ) && ( ( i + 15 ) < cAnswer.length ) ) {	//======================case 객 객
				HTMLCode +=  '<tr><td>객관식'+(i+1)+'번</td><td>'+baejum[i]+'</td><td>'+cAnswer[i]+'</td><td>'+uAnswer[i]+'</td>'
								+'<td>객관식'+(i+16)+'번</td><td>'+baejum[i+15]+'</td><td>'+cAnswer[i+15]+'</td><td>'+uAnswer[i+15]+'</td></tr>';
				
			}else if( ( i < cAnswer.length ) &&  ( ( i + 15 ) < baejum.length) ) {	//==================case 객 주
				HTMLCode +=  '<tr><td>객관식'+(i+1)+'번</td><td>'+baejum[i]+'</td><td>'+cAnswer[i]+'</td><td>'+uAnswer[i]+'</td>'
								+'<td>주관식'+(i+16-cAnswer.length)+'번</td><td>'+baejum[i+15]+'</td><td>-</td><td>'+(uAnswer[i+15] == 1 ? 'O' : 'X' )+'</td></tr>';			
			}else if( i < cAnswer.length ) {						 				//==================case 객 x
				HTMLCode +=  '<tr><td>객관식'+(i+1)+'번</td><td>'+baejum[i]+'</td><td>'+cAnswer[i]+'</td><td>'+uAnswer[i]+'</td>'
								+'<td></td><td></td><td></td><td></td></tr>';				
			}else if( ( i+15 ) < baejum.length  ) {									//==================case 주 주
				HTMLCode +=  '<tr><td>주관식'+(i+1-cAnswer.length)+'번</td><td>'+baejum[i]+'</td><td>-</td><td>'+(uAnswer[i] == 1 ? 'O' : 'X' )+'</td>'
								+'<td>주관식'+(i+16-cAnswer.length)+'번</td><td>'+baejum[i+15]+'</td><td>-</td><td>'+(uAnswer[i+15] == 1 ? 'O' : 'X' )+'</td></tr>';				
			} else {																//==================case 주 X
				HTMLCode +=  '<tr><td>주관식'+(i+1-cAnswer.length)+'번</td><td>'+baejum[i]+'</td><td>-</td><td>'+(uAnswer[i] == 1 ? 'O' : 'X' )+'</td>'
								+'<td></td><td></td><td></td><td></td></tr>';			
	}	}	}
	document.getElementById("answerSheetPos").innerHTML = HTMLCode;
}
</script>
<!--  -->
<script>//======================================================testListShow()
function testListShow() {
	var HTMLCode = '<table border=1><tr><td>응시번호</td><td>시험Id</td><td>점수</td><td>총점</td><td>기타</td><td></td></tr>';
	for( var i = 0 ; i < testInfos.length ; i++ ) {
		HTMLCode +=  '<tr><td>'+testInfos[i].indivScoreNum +'</td><td>'+ testInfos[i].testId
					+'</td><td>'+ testInfos[i].yourScore +'</td><td>'+ testInfos[i].totalScore +'</td><td>'+ testInfos[i].comments
					+'</td><td><input type="button" value="선택" onclick="testSelected('+i+')"></td></tr>';
	}
	HTMLCode += '</table>';
	//적절한 자리에 부착시키자.
	document.getElementById("testListPos").innerHTML = HTMLCode;
}
</script>
<!--  -->
<script>//======================================================testSelected( testIndex )
function testSelected( testIndex ) {
	oneTestStatisticsShow( testIndex );
	answerSheetShow( testIndex );
}
</script>
<!--  -->
<script>//======================================================drawGraph(arr)
function drawGraph(arr) {
		//rem
	var parent = document.getElementById("graphPos");
	var child = document.getElementById("myChart");
	if( child != null )
		parent.removeChild(child);
	//create
	var temptag = document.createElement('canvas');
	temptag.id = "myChart";
	parent.appendChild(temptag);
	
	var ctx = document.getElementById('myChart').getContext('2d'); 
	var chart = new Chart(ctx, { 
		// 챠트 종류를 선택
		type: 'line', 
		
		// 챠트를 그릴 데이타
		data: { 
			labels: ['0~9', '10~19', '20~29', '30~39', '40~49', '50~59' ,'60~69' , '70~79', '80~89' , '90~100'], 
			datasets: [{ 
				label: '', 
				backgroundColor: 'transparent', 
				borderColor: 'red' ,
				data: [arr[0],arr[1] , arr[2],arr[3],arr[4],arr[5],arr[6], arr[7], arr[8], arr[9]] 
			}] 
		}, 
		// 옵션 
		options: {} 
		}); 
}
</script>

<script>//======================================================afterTeacherSelected( index ) 
function afterTeacherSelected( index ) {
	alert(index);
	var selectedTeacher = teachers[index] ;
	
	var lectureOfSelectedTeacherArray = new Array();
	for( var i = 0 ; i < lectures.length ; i++ ) {
		if( lectures[i].teacherId == selectedTeacher.teacherId ) 
			lectureOfSelectedTeacherArray.push( lectures[i] ) ;
	}
	
	var HTMLCode = '<form action="login.common" method="post"><table border=1><tr><td colspan=8>시간대 선택하기</td></tr><td></td><td>일</td><td>월</td><td>화</td><td>수</td><td>목</td><td>금</td><td>토</td></tr>';
	for( var i = 0 ; i <= 12 ; i++) {
		HTMLCode += '<tr><td>'+(i+9)+'시~'+(i+10)+'시</td>';
		for( var j = 0 ; j < 7 ; j++ ){
			HTMLCode += '<td><input type="radio" id="' +(''+j+i) + '" name="dayAndTime" disabled onclick="sugangConfirmed(this)"></td>';
		}
		HTMLCode += '</tr>';
	}
	HTMLCode += '</table><input type=submit value="제출하기">'
				+'<input type="hidden" name="studentId" id="studentIdPos">'
				+'<input type="hidden" name="lectureId" id="lectureIdPos">'
				+'<input type="hidden" name="recursive" value="fromSugangSincheong"></form>';
	
	document.getElementById("timeTablePos").innerHTML = HTMLCode;
	
	for( var i = 0 ; i < lectureOfSelectedTeacherArray.length ; i++ ) {
		var nowDay = lectureOfSelectedTeacherArray[i].day ;
		var nowTime = lectureOfSelectedTeacherArray[i].time ;
		
		var nowDayAndTime =''+nowDay+nowTime;
		var radioButtonDayAndTime = document.getElementById( nowDayAndTime );
		radioButtonDayAndTime.disabled = false;	
		radioButtonDayAndTime.setAttribute("lectureId", lectureOfSelectedTeacherArray[i].lectureId );
	}
}

</script>

<script>//====================================================sugangConfirmed(obj)
function sugangConfirmed(obj) {
	document.getElementById("studentIdPos").setAttribute("value", studentId);
	
	var string = obj.getAttribute("lectureId");
	document.getElementById("lectureIdPos").setAttribute("value", string);
}
</script>

<script>//====================================================calendarMaker( date )
function calendarMaker( date ) {//Date형 객체 필요하구나..
	
	var month = new Date(date.getFullYear(), date.getMonth());
	var monthLength = new Date(date.getFullYear(), date.getMonth()+1, 0).getDate();	//1~31
	var firstDay = month.getDay();			// 0~6 , 요일을 의미함.
	
	var calendarLine = parseInt((monthLength + firstDay) / 7) ;		//이번달을 표시하는데 몇줄이 필요한지..!
	if ( ( ( monthLength + firstDay) % 7 )!= 0 )
		calendarLine += 1 ;
	
	var HTMLCode = 	'<table border=1><tr><td colspan=7>'+(month.getMonth()+1)+'월</td></tr>'
				   +'<tr><td>일</td><td>월</td><td>화</td><td>수</td><td>목</td><td>금</td><td>토</td></tr><tr>';
	for( var i = 0 ; i < 7*calendarLine ; i++ ) {
		HTMLCode += '<td name="dateBox" year="'+month.getFullYear()+'" month="'+month.getMonth()+'" date="'+(i-firstDay+1)+'" onclick="dateInfoClicked(this)">'
					+( (i-firstDay+1)>monthLength ? '' : (i-firstDay+1) ) +'</td>';
		if( i % 7 == 6 )
			HTMLCode += '</tr><tr>';
	}
	HTMLCode += '</table>';
	document.getElementById("calendarPos").innerHTML = HTMLCode;
	calendarFill();
}
</script>

<script>//========================================================calendarFill()
function calendarFill() {
	var dateBoxes = document.getElementsByName("dateBox");
	for( var i = 0 ; i < dateBoxes.length ; i++ ) {
		var targetDate = new Date(parseInt( dateBoxes[i].getAttribute("year")),parseInt( dateBoxes[i].getAttribute("month")),parseInt( dateBoxes[i].getAttribute("date")) ).setHours(9,0,0,0);
		for( var j = 0 ; j < atdcStats.length; j++ ) {
			if( atdcStats[j].date.valueOf() == targetDate.valueOf() ) {
				HTMLCode = '' + atdcStats[j].date.getDate() +'<br>' + atdcStats[j].status ;
				dateBoxes[i].innerHTML = HTMLCode ;
}	}	}	}
</script>

<script>//========================================================
function nextMonthClicked(date) {
	calendarTargetMonth = new Date(date.getFullYear(), date.getMonth()+1, date.getDate());
	calendarMaker( calendarTargetMonth ) ;
}

function previousMonthClicked(date) {
	calendarTargetMonth = new Date(date.getFullYear(), date.getMonth()-1, date.getDate());
	calendarMaker( calendarTargetMonth ) ;	
}

function dateInfoClicked(obj) {
	var targetDate = new Date(parseInt(obj.getAttribute("year")),parseInt(obj.getAttribute("month")),parseInt(obj.getAttribute("date")) ).setHours(9,0,0,0);
	for( var j = 0 ; j < atdcStats.length; j++ ) {
		if( atdcStats[j].date.valueOf() == targetDate.valueOf() ) {
			HTMLCode = '<table border=1><tr><td>와야하는시각</td><td>'+atdcStats[j].shouldComeTime+'</td></tr>'
						+'<tr><td>온시각</td><td>'+atdcStats[j].earlyComeTime+'</td></tr>'
						+'<tr><td>가야하는시각</td><td>'+atdcStats[j].shouldGoTime+'</td></tr>'
						+'<tr><td>간시각</td><td>'+atdcStats[j].lateGoTime+'</td></tr>'
						+'<tr><td>상태</td><td>'+atdcStats[j].status+'</td></tr></table>';
		}
	}
	document.getElementById("dateInfoPos").innerHTML = HTMLCode;
}
</script>


<table border=1>
	<tr>
		<td id="sideMenuHideButtonPos"></td>
		<td id="sideMenuShowButtonPos"></td>
	</tr><tr>
		<td id="sideMenuPos"></td>
		<td id="mainContentsPos"></td>
	</tr>
</table>


<script>//================================================아래: HTMLCode 및 주요 위치들 선언..얘네는 여기 있어야 하는듯.

var mainContentsPosition = document.getElementById("mainContentsPos");	//메인 컨텐츠를 부착할 장소

var sideMenuHTMLCode = '';			//사이드 메뉴 
var sideMenuPosition =document.getElementById("sideMenuPos");			//사이드메뉴를 부착할 장소

var hideMenuHTMLCode ='';			//메뉴 숨기기.. 이것은 메뉴가 켜진 상태에서만 보여야겟지요..
var hideMenuButtonPosition = document.getElementById("sideMenuHideButtonPos");
var showMenuHTMLCode ='';			//메뉴 보이기.. 이것은 메뉴가 숨겨진 상태에서만 보여야겠지요..
var showMenuButtonPosition = document.getElementById("sideMenuShowButtonPos");

var isSideMenuAppear ='false';			//사이드메뉴가 보여지고 있는지 아닌지 기록할 변수	true:노출됨, false:숨김
</script>

<script>//================================================아래: 초 기 화
summaryShow();
hideMenu();
</script>

</body>
</html>