<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script>
function logout() {
	alert('�α׾ƿ� �߽��ϴ�.');
}
</script>
<meta charset="EUC-KR">
<title>�α���ȭ���Դϴ�.</title>
<link type="text/css" rel="stylesheet" href="style.css"></link>
</head>
<body>
<h1>�α���_ȭ���Դϴ�.</h1>
<%
	if( request.getAttribute("logout") != null ) {
		%><script>logout()</script>
		<%
	}
%>
	<form name="logininfo" action="login.common" method="post">
		<table>
			<tr>
				<td>id:</td><td colspan=2><input type="text" name="inputid"></td>
			</tr>
			<tr>
				<td>password: </td><td colspan=2><input type="text" name="inputpassword" ></td>
			</tr>
			<tr>
				<td></td>
				<td><a href="javascript:logininfo.submit()">login</a></td>
				<td><a href="signup.jsp">signup</a></td>
			</tr>
		
		</table>
	</form>
</body>
</html>