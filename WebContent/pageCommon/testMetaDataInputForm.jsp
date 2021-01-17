<%@page import="java.util.ArrayList"%>
<%@page import="vo.TestMetaData"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.*"%>


<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
List<TestMetaData> tests = (List<TestMetaData>) request.getAttribute("tests");
//request : 내장 객체 : jsp 자체에서 제공되는 내장 객체
%>
<!DOCTYPE html>
<html>

<head>
<!--
	head에서 할 일은 
	1.자바로 받은정보들 가공하고 (< + % 를 이용했엇지..) 
	2.그걸 자바스크립트에 옮겨놓고 ( script 태그 안에 적으면 되겟지.)
	3.자바스크립트에서는 옮긴 정보를 처리할 기능들을 구현해놓는다..  
-->
<meta charset="EUC-KR">
<title>테스트메타데이터 입력 폼</title>
<script>
var baejumString ;
var answerString ;
function testInputFormShow() {
	var targetPosition = document.getElementById("newTestMetaDataFormMaker")
	
	var table = document.createElement('table');
	table.setAttribute("border","1");
	
	targetPosition.innerHTML ="";
	
	targetPosition.appendChild(table);
	table.innerHTML = 
		"<tr><td>시험시행일</td><td>시험Id</td><td>시험범위</td><td>시험지파일</td><td>주석</td></tr>" +
		
		"<tr>" +
		"<td><input type=date name=testDate></td>" +
		'<td><input type=text name=testId id="testId"></td>' +
		'<td><input type=text name=testRange></td>' +
		'<td><input type="file" name="file"></td>' +
		'<td><input type=text name=description></td>' +
		"</tr>"+
		"<tr>" +
		'<td id="tempButtonParent" colspan=5>'+
		'객관식 문제 갯수 : <input id="gakMunhangSu" type="number" name="gakMunhangSu"><br>'+
		'주관식 문제 갯수 : <input id="juMunhangSu" type="number" name="juMunhangSu"><br>'+
		'<input id="tempButton" type="button" value="답안지 생성하기" onclick="testAnswerInputFormShow()">'+
		"</td></tr>"
	
	

}

function testAnswerInputFormShow() {
	if( document.getElementById("testId").value == "") {
		alert("id는 필수 입력 사항입니다.");
		return ;
	}
	//if( document.getElementById("").value)
	
	var targetPosition = document.getElementById("newTestMetaDataFormMaker")
	
	var table = document.createElement('table');
	table.setAttribute("border","1");
	
	targetPosition.appendChild(table);
	var gakMunhangSu = document.getElementById("gakMunhangSu").value;
	var juMunhangSu = document.getElementById("juMunhangSu").value;

	var htmlCode ="<table border=1>";
	htmlCode += "<tr><td>문제번호</td><td>배점</td><td>정답</td></tr>";
	for( var i = 0 ; i < gakMunhangSu ; i++ ) {
		htmlCode += "<tr><td>객관식" +( i+1 ) + '번</td><td><input type="number" id=score' +(i+1)+ '></td><td><input type="number" id=answer'+(i+1)+'></td></tr>'
	}
	for( var i = 0 ; i < juMunhangSu ; i++ ) {
		htmlCode += "<tr><td>주관식" +( i+1 ) + '번</td><td><input type="number" id=score' +(i+1+Number(gakMunhangSu))+ '></td><td>내용없음</td></tr>'
	}
	htmlCode += '<tr><td><input type="button" value="총점계산하기" onclick="finalProcess()"></td>';
	htmlCode += '<td id="totalScoreHere"></td><td id="finalSubmit"></td></tr>' ;
	
	htmlCode += "</table>";
	
	table.innerHTML = htmlCode ;
	
	var tempButtonParent = document.getElementById("tempButtonParent");
	var tempButton = document.getElementById("tempButton");
	tempButtonParent.removeChild(tempButton) ;
}

</script>
</head>

<body>
<form method="post" action="toHome.common">
<input type="submit" value="홈으로">
</form>

<form action="testUpload.common" name="newTest" method="post" id="newTest" enctype="multipart/form-data">
	<input type="hidden" id="testBaejumString" name="testBaejumString">
	<input type="hidden" id="testAnswerString" name="testAnswerString">
	<input type="hidden" id="totalScore" name="totalScore">
	<input type="hidden" name="uploadTrue" value="true">

	<div id="newTestMetaDataFormMaker">
		<!-- 
			이 태그 안에 `새로운 시험지 생성 시작 버튼`을 만든다  
			`새로운 시험지 생성 시작 버튼`을 누르면 이 div태그의 내용물은 새로운 시험지 정보를 받는 박스로 변한다. 
		-->
		<input type="button" value="새로운 시험지 생성하기" onclick="testInputFormShow()">
	</div>
</form>

<div id="testMetaDataShowTable">
	<!--
		이 태그 안에 페이지 생성시 받은 정보로 이미 생성된 시험지들의 메타데이터를 표로 제공해주자.. 
	 -->
	 <table border=1>
	 <tr>
		 <td>시험시행일</td>
		 <td>시험Id</td>
		 <td>시험범위</td>
		 <td>주석</td>
		 <td>시험지파일</td>
	 </tr>
	<%
	if( tests != null ) {
	for(int i = 0; i < tests.size() ; i++ ) { %>
		<tr>
			<td><%=tests.get(i).getTestDate() %>	</td>
			<td><%=tests.get(i).getTestId() %>	</td>	
			<td><%=tests.get(i).getTestRange() %>	</td>
			<td><%=tests.get(i).getDescription() %>	</td>	
	<!--
	 		<td><a href="file_down.jsp?file_name=<%=tests.get(i).getuploadedFileName() %>"><%=tests.get(i).getoriginalFileName() %></a></td>
	 -->
	 		<td><a href="../upload/<%=tests.get(i).getuploadedFileName() %>"download><%=tests.get(i).getoriginalFileName() %></a></td>
		</tr>
	<% } }%>	
	 
	 </table>
</div>
<script>

function finalProcess() {
	var totalScore = 0 ;
	baejumString ="" ;
	answerString ="";
	var gakMunhangSu = document.getElementById("gakMunhangSu").value;
	var juMunhangSu = document.getElementById("juMunhangSu").value; 
	
	for( var  i = 0 ; i < Number(gakMunhangSu) + Number(juMunhangSu) ; i++ ) {
		var scoreTag = Number(document.getElementById(("score" +(i+1) )).value);
		totalScore += scoreTag;
		baejumString += scoreTag + "#" ;
	}
	for( var  i = 0 ; i < Number(gakMunhangSu) ; i++ ) {
		var answer = document.getElementById( ( "answer" +(i+1) ) ).value;
		answerString += answer + "#" ;
	}

	document.getElementById("totalScoreHere").innerHTML = totalScore ;
	
	var baejumPosition = document.getElementById("testBaejumString");
	baejumPosition.setAttribute("value",baejumString);
	var answerPosition = document.getElementById("testAnswerString");
	answerPosition.setAttribute("value",answerString);
	var totalScorePosition = document.getElementById("totalScore");
	totalScorePosition.setAttribute("value", totalScore);

	
	//===============================================================================
	document.getElementById("finalSubmit").innerHTML = '<input type="submit" value="전송하기">';
}

</script>
</body>
</html>
