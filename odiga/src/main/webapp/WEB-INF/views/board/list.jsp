<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�� �� ��</title>
</head>
<body>
	<div align="center">
	
	<a href="insertBoard.do">���ۼ�</a>
		<form>
			<table border="">
				<tr>
					<td>��ȣ</td>
					<td>����</td>
					<td>�̸�</td>
					<td>��¥</td>
				</tr>

				<c:if test="${empty boardList}">
					<tr>
						<td colspan="4">��ϵ� ���������� �����ϴ�.</td>
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