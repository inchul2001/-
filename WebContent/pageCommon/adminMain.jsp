<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h2>
관리자 메인화면
</h2>

<table>
	<tr><td><form method="post" action="teacherManage.common"><input type="submit" value="선생님 프로필 관리"></form></td></tr>
	<tr><td><form method="post" action="lectureMakeForm.common"><input type="submit" value="시간표 작성"></form></td></tr>
	<tr><td><form method="post" action="studentBasicManage.common"><input type="submit" value="학생정보 관리"></form></td></tr>
	<tr><td><form method="post" action="attendance.common"><input type="submit" value="학생출석 관리"></form></td></tr>
	<tr><td><form method="post" action="testUpload.common"><input type="submit" value="시험지 메타데이터 입력하기"></form></td></tr>
	<tr><td><form method="post" action="indivScoreInputForm.common"><input type="submit" value="개별 학생 점수 입력"></form></td></tr>
</table>

</body>
</html>