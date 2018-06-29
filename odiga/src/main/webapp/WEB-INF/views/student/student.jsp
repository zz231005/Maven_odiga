<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
<head>
	<title>학생관리</title>
</head>
<body>
<div align="center">
<%-- <center>태그 --%>
	<hr color="green" width="300">
	<h2>학 생 등 록 페 이 지</h2>
	<hr color="green" width="300">
	<form name="insert" method="post" action="student_insert.do"
			enctype="multipart/form-data">
		<table border="1">
			<tr>
				<td>
					아이디 : <input type="text" name="id"><br>
					학생명 : <input type="text" name="name"><br>
					학급명 : <input type="text" name="cname"><br>
					파일명 : <input type="file" name="filename"><br>
					<input type="submit" value="등록">
					<input type="reset" value="취소">
				</td>
			</tr>
		</table>
	</form>
	<hr color="green" width="300">
	<h2>학 생 삭 제 페 이 지</h2>
	<hr color="green" width="300">
	<form name="delete" method="post" action="student_delete.do">
		<table border="1">
			<tr>
				<td>
					아이디 : <input type="text" name="id">
					<input type="submit" value="삭제">
				</td>
			</tr>
		</table>
	</form>
	<hr color="green" width="300">
	<h2>학 생 찾 기 페 이 지</h2>
	<hr color="green" width="300">
	<form name="find" method="post" action="find.jsp">
		<table border="1">
			<tr>
				<td>
					학생명 : <input type="text" name="name">
					<input type="submit" value="찾기">
				</td>
			</tr>
		</table>
	</form>
	<hr color="green" width="300">
	<h2>학 생 목 록 페 이 지</h2>
	<hr color="green" width="300">
	<form name="list" method="post" action="student_list.do">
		<table border="1">
			<tr>
				<td>
					<input type="submit" value="목록보기">
				</td>
			</tr>
		</table>
	</form>
</div>	
</body>
</html>











