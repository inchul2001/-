<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@page import="vo.StudentBasic"%>
<%@page import="vo.Attendance" %>

<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.*"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
List<StudentBasic> students = (List<StudentBasic>) request.getAttribute("students");
List<Attendance> attendances = (List<Attendance>) request.getAttribute("attendances");

%>

<!DOCTYPE html>
<html>
<script>	//자바에 있던 값들 자바스크립트로 옮기기.
//=========================== attendances =============================
class Attendance {
	constructor(attendanceNum, studentId, attendDate, comeTime, goTime) {
		this.attendanceNum = attendanceNum , this.studentId = studentId, this.attendDate = attendDate, 
		this.comeTime = comeTime, this.goTime = goTime;	}
}
var attendances = new Array();
let attendance;
<%
if( attendances != null )
	for( int i = 0 ; i < attendances.size() ; i++ ) {
		int attendanceNum = attendances.get(i).getAttendanceNum();
		String studentId = attendances.get(i).getStudentId();
		Date attendDate = attendances.get(i).getAttendDate();
		Time comeTime = attendances.get(i).getComeTime();
		Time goTime = attendances.get(i).getGoTime();
		
		%>
		attendance = new Attendance(<%=attendanceNum %>, '<%=studentId %>', '<%=attendDate %>', '<%=comeTime %>', '<%=goTime %>') ;
//		alert(<%=i%>);
		attendances.push(attendance);
		<%
	}
%>


//=========================== students 만들기 =============================
class Student{
	constructor(studentId, studentName ) {
		this.studentId = studentId , this.studentName = studentName ,
		this.idAndName = studentName +"(" + studentId +")"	,
		this.comeAndGoCount = 0 	
	}	
}
var students = new Array();	
let student;
<%
if( students != null )
	for( int i = 0 ; i < students.size() ; i++ ) {
		String studentId = students.get(i).getStudentId() ;
		String studentName = students.get(i).getStudentName();
		%>

		student = new Student('<%=studentId %>', '<%=studentName %>') ;
		students.push(student);
		<%
	}
%>
//=========================== students 다듬기 =============================
var month ='';
if( new Date().getMonth() + 1 < 10 )
	month += '0' + (new Date().getMonth() + 1);
else 
	month += (new Date().getMonth() + 1);
var datte ='';
if( new Date().getDate() < 10 )
	datte += '0' +(new Date().getDate());
else
	datte += (new Date().getDate());
	
var todayDate = ''+ new Date().getFullYear() +'-'+ month +'-'+datte ;

for( var i = 0 ; i < students.length ; i++ ) {
	for( var j = 0 ; j < attendances.length ; j++ ) {
		if( ( attendances[j].attendDate == todayDate ) && ( attendances[j].studentId == students[i].studentId ) ){
//			alert(''+ i + j );
			if( attendances[j].comeTime == 'null' ) //온 시간이 비어있으면
				students[i].comeAndGoCount-- ;		//comeAndGoCount 는 ( 온 횟수 - 간 횟수 ) 라고 정의하자.
			else								//간 시간이 비어있으면
				students[i].comeAndGoCount++ ;		
		} 		//comeAndGoCount 가 0보다 크다 <=> 온 횟수가 간 횟수보다 크다 <=> goTime을 입력받을 때이다.
				//comeAndGoCount 가 0보다 작거나 같다 <=> 온 횟수가 간 횟수보다 작거나같다 <=> comeTime을 입력받을 때이다.
	}
}
</script>

<head>
<meta charset="EUC-KR">
<title>학생 출석관리</title>
</head>
<body>
<form method="post" action="toHome.common">
<input type="submit" value="홈으로">
</form>
<hr color="black">

<script>//초기화 작업1. 필요한 전역변수들 선언하기.

</script>
<div id="attendanceCreate"></div> <!-- 학생별 당일 출석체크 -->
<form action="attendance.common" method="post" id="sendCreateMSG">
	<input type=hidden name=studentId id=studentId>
	<input type=hidden name=comeOrGo id=comeOrGo>
	<input type=hidden name=recursive value=createNew>
</form>
<hr color="black">
<div id="attendanceModify"></div> <!-- 누적 출결 조회 및 수정 -->
<form action="attendance.common" method="post"></form>

<script>//초기화 작업2. HTMLCode 붙이기.
var bystudentHTMLCode ='';
bystudentHTMLCode += '<table border=1><tr><td>학생이름(아이디)</td><td colspan=2>등원</td><td colspan=2>하원</td></tr>' ;
for( var i = 0 ; i < students.length ; i ++ ) {
	if( students[i].comeAndGoCount <= 0 ) {		//comeTime입력받자.
		bystudentHTMLCode += '<tr><td>'+students[i].idAndName
							+'</td><td idx="'+i+'">'+'<input type="button" value="등원" onclick="comeTime(this)">'+'</td><td>'+'시각'
							+'</td><td>'+'<input type=button value="하원" disabled>'+'</td><td>'+fillGoTime(students[i].studentId)
							+'</td></tr>' ;
	} else {									//goTime입력받자.	<=> comeTime 은 입력되어있어야겟지..
		bystudentHTMLCode += '<tr><td>'+students[i].idAndName
							+'</td><td>'+'<input type=button value="등원" disabled>'+'</td><td>'+fillComeTime(students[i].studentId)
							+'</td><td idx="'+i+'">'+'<input type="button" value="하원" onclick="goTime(this)">'+'</td><td>'+'시각'
							+'</td></tr>' ;		
	}
}
bystudentHTMLCode += '</table>';
document.getElementById("attendanceCreate").innerHTML = bystudentHTMLCode;


var byAttendanceTableHTMLCode ='';
byAttendanceTableHTMLCode += '<form action="attendance.common" method="post"><table border=1><tr><td>고유번호</td><td>날짜</td><td>이름(아이디)</td><td>등원시각</td><td>하원시각</td><td>수정하기</td></tr>' ;

for( var i = 0 ; i < attendances.length ; i++ ) {
	byAttendanceTableHTMLCode += '<tr id="'+i+'"><td>'+attendances[i].attendanceNum
								+'</td><td>'+attendances[i].attendDate
								+'</td><td>'+attendances[i].studentId
								+'</td><td>'+attendances[i].comeTime
								+'</td><td>'+attendances[i].goTime
								+'</td><td><input type=button value="수정하기" onclick="modifyAtdc('+i+')">'
								+'</td></tr>';
}

byAttendanceTableHTMLCode += '</table></form>';
document.getElementById("attendanceModify").innerHTML = byAttendanceTableHTMLCode;

function modifyAtdc( index ) {
	if( attendances[index].comeTime == 'null') {			//goTime을 변경해줘야 하는 시츄에이션
		var HTMLCode =	'<td>'+attendances[index].attendanceNum
						+'</td><td>'+attendances[index].attendDate
						+'</td><td>'+attendances[index].studentId
						+'</td><td>'+attendances[index].comeTime
						+'</td><td>'+'<input type=text name="goTime">'
						+'</td><td><input type="hidden" name="attendanceNum" value="'+attendances[index].attendanceNum+'"><input type=hidden name=recursive value=modifyOld><input type=submit value="제출하기">'
						+'</td>';
		document.getElementById(index).innerHTML = HTMLCode ;
		
	} else {											//comeTime을 변경해줘야 하는 시츄에이션
		var HTMLCode =	'<td>'+attendances[index].attendanceNum
						+'</td><td>'+attendances[index].attendDate
						+'</td><td>'+attendances[index].studentId
						+'</td><td>'+'<input type=text name="comeTime">'
						+'</td><td>'+attendances[index].goTime
						+'</td><td><input type="hidden" name="attendanceNum" value="'+attendances[index].attendanceNum+'"><input type=hidden name=recursive value=modifyOld><input type=submit value="제출하기">'
						+'</td>';
		document.getElementById(index).innerHTML = HTMLCode ;
	}
	
}


function comeTime(obj) {
	var index = obj.parentNode.getAttribute("idx");
	document.getElementById("studentId").setAttribute("value",students[ index ].studentId );
	document.getElementById("comeOrGo").setAttribute("value","come");
	
	document.getElementById("sendCreateMSG").submit();
}

function goTime(obj) {
	var index = obj.parentNode.getAttribute("idx");
	document.getElementById("studentId").setAttribute("value",students[ index ].studentId );
	document.getElementById("comeOrGo").setAttribute("value","go");
	
	document.getElementById("sendCreateMSG").submit();
}

function fillComeTime(sId) {
	var comeTime ;
	for( var i = 0 ; i < attendances.length ; i++ ) {
		if( ( attendances[i].attendDate == todayDate ) && ( attendances[i].studentId == sId ) && ( attendances[i].comeTime != 'null' ) ){
			comeTime = attendances[i].comeTime;
			break;
		}
	}
	return comeTime;
}
function fillGoTime(sId) {
	var goTime ;
	for( var i = 0 ; i < attendances.length ; i++ ) {
		if( ( attendances[i].attendDate == todayDate ) && ( attendances[i].studentId == sId ) && ( attendances[i].goTime != 'null' ) ){
			goTime = attendances[i].goTime;
			break;
		}
	}
	if( goTime == null) {
		goTime = '시각';
	}
	return goTime;
}

</script>



</body>

</html>


