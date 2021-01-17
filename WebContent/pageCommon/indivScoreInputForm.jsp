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
//request : 내장 객체 : jsp 자체에서 제공되는 내장 객체
%>

<!DOCTYPE html>
<html>
<script>	//자바에 있던 값들 자바스크립트로 옮기기.
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
var selectedTestIndex =<%=selectedTestIndex %>;		//선택된 시험지를 기억해둘 변수
var selectedStudentId ;	//선택된 학생을 기억해둘 변수
</script>

<head>
<meta charset="EUC-KR">
<title>개인점수입력 페이지입니다.</title>
</head>

<body>
<form method="post" action="toHome.common">
<input type="submit" value="홈으로">
</form>
<hr color="black">

<div id="testSelect"><!-- 시험선택 --></div>
<hr color="black">
<div id="studentSelect"><!-- 학생선택 --></div>
<hr color="black">
<div id="answerTable"><!-- 답안지 입력 --></div>

<script>	//시험선택, 학생선택 채우기, 답안지 입력에 필요한 기초정보 조사하기.
var testSelectPosition = document.getElementById("testSelect");
var testSelectHTMLCode = "";

testSelectHTMLCode += '<table border=1><tr><td>선택</td><td>시험아이디</td><td>시험시행일</td><td>시험범위</td><td>주석</td></tr>';
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
studentSelectHTMLCode += '</select><button onclick="studentConfirmed(this)">학생선택완료</button>';

</script>
<script>

function testSelected(obj) {
//	alert("testSelected called");
	selectedTestIndex = obj.value;
	var button1 = document.createElement('div');
	button1.innerHTML = '<button onclick="testConfirmed(this)">시험지 확정하기</button>';
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
var answerString ="" ; //이거 제출용.. 어딘가에 hidden으로 박아둬야 하는데..
var score = 0 ;
var totalScore = 0 ;

function studentConfirmed(obj) { //여기가 이제 좀 지랄인데..
//	alert("studentConfirmed called");
	selectedStudentId = document.getElementById("studentSelected").value;
	document.getElementById("studentSelected").setAttribute("disabled", "disabled");
	if( obj != null)
		obj.parentNode.removeChild(obj);
	
	baejumArray = tests[selectedTestIndex].baejumString.split('#');
	baejumArray.pop();
	answerArray = tests[selectedTestIndex].answerString.split('#');
	answerArray.pop();
		
	answerInpuFormHTMLCode += '<table border=1><tr><td>문제번호</td><td>배점</td><td>정답</td><td>입력</td></tr>';
	for( var i = 0 ; i < baejumArray.length ; i++) {
		if( i < answerArray.length ) {
			answerInpuFormHTMLCode += '<tr><td>객관식'+(i+1)+'번</td><td>'+baejumArray[i]+'점</td><td>'+answerArray[i]+
			'</td><td><input type="number" class="lock" name="gaekAnswer" id="answer'+i+'" style="width:50px;"></td></tr>' ;
		}
		else {
			answerInpuFormHTMLCode += '<tr><td>주관식'+(i+1-answerArray.length)+'번</td><td>'+baejumArray[i]+'점</td><td>'+'unavailable'+
			'</td><td><input type="radio" class="lock" name="juAnswer'+i+'" value="true">O<input type="radio" name="juAnswer'+i+'" value="false">X</td></tr>' ;
		}
	}
	answerInpuFormHTMLCode += '<tr><td>총점:</td><td id="totalScorePos"></td><td>점수:</td><td id="indivScore"></td>';
	answerInpuFormHTMLCode += '</table><button onclick="scoreCalculate(this)">확인</button>' ;
	
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
	unlockButton.innerHTML = '<button onclick="reset()">수정하기</button>';
	var submitButton = document.createElement("div");
	submitButton.innerHTML = '<form method="post" action="indivScoreInputForm.common" >'
							+'<input type="hidden" name="recursive" id="recursive">'
							+'<input type="hidden" name="studentId" id="sendStudentId">'
							+'<input type="hidden" name="testId" id="sendTestId">'
							+'<input type="hidden" name="indivAnswerString" id="sendIndivAnswerString">'
							+'<input type="hidden" name="score" id="sendScore">'
							+'<br>주석:<input type="text" name="comment"><br> '
							+'<input type="submit" name="comment" value="제출하기">'
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