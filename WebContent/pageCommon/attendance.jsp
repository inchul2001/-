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
<script>	//�ڹٿ� �ִ� ���� �ڹٽ�ũ��Ʈ�� �ű��.
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


//=========================== students ����� =============================
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
//=========================== students �ٵ�� =============================
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
			if( attendances[j].comeTime == 'null' ) //�� �ð��� ���������
				students[i].comeAndGoCount-- ;		//comeAndGoCount �� ( �� Ƚ�� - �� Ƚ�� ) ��� ��������.
			else								//�� �ð��� ���������
				students[i].comeAndGoCount++ ;		
		} 		//comeAndGoCount �� 0���� ũ�� <=> �� Ƚ���� �� Ƚ������ ũ�� <=> goTime�� �Է¹��� ���̴�.
				//comeAndGoCount �� 0���� �۰ų� ���� <=> �� Ƚ���� �� Ƚ������ �۰ų����� <=> comeTime�� �Է¹��� ���̴�.
	}
}
</script>

<head>
<meta charset="EUC-KR">
<title>�л� �⼮����</title>
</head>
<body>
<form method="post" action="toHome.common">
<input type="submit" value="Ȩ����">
</form>
<hr color="black">

<script>//�ʱ�ȭ �۾�1. �ʿ��� ���������� �����ϱ�.

</script>
<div id="attendanceCreate"></div> <!-- �л��� ���� �⼮üũ -->
<form action="attendance.common" method="post" id="sendCreateMSG">
	<input type=hidden name=studentId id=studentId>
	<input type=hidden name=comeOrGo id=comeOrGo>
	<input type=hidden name=recursive value=createNew>
</form>
<hr color="black">
<div id="attendanceModify"></div> <!-- ���� ��� ��ȸ �� ���� -->
<form action="attendance.common" method="post"></form>

<script>//�ʱ�ȭ �۾�2. HTMLCode ���̱�.
var bystudentHTMLCode ='';
bystudentHTMLCode += '<table border=1><tr><td>�л��̸�(���̵�)</td><td colspan=2>���</td><td colspan=2>�Ͽ�</td></tr>' ;
for( var i = 0 ; i < students.length ; i ++ ) {
	if( students[i].comeAndGoCount <= 0 ) {		//comeTime�Է¹���.
		bystudentHTMLCode += '<tr><td>'+students[i].idAndName
							+'</td><td idx="'+i+'">'+'<input type="button" value="���" onclick="comeTime(this)">'+'</td><td>'+'�ð�'
							+'</td><td>'+'<input type=button value="�Ͽ�" disabled>'+'</td><td>'+fillGoTime(students[i].studentId)
							+'</td></tr>' ;
	} else {									//goTime�Է¹���.	<=> comeTime �� �ԷµǾ��־�߰���..
		bystudentHTMLCode += '<tr><td>'+students[i].idAndName
							+'</td><td>'+'<input type=button value="���" disabled>'+'</td><td>'+fillComeTime(students[i].studentId)
							+'</td><td idx="'+i+'">'+'<input type="button" value="�Ͽ�" onclick="goTime(this)">'+'</td><td>'+'�ð�'
							+'</td></tr>' ;		
	}
}
bystudentHTMLCode += '</table>';
document.getElementById("attendanceCreate").innerHTML = bystudentHTMLCode;


var byAttendanceTableHTMLCode ='';
byAttendanceTableHTMLCode += '<form action="attendance.common" method="post"><table border=1><tr><td>������ȣ</td><td>��¥</td><td>�̸�(���̵�)</td><td>����ð�</td><td>�Ͽ��ð�</td><td>�����ϱ�</td></tr>' ;

for( var i = 0 ; i < attendances.length ; i++ ) {
	byAttendanceTableHTMLCode += '<tr id="'+i+'"><td>'+attendances[i].attendanceNum
								+'</td><td>'+attendances[i].attendDate
								+'</td><td>'+attendances[i].studentId
								+'</td><td>'+attendances[i].comeTime
								+'</td><td>'+attendances[i].goTime
								+'</td><td><input type=button value="�����ϱ�" onclick="modifyAtdc('+i+')">'
								+'</td></tr>';
}

byAttendanceTableHTMLCode += '</table></form>';
document.getElementById("attendanceModify").innerHTML = byAttendanceTableHTMLCode;

function modifyAtdc( index ) {
	if( attendances[index].comeTime == 'null') {			//goTime�� ��������� �ϴ� �����̼�
		var HTMLCode =	'<td>'+attendances[index].attendanceNum
						+'</td><td>'+attendances[index].attendDate
						+'</td><td>'+attendances[index].studentId
						+'</td><td>'+attendances[index].comeTime
						+'</td><td>'+'<input type=text name="goTime">'
						+'</td><td><input type="hidden" name="attendanceNum" value="'+attendances[index].attendanceNum+'"><input type=hidden name=recursive value=modifyOld><input type=submit value="�����ϱ�">'
						+'</td>';
		document.getElementById(index).innerHTML = HTMLCode ;
		
	} else {											//comeTime�� ��������� �ϴ� �����̼�
		var HTMLCode =	'<td>'+attendances[index].attendanceNum
						+'</td><td>'+attendances[index].attendDate
						+'</td><td>'+attendances[index].studentId
						+'</td><td>'+'<input type=text name="comeTime">'
						+'</td><td>'+attendances[index].goTime
						+'</td><td><input type="hidden" name="attendanceNum" value="'+attendances[index].attendanceNum+'"><input type=hidden name=recursive value=modifyOld><input type=submit value="�����ϱ�">'
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
		goTime = '�ð�';
	}
	return goTime;
}

</script>



</body>

</html>


