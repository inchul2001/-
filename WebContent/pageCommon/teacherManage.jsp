<%@page import="java.util.ArrayList"%>
<%@page import="vo.Teacher"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.*"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
List<Teacher> teachers = (List<Teacher>) request.getAttribute("teachers");
//request : 내장 객체 : jsp 자체에서 제공되는 내장 객체
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>선생님 관리 페이지 입니다.</title>
</head>
<body>
<form method="post" action="toHome.common">
<input type="submit" value="홈으로">
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
			<tr height="15px"><td width="45px"><input type="text" name="teacherId" value="선생님이름(아이디)입력"></td></tr>
			<tr height="30px"><td width="45px"><textarea rows="3" cols="40" name="yakRyeok" placeholder="선생님약력입력"></textarea></td></tr>
			<tr height="50px"><td width="45px"><textarea rows="5" cols="40" name="hanMaDi" placeholder="선생님한마디입력"></textarea></td></tr>
			<tr><td align="center"><input type="submit" value="선생님추가"></td></tr>
		</table>
	</form>
	</td>
</tr>
</table>
</body>
</html>