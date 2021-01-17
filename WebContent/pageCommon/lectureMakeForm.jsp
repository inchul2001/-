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
//request : ���� ��ü : jsp ��ü���� �����Ǵ� ���� ��ü
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

var arrayDay = new Array("��", "��", "ȭ", "��", "��", "��", "��");
var arrayTime = new Array("9:00~10:00", "10:00~11:00", "11:00~12:00", "12:00~13:00", "13:00~14:00", "14:00~15:00", "15:00~16:00", "16:00~17:00", "17:00~18:00", "18:00~19:00", "19:00~20:00", "20:00~21:00", "21:00~22:00");

</script>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="toHome.common">
<input type="submit" value="Ȩ����">
</form>
<hr color="black">
<div> <!-- ���� lectures ����  -->
<table border=1 id="showLecturesTable" ></table>
</div>
<hr color="black">
<div> <!--  �� lecture �߰��ϱ� & ��� �����ֱ� (�ð�: ǥ�� ���·�  / ���ǽ�: ����Ʈ�� ���·� / ������: ����Ʈ�� ���·�)-->
<form action="" method="post">
<input type="hidden" name="recursive" value="true">
<table border=1>
	<tr><td>����</td><td>�ð�</td><td>���ǽ�</td><td>������</td><td>����</td><td></td></tr><tr>
<td><select id="newLectureDay" name="day">
	<option value="0">��</option>
	<option value="1">��</option>
	<option value="2">ȭ</option>
	<option value="3">��</option>
	<option value="4">��</option>
	<option value="5">��</option>
	<option value="6">��</option>
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
</td><td id="changeableButton"><input type="button" value="Ȯ���ϱ�" onclick="availableCheck()"></td></tr>

</table>


</form>
</div>

<script>
var lecturesTable ="" ;
var positionLecturesTable = document.getElementById("showLecturesTable");

lecturesTable += '<tr><td>���Ǿ��̵�</td><td>����</td><td>�ð�</td><td>���ǽ�</td><td>������</td><td>����</td></tr>';
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
selectClassroom += '<option value="newClassroom">�����ǽ��߰�</option>';
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
		alert("�߰� ������ lecture�Դϴ�.");
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
		submitContents += '<input type="submit" value="�����ϱ�">';
				
		document.getElementById("newLectureDay").setAttribute("disabled","disabled");
		document.getElementById("newLectureTime").setAttribute("disabled","disabled");
		document.getElementById("newLectureClassroom").setAttribute("disabled","disabled");
		document.getElementById("newLectureTeacherId").setAttribute("disabled","disabled");
		
		document.getElementById("changeableButton").innerHTML = submitContents ;
		
	} else {
		alert("�߰� �Ұ����� lecture�Դϴ� : ���Ǿ��̵�"+index);
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