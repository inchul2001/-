<%@page import="java.util.ArrayList"%>
<%@page import="vo.StudentBasic"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.*"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
List<StudentBasic> sts = (List<StudentBasic>) request.getAttribute("students");
//request : ���� ��ü : jsp ��ü���� �����Ǵ� ���� ��ü
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�л��⺻���� ���� �������Դϴ�.</title>
</head>
<body>
<form method="post" action="toHome.common">
<input type="submit" value="Ȩ����">
</form>
<hr color="black">

<form method="post" action="studentBasicManage.common">
<input type="hidden" name="recursive" value="fromAdminInfoManage">
	 <table border=1>
	 <tr>
		 <td>�л����̵�</td>
		 <td>��й�ȣ</td>
		 <td>�̸�</td>
		 <td>����</td>
		 <td>�б�</td>
		 <td>��ȭ��ȣ</td>
		 <td>�θ�Կ���ó</td>
		 <td></td>
	 </tr>
	<%
	if( sts != null ) {
	for(int i = 0; i < sts.size() ; i++ ) { %>
		<tr>
			<td><table id="table_row<%=i%>,column=1"><tr><td><%=sts.get(i).getStudentId() %></td></tr><tr><td id="row<%=i%>,column=1"></td></tr></table></td>
			<td><table id="table_row<%=i%>,column=2"><tr><td><%=sts.get(i).getStudentPassword() %></td></tr><tr><td id="row<%=i%>,column=2"></td></tr></table></td>
			<td><table id="table_row<%=i%>,column=3"><tr><td><%=sts.get(i).getStudentName() %></td></tr><tr><td id="row<%=i%>,column=3"></td></tr></table></td>
			<td><table id="table_row<%=i%>,column=4"><tr><td><%=sts.get(i).getStudentAge() %></td></tr><tr><td id="row<%=i%>,column=4"></td></tr></table></td>
			<td><table id="table_row<%=i%>,column=5"><tr><td><%=sts.get(i).getStudentSchool() %></td></tr><tr><td id="row<%=i%>,column=5"></td></tr></table></td>
			<td><table id="table_row<%=i%>,column=6"><tr><td><%=sts.get(i).getStudentPhone() %></td></tr><tr><td id="row<%=i%>,column=6"></td></tr></table></td>
			<td><table id="table_row<%=i%>,column=7"><tr><td><%=sts.get(i).getStudentMotherPhone() %></td></tr><tr><td id="row<%=i%>,column=7"></td></tr></table></td>
			<td><table id="table_row<%=i%>,column=8"><tr><td><input type=button value=���������ϱ� onclick="dataModifyFormShow(<%=i %>,'<%=sts.get(i).getStudentId() %>')"></td></tr><tr><td id="row<%=i%>,column=8"></td></tr></table></td>
		</tr>
	<% } }%>	
	 
	 </table>
</form>
</body>
<script>
function dataModifyFormShow( index, id ) {
	for( var i = 1 ; i <= 8 ;i++ ) {
		document.getElementById("table_row"+index+",column="+i).setAttribute("border" , "1") ;
	}
	document.getElementById("row"+index+",column=1").innerHTML='���̵𺯰�Ұ�<input name="studentId" type=hidden value='+id+'>';
	document.getElementById("row"+index+",column=2").innerHTML='<input name="studentPassword" type=text>';
	document.getElementById("row"+index+",column=3").innerHTML='<input name="studentName" type=text>';
	document.getElementById("row"+index+",column=4").innerHTML='<input name="studentAge" type=number>';
	document.getElementById("row"+index+",column=5").innerHTML='<input name="studentSchool" type=text>';
	document.getElementById("row"+index+",column=6").innerHTML='<input name="studentPhone" type=text>';
	document.getElementById("row"+index+",column=7").innerHTML='<input name="studentMotherPhone" type=text>';
	document.getElementById("row"+index+",column=8").innerHTML='<input type=submit value="Ȯ��">';
	
	
}
</script>
</html>