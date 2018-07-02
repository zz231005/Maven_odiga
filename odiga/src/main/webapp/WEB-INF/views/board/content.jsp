<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>글 상세보기</title>
</head>
<body>
<div align="center">
	<table width="600" border="1">
	
	<tr>
	<td>작성자</td>
	<td>${dto.name}</td>
	</tr>
	
	<tr>
	<td>제목</td>
	<td>${dto.title}</td>
	</tr>
	<tr>
	<td>작성일</td>
	<td>${dto.board_date}</td>
	</tr>
	<tr>
	<td>내용</td>
	<td>${dto.content}</td>
	</tr>
	</table>


</div>

</body>
</html>