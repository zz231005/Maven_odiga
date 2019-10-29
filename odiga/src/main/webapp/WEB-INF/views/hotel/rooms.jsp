<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<style type="text/css">
.line {
   float: left;
   width: 1px;
   height: 20px;
 	margin-top: 10px;
 	margin: 0 10px;
   background: #bfc1c3;
}

label{
	font-weight: bold;
} 
</style>
<title>Insert title here</title>
</head>
<body>

<div style="width: 100%; padding-bottom:15px;">
	<c:forEach var = "dto" items= "${room_list }">
	<div style="border-top: 4px solid #CFCFCF; border-bottom: 4px solid #CFCFCF; border-radius: 20px; box-shadow: 0px 0px 5px #BDBDBD; height: 190px;margin: 10px;">
		<div style="width: 250px; height: 170px; display: table-cell; border-right: 1px solid #ddd; margin: 3px; width: 20%; padding: 10px;">
			<img src="room_img/${dto.room_img}" style="width: 100%; height: 100%; object-fit: cover; border-radius: 5px;" />
		</div>
		<div style="width: 100%; display: table-cell;   vertical-align: top;">
			<div style=" padding:20px; border-bottom: 1px solid #ddd; display: table-cell; width: 670px;">
				<label style="font-size: 18px; font-weight: bold;">${dto.room_name }</label>
			</div>
			<div style="padding: 20px 20px;">
				<div style="border: 0 1px 0 0 solid #ddd; width: 600px;">
					<c:choose>
						<c:when test = "${dto.smoking }">
							<div style="float: left;">
								<i class="material-icons" style="font-size:16px;">smoking_rooms</i>
								<label style="font-size: 14px;">흡연 가능</label>
							</div>
						</c:when>
						<c:otherwise>
							<div style="float: left;">
								<i class="material-icons" style="font-size:16px;">smoke_free</i>
								<label style="font-size: 14px;">흡연 불가능</label>
							</div>
						</c:otherwise>
					</c:choose>
					<c:if test = "${dto.wifi }">
						<span class = "line"></span>
						<div style="float: left;">
							<i class="material-icons" style="font-size:16px;">wifi</i>
							<label>객실 wifi</label>
						</div>
					</c:if>
					<c:if test = "${dto.breakfast }">
						<span class = "line"></span>
						<div style="float: left;">
							<i class="material-icons" style="font-size:16px;">restaurant</i>
							<label style="font-size: 14px;">조식 포함</label>
						</div>
					</c:if>
					<c:if test = "${dto.smoking }">
						<span class = "line"></span>
						<div style="float: left;">
							<i class="material-icons" style="font-size:16px;">smoking_rooms</i>
							<label style="font-size: 14px;">흡연 가능</label>
						</div>
					</c:if>
					<c:choose>
						<c:when test = "${dto.smoking }">
							<span class = "line"></span>
							<div style="float: left;">
							<i class="material-icons" style="font-size:16px;">local_dining</i>
							<label style="font-size: 14px;">취사 가능</label>
						</div>
						</c:when>
						<c:otherwise>
							<span class = "line"></span>
							<div style="float: left;">
							<i class="material-icons" style="font-size:16px;">local_dining</i>
							<label style="font-size: 14px;">취사 불가능</label>
						</div>
						</c:otherwise>
					</c:choose>
				</div><br>
				<div style=" text-align: left; float: left; padding-top:20px;">
					<div style="font-size :14px">
						<label>기본인원 : </label>
						<label>${dto.minp }</label>
					</div>
					<div style="font-size :14px">
						<label >최대인원 : </label>
						<label>${dto.maxp }</label>
					</div>
				</div>
				<div style="float: right; vertical-align: bottom; padding-top:30px;">
					<label style="font-size: 20px; font-weight: bold;">￦ <fmt:formatNumber value="${dto.price }" groupingUsed="true"/></label>
				</div>
			</div>
		</div>
	</div>
	</c:forEach>
</div>
<script type="text/javascript">
	parent.document.all.rooms_iframe.height = document.body.scrollHeight; 
</script>
</body>
</html>