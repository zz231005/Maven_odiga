<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>글 작성</title>
</head>
<body>
<div align="center">

	<form action="board_inset.do" method="post">
		<table width="600" border="1">
		<tr>
		<td width="30%">작성자</td><td width="60%">
		<input type="text" name="name" size="60"></td>
		</tr>
		<tr>
			<th width="30%">재목</th>
			<td width="60%">
			<input type="text" name="title" size="60">
			</td>
		</tr>
		<tr>
		<td colspan="2" align="center">내용</td>
		</tr>	
			
			<tr>
			<th colspan="2">
			<textarea name="content" rows="18" cols="52"></textarea>
			</th>
			</tr>
			
			<tr>
			<td width="30%">
			비밀번호			
			</td>
			<td> <input name = "password" type="password" size="40"></td>
			</tr>
		</table>
		
			<input type="submit" value="저장">
			<a href="board.do">목록으로</a>
	</form>


</div>
</body>
</html>