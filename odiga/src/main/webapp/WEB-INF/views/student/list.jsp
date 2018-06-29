<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<html>
<head>
	<title>학생목록</title>
</head>
<body>
<div align="center">
	<hr color="green" width="300">
	<h2>학 생 목 록 보 기</h2>
	<a href="student.do">학생관리</a>
	<hr color="green" width="300">
	<table border="1" width="500">
		<tr bgcolor="yellow">
			<th>아이디</th>
			<th>학생명</th>
			<th>학급명</th>
		</tr>
		<c:if test="${list==null or list.isEmpty()}">
		<tr>
			<td colspan="3">등록된 학생이 없습니다.</td>		
		</tr>			
		</c:if>
		<c:forEach var="dto" items="${list}">
		<tr>
			<td>${dto.id}</td>
			<td>${dto.name}</td>
			<td>${dto.cname}</td>
		</tr>
		</c:forEach>
	</table>
</div>
</body>
</html>





