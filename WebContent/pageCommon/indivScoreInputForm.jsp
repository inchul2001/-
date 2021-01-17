<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@page import="vo.StudentBasic"%>
<%@page import="vo.TestMetaData"%>
<%@page import="vo.IndivScore"%>

<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.*"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
List<StudentBasic> students = (List<StudentBasic>) request.getAttribute("students");
List<TestMetaData> tests = (List<TestMetaData>) request.getAttribute("tests");
List<IndivScore> scores = (List<IndivScore>) request.getAttribute("scores");
int selectedTestIndex = -1 ;
try{
	selectedTestIndex = (Integer)request.getAttribute("alreadySelectedTest");
} catch(Exception e) { }
//request : ���� ��ü : jsp ��ü���� �����Ǵ� ���� ��ü
%>

<!DOCTYPE html>
<html>
<script>	//�ڹٿ� �ִ� ���� �ڹٽ�ũ��Ʈ�� �ű��.
//=========================== students =============================
	class Student{
		constructor(studentId, studentName) {
			this.studentId = studentId , this.studentName = studentName ,
			this.idAndName = studentName +"(" + studentId +")"
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
//=========================== tests =============================
	class Test {
		constructor(testId, testDate, baejumString, answerString, description, testRange) {
			this.testId = testId, this.testDate = testDate, 
			this.baejumString = baejumString, this.answerString = answerString, 
			this.description = description, this.testRange = testRange
		}
	}
	var tests = new Array() ;
	let test; 
	<%
	if( tests != null )
		for( int i = 0 ; i < tests.size() ; i++) {
			String testId = tests.get(i).getTestId();
			String date = ""+(tests.get(i).getTestDate().getYear()+1900)+"."+(tests.get(i).getTestDate().getMonth()+1)+"."+(tests.get(i).getTestDate().getDate());
			String baejumString = tests.get(i).getBaejumString();
			String answerString = tests.get(i).getAnswerString();
			String description = tests.get(i).getDescription();
			String testRange = tests.get(i).getTestRange();
			%>
			test = new Test('<%=testId %>', '<%=date %>', '<%=baejumString %>', '<%=answerString %>', '<%=description %>', '<%=testRange %>');
			tests.push(test);	
			<%
		}
	%>
//=========================== indivScores =============================
	class IndivScore {
		constructor(studentId, testId, indivAnswerString, score) {
			this.studentId = studentId, this.testId = testId, 
			this.indivAnswerString = indivAnswerString, this.score = score
		}
	}
	var scores = new Array() ;
	let peopleScore; 
	<%
	if( scores != null )
		for( int i = 0 ; i < scores.size() ; i++) {
			String studentId = scores.get(i).getStudentId();
			String testId = scores.get(i).getTestId();
			String indivAnswerString = scores.get(i).getIndivAnswerString();
			float score = scores.get(i).getScore();
			Date testExecutedDate = null;
			%>	
			peopleScore = new IndivScore('<%=studentId %>', '<%=testId %>', '<%=indivAnswerString %>', <%=score %>, '<%=testExecutedDate %>');
			scores.push(peopleScore);	<%
		}
	%>	
</script>
<script>
var selectedTestIndex =<%=selectedTestIndex %>;		//���õ� �������� ����ص� ����
var selectedStudentId ;	//���õ� �л��� ����ص� ����
</script>

<head>
<meta charset="EUC-KR">
<title>���������Է� �������Դϴ�.</title>
</head>

<body>
<form method="post" action="toHome.common">
<input type="submit" value="Ȩ����">
</form>
<hr color="black">

<div id="testSelect"><!-- ���輱�� --></div>
<hr color="black">
<div id="studentSelect"><!-- �л����� --></div>
<hr color="black">
<div id="answerTable"><!-- ����� �Է� --></div>

<script>	//���輱��, �л����� ä���, ����� �Է¿� �ʿ��� �������� �����ϱ�.
var testSelectPosition = document.getElementById("testSelect");
var testSelectHTMLCode = "";

testSelectHTMLCode += '<table border=1><tr><td>����</td><td>������̵�</td><td>���������</td><td>�������</td><td>�ּ�</td></tr>';
for( var i = 0 ; i < tests.length ; i++) {
	testSelectHTMLCode += '<tr><td>' + '<input type="radio" id="AlreadySelected'+i+'" name="testSelect" value="'+i+'" onclick="testSelected(this)">' +
							'</td><td>' + tests[i].testId + '</td><td>' + tests[i].testDate + '</td><td>' + tests[i].testRange + '</td><td>' + tests[i].description + '</td></tr>';	}
testSelectHTMLCode += '</table>'
testSelectPosition.innerHTML = testSelectHTMLCode ;

if( selectedTestIndex != -1 ) {
	document.getElementById("AlreadySelected"+selectedTestIndex).setAttribute("checked", "true");
}
//===============================================================
var studentSelectPosition = document.getElementById("studentSelect");
var studentSelectHTMLCode = '';

studentSelectHTMLCode += '<select id="studentSelected" name="student" required>';
for( var i = 0 ; i < students.length ; i++) {
	studentSelectHTMLCode += '<option value="'+students[i].studentId+'">'+students[i].idAndName+'</option>';	}
studentSelectHTMLCode += '</select><button onclick="studentConfirmed(this)">�л����ÿϷ�</button>';

</script>
<script>

function testSelected(obj) {
//	alert("testSelected called");
	selectedTestIndex = obj.value;
	var button1 = document.createElement('div');
	button1.innerHTML = '<button onclick="testConfirmed(this)">������ Ȯ���ϱ�</button>';
	testSelectPosition.appendChild(button1);
}

function testConfirmed(obj) {
//	alert("testConfirmed called");
	var radioButtons = document.getElementsByName("testSelect");
	for( var i = 0 ; i < radioButtons.length ; i++) {
		radioButtons[i].setAttribute("disabled", "disabled");
	}
	if( obj != null)
		obj.parentNode.removeChild(obj);
	studentSelectPosition.innerHTML = studentSelectHTMLCode;
}

var answerInpuFormHTMLCode ='';
var baejumArray;
var answerArray;
var indivAnswerArray;
var answerString ="" ; //�̰� �����.. ��򰡿� hidden���� �ھƵ־� �ϴµ�..
var score = 0 ;
var totalScore = 0 ;

function studentConfirmed(obj) { //���Ⱑ ���� �� �����ε�..
//	alert("studentConfirmed called");
	selectedStudentId = document.getElementById("studentSelected").value;
	document.getElementById("studentSelected").setAttribute("disabled", "disabled");
	if( obj != null)
		obj.parentNode.removeChild(obj);
	
	baejumArray = tests[selectedTestIndex].baejumString.split('#');
	baejumArray.pop();
	answerArray = tests[selectedTestIndex].answerString.split('#');
	answerArray.pop();
		
	answerInpuFormHTMLCode += '<table border=1><tr><td>������ȣ</td><td>����</td><td>����</td><td>�Է�</td></tr>';
	for( var i = 0 ; i < baejumArray.length ; i++) {
		if( i < answerArray.length ) {
			answerInpuFormHTMLCode += '<tr><td>������'+(i+1)+'��</td><td>'+baejumArray[i]+'��</td><td>'+answerArray[i]+
			'</td><td><input type="number" class="lock" name="gaekAnswer" id="answer'+i+'" style="width:50px;"></td></tr>' ;
		}
		else {
			answerInpuFormHTMLCode += '<tr><td>�ְ���'+(i+1-answerArray.length)+'��</td><td>'+baejumArray[i]+'��</td><td>'+'unavailable'+
			'</td><td><input type="radio" class="lock" name="juAnswer'+i+'" value="true">O<input type="radio" name="juAnswer'+i+'" value="false">X</td></tr>' ;
		}
	}
	answerInpuFormHTMLCode += '<tr><td>����:</td><td id="totalScorePos"></td><td>����:</td><td id="indivScore"></td>';
	answerInpuFormHTMLCode += '</table><button onclick="scoreCalculate(this)">Ȯ��</button>' ;
	
	document.getElementById("answerTable").innerHTML = answerInpuFormHTMLCode;
	answerInpuFormHTMLCode = '';
}

function scoreCalculate(obj) {
//	alert("scoreCalculate called");
	
	var answerNodes = document.getElementsByName("gaekAnswer");
	indivAnswerArray = new Array() ;
	
	for( var i = 0 ; i < answerNodes.length ; i++) {
		indivAnswerArray.push(answerNodes[i].value);
		answerString += answerNodes[i].value + "#" ;
	}
	
	score = 0 ;
	totalScore = 0 ;
	
	for( var i = 0 ; i < answerArray.length ; i++ ) {
		totalScore += parseInt(baejumArray[i]) ;
		if( answerArray[i] == indivAnswerArray[i] )
			score += parseInt(baejumArray[i]) ;
	}
	for( var i = answerArray.length ; i < baejumArray.length ; i++) {
		totalScore += parseInt(baejumArray[i]) ;
		var queryString = 'input[name="juAnswer'+i+'"]:checked';
		if( document.querySelector(queryString).value =="true"){
			score += parseInt(baejumArray[i]) ;
			answerString += 1 + "#" ;			
		}
		else
			answerString += 0 + "#" ;
	}
	
	var lock = document.getElementsByClassName("lock");
	for( var i = 0 ; i < lock.length ; i++) 
		lock[i].setAttribute("disabled", "disabled" );
	
	document.getElementById("totalScorePos").innerHTML = totalScore;
	document.getElementById("indivScore").innerHTML = score;
	obj.parentNode.removeChild(obj);
	
	var unlockButton = document.createElement("div");
	unlockButton.innerHTML = '<button onclick="reset()">�����ϱ�</button>';
	var submitButton = document.createElement("div");
	submitButton.innerHTML = '<form method="post" action="indivScoreInputForm.common" >'
							+'<input type="hidden" name="recursive" id="recursive">'
							+'<input type="hidden" name="studentId" id="sendStudentId">'
							+'<input type="hidden" name="testId" id="sendTestId">'
							+'<input type="hidden" name="indivAnswerString" id="sendIndivAnswerString">'
							+'<input type="hidden" name="score" id="sendScore">'
							+'<br>�ּ�:<input type="text" name="comment"><br> '
							+'<input type="submit" name="comment" value="�����ϱ�">'
							+'</form>';
	
	var unlockButtonPosition = document.getElementById("answerTable") ;
	unlockButtonPosition.appendChild(unlockButton);
	var submitButtonPosition = document.getElementById("answerTable");
	submitButtonPosition.appendChild(submitButton);
		
	document.getElementById("recursive").setAttribute("value", selectedTestIndex);
	document.getElementById("sendStudentId").setAttribute("value", selectedStudentId );
	document.getElementById("sendTestId").setAttribute("value", tests[selectedTestIndex].testId );
	document.getElementById("sendIndivAnswerString").setAttribute("value", answerString );
	document.getElementById("sendScore").setAttribute("value", score);
	
}

function reset() {
//	alert("reset called");

	var divPosition = document.getElementById("answerTable");
	divPosition.innerHTML ="";
	studentConfirmed(null);
}

</script>



</body>
</html>