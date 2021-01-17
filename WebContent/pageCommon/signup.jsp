<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원가입페이지</title>
</head>
<body>
<form action="signup.common" method="post">
<table border=1>
	<tr>
		<td>아이디</td>
		<td><input type="text" name="studentId"></td>
	</tr>	<tr>
		<td>비밀번호</td>
		<td><input type="text" name="studentPassword"></td>
	</tr>	<tr>
		<td>이름</td>
		<td><input type="text" name="studentName"></td>
	</tr>	<tr>
		<td>나이</td>
		<td><input type="number" name="studentAge"></td>
	</tr>	<tr>
		<td>학교</td>
		<td><input type="text" name="studentSchool"></td>
	</tr>	<tr>
		<td>전화번호</td>
		<td><input type="text" name="studentPhone"></td>
	</tr>	<tr>
		<td>부모님연락처</td>
		<td><input type="text" name="studentMotherPhone"></td>
	</tr>	
</table>
<input type="submit" value="가입하기" >
</form>

</body>
</html>