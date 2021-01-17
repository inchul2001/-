<%@page import="java.util.ArrayList"%>
<%@page import="vo.TestMetaData"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.*"%>


<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
List<TestMetaData> tests = (List<TestMetaData>) request.getAttribute("tests");
//request : ���� ��ü : jsp ��ü���� �����Ǵ� ���� ��ü
%>
<!DOCTYPE html>
<html>

<head>
<!--
	head���� �� ���� 
	1.�ڹٷ� ���������� �����ϰ� (< + % �� �̿��߾���..) 
	2.�װ� �ڹٽ�ũ��Ʈ�� �Űܳ��� ( script �±� �ȿ� ������ �ǰ���.)
	3.�ڹٽ�ũ��Ʈ������ �ű� ������ ó���� ��ɵ��� �����س��´�..  
-->
<meta charset="EUC-KR">
<title>�׽�Ʈ��Ÿ������ �Է� ��</title>
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
		"<tr><td>���������</td><td>����Id</td><td>�������</td><td>����������</td><td>�ּ�</td></tr>" +
		
		"<tr>" +
		"<td><input type=date name=testDate></td>" +
		'<td><input type=text name=testId id="testId"></td>' +
		'<td><input type=text name=testRange></td>' +
		'<td><input type="file" name="file"></td>' +
		'<td><input type=text name=description></td>' +
		"</tr>"+
		"<tr>" +
		'<td id="tempButtonParent" colspan=5>'+
		'������ ���� ���� : <input id="gakMunhangSu" type="number" name="gakMunhangSu"><br>'+
		'�ְ��� ���� ���� : <input id="juMunhangSu" type="number" name="juMunhangSu"><br>'+
		'<input id="tempButton" type="button" value="����� �����ϱ�" onclick="testAnswerInputFormShow()">'+
		"</td></tr>"
	
	

}

function testAnswerInputFormShow() {
	if( document.getElementById("testId").value == "") {
		alert("id�� �ʼ� �Է� �����Դϴ�.");
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
	htmlCode += "<tr><td>������ȣ</td><td>����</td><td>����</td></tr>";
	for( var i = 0 ; i < gakMunhangSu ; i++ ) {
		htmlCode += "<tr><td>������" +( i+1 ) + '��</td><td><input type="number" id=score' +(i+1)+ '></td><td><input type="number" id=answer'+(i+1)+'></td></tr>'
	}
	for( var i = 0 ; i < juMunhangSu ; i++ ) {
		htmlCode += "<tr><td>�ְ���" +( i+1 ) + '��</td><td><input type="number" id=score' +(i+1+Number(gakMunhangSu))+ '></td><td>�������</td></tr>'
	}
	htmlCode += '<tr><td><input type="button" value="��������ϱ�" onclick="finalProcess()"></td>';
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
<input type="submit" value="Ȩ����">
</form>

<form action="testUpload.common" name="newTest" method="post" id="newTest" enctype="multipart/form-data">
	<input type="hidden" id="testBaejumString" name="testBaejumString">
	<input type="hidden" id="testAnswerString" name="testAnswerString">
	<input type="hidden" id="totalScore" name="totalScore">
	<input type="hidden" name="uploadTrue" value="true">

	<div id="newTestMetaDataFormMaker">
		<!-- 
			�� �±� �ȿ� `���ο� ������ ���� ���� ��ư`�� �����  
			`���ο� ������ ���� ���� ��ư`�� ������ �� div�±��� ���빰�� ���ο� ������ ������ �޴� �ڽ��� ���Ѵ�. 
		-->
		<input type="button" value="���ο� ������ �����ϱ�" onclick="testInputFormShow()">
	</div>
</form>

<div id="testMetaDataShowTable">
	<!--
		�� �±� �ȿ� ������ ������ ���� ������ �̹� ������ ���������� ��Ÿ�����͸� ǥ�� ����������.. 
	 -->
	 <table border=1>
	 <tr>
		 <td>���������</td>
		 <td>����Id</td>
		 <td>�������</td>
		 <td>�ּ�</td>
		 <td>����������</td>
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
	document.getElementById("finalSubmit").innerHTML = '<input type="submit" value="�����ϱ�">';
}

</script>
</body>
</html>
