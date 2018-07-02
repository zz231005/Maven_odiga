<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게 시 판</title>
</head>
<body>
	<div align="center">
	
	<a href="insertBoard.do">글작성</a>
		<form>
			<table border="">
				<tr>
					<td>번호</td>
					<td>제목</td>
					<td>이름</td>
					<td>날짜</td>
				</tr>

				<c:if test="${empty boardList}">
					<tr>
						<td colspan="4">등록된 공지사항이 없습니다.</td>
					</tr>

				</c:if>
				<c:forEach var="dto" items="${boardList}">
					<tr>
						<td>${dto.no}</td>
						<td><a href="content.do?no=${dto.no}">
						${dto.title}</a></td>
						<td>${dto.name}</td>
						<td>${dto.board_date}</td>
					</tr>
				</c:forEach>
			</table>
		</form>
	</div>
</body>
</html>