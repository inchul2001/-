<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script>
function logout() {
	alert('로그아웃 했습니다.');
}
</script>
<meta charset="EUC-KR">
<title>로그인화면입니다.</title>
<link type="text/css" rel="stylesheet" href="style.css"></link>
</head>
<body>
<h1>로그인_화면입니다.</h1>
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