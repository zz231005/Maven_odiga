<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<body>
<div style="padding-bottom: 20px;">
	<div style="padding-bottom: 20px;">
		<ul class="w3-ul w3-card-4" style="border:1px solid #ddd; margin-top:10px;">
			<c:forEach var="b_list" items="${b_list}">
				<li class="w3-bar" style="border-bottom:1px solid #ddd; margin-bottom:5px;">
					<span onclick="parent.document.location.href='deleteSchedule.do?num=${b_list.num}'" class="w3-bar-item w3-button w3-white w3-xlarge w3-right">×</span>
					<img onclick="parent.document.location.href='hotel_content.do?num=${b_list.hotelDTO.num}'" src="hotel_img/${b_list.hotelDTO.getOneFilename()}" class="w3-bar-item w3-round w3-hide-small" style="width:200px">
					<div class="w3-bar-item">
						<span class="w3-large"><p>${b_list.hotelDTO.name}</p></span>
						<p>${b_list.hotelDTO.roadaddrpart1}</p>
						<p>평점:
							<c:forEach var = "i" begin="1" end="5">
							<c:choose>
								<c:when test="${(b_list.hotelDTO.score / 2) >= i}">
									<i class="fa fa-star" style="font-size:16px; color:orange;"></i>
								</c:when>
								<c:when test="${ 0.4 < ( 1 - (i - (b_list.hotelDTO.score/2)) ) && ( 1-(i - (b_list.hotelDTO.score/2)) ) < 1 }">
									<i class="fa fa-star-half-o" style="font-size:16px; color:orange;"></i>
								</c:when>
								<c:otherwise>
									<i class="fa fa-star-o" style="font-size:16px;color:orange;"></i>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						</p>
						<p>가격:${b_list.price}원</p>
						<p>예약일 : ${b_list.startdate} ~ ${b_list.enddate}</p>
					</div>
				</li>
    		</c:forEach>
 		 </ul>
 	<c:set var="startPage" value="1"/>
	<c:set var="endPage" value="${maxPage}"/>
			<c:if test="${pageNum > 2 }">
		<c:set var="startPage" value="${pageNum-2 }" />
		<c:if test="${pageNum >= maxPage -1 }">
			<c:set var="startPage" value="${startPage -1 }" />
			<c:if test="${pageNum ==  maxPage}">
				<c:set var="startPage" value="${startPage -1 }" />
			</c:if>
		</c:if>
	</c:if>
	<c:if test="${maxPage > 5 }">
		<c:set var="endPage" value="${startPage + 4 }" />
	</c:if>
							
		<c:if test = "${maxPage != 0 }">
		<div class="w3-center" style="padding-top:20px;">
			<div class="w3-bar w3-border">
			<a href="info_bcheck.do?pageNum=${startPage}"><span class="w3-bar-item w3-button">&laquo;</span></a>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<c:choose>
					<c:when test="${i==pageNum}"> 
					<span class="w3-bar-item w3-button">${i}</span>
					</c:when>
					<c:otherwise>
					<a href="info_bcheck.do?pageNum=${i}"><span class="w3-bar-item w3-button">${i}</span></a>
					</c:otherwise>
				</c:choose>
				</c:forEach>
			<a href="info_bcheck.do?pageNum=${endPage}"><span class="w3-bar-item w3-button">&raquo;</span></a>
			</div>
		</div>
		</c:if>
	</div>
<script type="text/javascript">
	parent.document.all.b_iframe.height = document.body.scrollHeight;
	parent.$("#Complete").css("display", "none");
</script> 
</body>
</html>
