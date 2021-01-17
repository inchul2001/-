<%@page import="java.util.ArrayList"%>
<%@page import="vo.Lecture"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.*"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
List<Lecture> lectures = (List<Lecture>) request.getAttribute("lectures");
List<String> classrooms = (List<String>) request.getAttribute("classrooms");
List<String> teachers = (List<String>) request.getAttribute("teachers");
//request : 내장 객체 : jsp 자체에서 제공되는 내장 객체
%>
<!DOCTYPE html>
<html>
<head>
<script>
//==================================================================

class Lecture {
	constructor(lectureId, day, time, classroom, teacherId, capacity ) {
		this.lectureId = lectureId ;		this.day = day ;		this.time = time ;		this.classroom = classroom;		this.teacherId = teacherId;		this.capacity = capacity ;
	}
}
var lectures = new Array() ;
let lecture;
<%
if(lectures != null )
for(int i = 0 ; i < lectures.size() ; i++ ) {
	int lectureId = lectures.get(i).getLectureId();
	int day = lectures.get(i).getDay();
	int time = lectures.get(i).getTime();
	String classroom = lectures.get(i).getClassroom();
	String teacherId = lectures.get(i).getTeacherId();
	int capacity = lectures.get(i).getCapacity();

	%>
	lecture = new Lecture(<%=lectureId %>, <%=day %>, <%=time %>, '<%=classroom %>', '<%=teacherId %>', <%=capacity %>);
	lectures.push(lecture);
	<%
}
%>
//==================================================================
var classrooms = new Array();

<%
if( classrooms != null )
for(int i = 0 ; i < classrooms.size() ; i++ ) {
	%>
	classrooms.push('<%=classrooms.get(i)%>') ;
	<%
}
%>
//==================================================================
var teachers = new Array();

<%
if( teachers != null )
for(int i = 0 ; i < teachers.size() ; i++ ) {
	%>
	teachers.push('<%=teachers.get(i)%>') ;
	<%
}
%>
//==================================================================
var newClassroom = false;

var arrayDay = new Array("일", "월", "화", "수", "목", "금", "토");
var arrayTime = new Array("9:00~10:00", "10:00~11:00", "11:00~12:00", "12:00~13:00", "13:00~14:00", "14:00~15:00", "15:00~16:00", "16:00~17:00", "17:00~18:00", "18:00~19:00", "19:00~20:00", "20:00~21:00", "21:00~22:00");

</script>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="toHome.common">
<input type="submit" value="홈으로">
</form>
<hr color="black">
<div> <!-- 현재 lectures 내역  -->
<table border=1 id="showLecturesTable" ></table>
</div>
<hr color="black">
<div> <!--  새 lecture 추가하기 & 재료 보여주기 (시간: 표의 형태로  / 강의실: 리스트의 형태로 / 선생님: 리스트의 형태로)-->
<form action="" method="post">
<input type="hidden" name="recursive" value="true">
<table border=1>
	<tr><td>요일</td><td>시간</td><td>강의실</td><td>선생님</td><td>정원</td><td></td></tr><tr>
<td><select id="newLectureDay" name="day">
	<option value="0">일</option>
	<option value="1">월</option>
	<option value="2">화</option>
	<option value="3">수</option>
	<option value="4">목</option>
	<option value="5">금</option>
	<option value="6">토</option>
</select></td><td><select id="newLectureTime" name="time">
	<option value="0">9:00~10:00</option>
	<option value="1">10:00~11:00</option>
	<option value="2">11:00~12:00</option>
	<option value="3">12:00~13:00</option>
	<option value="4">13:00~14:00</option>
	<option value="5">14:00~15:00</option>
	<option value="6">15:00~16:00</option>
	<option value="7">16:00~17:00</option>
	<option value="8">17:00~18:00</option>
	<option value="9">18:00~19:00</option>
	<option value="10">19:00~20:00</option>
	<option value="11">20:00~21:00</option>
	<option value="12">21:00~22:00</option>
</select></td><td id="newClassroom"><select id="newLectureClassroom" name="classroom" onChange="newClassroomCheck(this)"></select>
</td><td><select id="newLectureTeacherId" name="teacherId">
</select></td><td><input type=number style="width:30px;" name=capacity>
</td><td id="changeableButton"><input type="button" value="확인하기" onclick="availableCheck()"></td></tr>

</table>


</form>
</div>

<script>
var lecturesTable ="" ;
var positionLecturesTable = document.getElementById("showLecturesTable");

lecturesTable += '<tr><td>강의아이디</td><td>요일</td><td>시간</td><td>강의실</td><td>선생님</td><td>정원</td></tr>';
for( var i = 0 ; i < lectures.length ; i++ ) {
	lecturesTable += ( '<tr><td>' + lectures[i].lectureId + '</td><td>' + arrayDay[ lectures[i].day ] + '</td><td>' +arrayTime[ lectures[i].time ] + '</td><td>' + lectures[i].classroom + '</td><td>' + lectures[i].teacherId + '</td><td>' + lectures[i].capacity + '</td></tr>');
}
positionLecturesTable.innerHTML = lecturesTable;

//==============================================================
var selectClassroom ="";
var positionSelectClassroom =document.getElementById("newLectureClassroom");
for( var i = 0 ; i < classrooms.length ; i++) {
	selectClassroom += '<option value='+classrooms[i]+'>'+classrooms[i]+'</option>';
}
selectClassroom += '<option value="newClassroom">새강의실추가</option>';
positionSelectClassroom.innerHTML = selectClassroom;

//==============================================================

var selectTeacherId ="";
var positionSelectTeacherId =document.getElementById("newLectureTeacherId");
for( var i = 0 ; i < teachers.length ; i++) {
	selectTeacherId += '<option value='+teachers[i]+'>'+teachers[i]+'</option>';
}
positionSelectTeacherId.innerHTML = selectTeacherId;

//==============================================================
function availableCheck() {
	var checkDay = document.getElementById("newLectureDay").value;
	var checkTime = document.getElementById("newLectureTime").value;
	var checkClassroom = document.getElementById("newLectureClassroom").value;
	var checkTeacher = document.getElementById("newLectureTeacherId").value;
	var result = true ;	
	var index = 1 ;
	
	for( var i = 0 ; i < lectures.length ; i++) {
		if(lectures[i].day == checkDay && lectures[i].time == checkTime)
			if(lectures[i].classroom == checkClassroom || lectures[i].teacherId == checkTeacher) {
				result = false;
				break;				
			}
		index++ ;
	}
	if( result ) {
		alert("추가 가능한 lecture입니다.");
		var submitContents = "";
		submitContents += '<input type="hidden" name="day" value="'+checkDay+'">';
		submitContents += '<input type="hidden" name="time" value="'+checkTime+'">';
		submitContents += '<input type="hidden" name="classroom" value="'+checkClassroom+'">';
		if(newClassroom){
			var newClassroomCheckAgain = true;
			for( var i = 0 ; i < classrooms.length ; i++) 
				if( checkClassroom == classrooms[i]) {
					newClassroomCheckAgain = false;
					break;
				}
			if( newClassroomCheckAgain )
				submitContents += '<input type="hidden" name="newClassroom" value="true">';
		}
		submitContents += '<input type="hidden" name="teacherId" value="'+checkTeacher+'">';
		submitContents += '<input type="submit" value="제출하기">';
				
		document.getElementById("newLectureDay").setAttribute("disabled","disabled");
		document.getElementById("newLectureTime").setAttribute("disabled","disabled");
		document.getElementById("newLectureClassroom").setAttribute("disabled","disabled");
		document.getElementById("newLectureTeacherId").setAttribute("disabled","disabled");
		
		document.getElementById("changeableButton").innerHTML = submitContents ;
		
	} else {
		alert("추가 불가능한 lecture입니다 : 강의아이디"+index);
	}
	
	
}

function newClassroomCheck(obj) {
	if(obj.value == "newClassroom") {
		newClassroom = true ;
		document.getElementById("newClassroom").innerHTML = '<input id="newLectureClassroom" type="text" name="classroom" style="width:96px;">';	
	}
}

</script>

</body>
</html>