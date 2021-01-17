<%@page import="java.util.ArrayList"%>
<%@page import="vo.Teacher"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.*"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
List<Teacher> teachers = (List<Teacher>) request.getAttribute("teachers");
//request : ���� ��ü : jsp ��ü���� �����Ǵ� ���� ��ü
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>������ ���� ������ �Դϴ�.</title>
</head>
<body>
<form method="post" action="toHome.common">
<input type="submit" value="Ȩ����">
</form>
<hr color="black">

<table border=1 id="table1">

<tr height="170px">
<%
	if( teachers != null ) 
		for( int i = 0 ; i < teachers.size(); i++ ) {
			if( ( i != 0 ) && ( i % 4 == 0 ) ) {
				%>
				</tr><tr>
				<%
			}
			%>
			<td>
				<table border=1 id="table2">
					<tr height="60px"><td width="45px"><img src="../upload/<%=teachers.get(i).getUploadedPictureName() %>" alt="" width="58px" height="43px"></td></tr>
					<tr height="15px"><td width="45px"><%=teachers.get(i).getTeacherId() %></td></tr>
					<tr height="30px"><td width="45px"><%=teachers.get(i).getYakRyeok() %></td></tr>
					<tr height="50px"><td width="45px"><%=teachers.get(i).getHanMaDi() %></td></tr>
				</table>
			</td>
			<%
		}
%>
</tr>
<tr>
	<td colspan=4>
	<form action="teacherManage.common" method="post" enctype="multipart/form-data">
		<table border=1 id="table3">
			<tr height="60px"><td width="45px"><input type="file" name="file"></td></tr>
			<tr height="15px"><td width="45px"><input type="text" name="teacherId" value="�������̸�(���̵�)�Է�"></td></tr>
			<tr height="30px"><td width="45px"><textarea rows="3" cols="40" name="yakRyeok" placeholder="�����Ծ���Է�"></textarea></td></tr>
			<tr height="50px"><td width="45px"><textarea rows="5" cols="40" name="hanMaDi" placeholder="�������Ѹ����Է�"></textarea></td></tr>
			<tr><td align="center"><input type="submit" value="�������߰�"></td></tr>
		</table>
	</form>
	</td>
</tr>
</table>
</body>
</html>