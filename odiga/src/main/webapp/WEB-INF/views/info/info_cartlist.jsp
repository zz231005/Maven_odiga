<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div class="w3-container">
  <h2>내 찜목록</h2>
  <ul class="w3-ul w3-card-4">
  
  	<c:forEach var="cart" items="${cart}">
  	<li class="w3-bar" style="border-bottom:1px solid #ddd; margin-bottom:5px;">
		<span id="x_bt" onclick="parent.document.location.href='info_deletecart.do?num=${cart.num}'" class="w3-bar-item w3-button w3-white w3-xlarge w3-right">×</span>
      	<img src="hotel_img/${cart.hotelDTO.getOneFilename()}" onclick="parent.document.location.href='hotel_content.do?num=${cart.hotelDTO.num}'" class="w3-bar-item w3-round w3-hide-small" style="width:200px">
		<div class="w3-bar-item">
			<span class="w3-large"><p>${cart.hotelDTO.name}</p></span>
			<p>${cart.hotelDTO.roadaddrpart1}</p>
			<p>평점:
			<c:forEach var = "i" begin="1" end="5">
				<c:choose>
					<c:when test="${(cart.hotelDTO.score / 2) >= i}">
						<i class="fa fa-star" style="font-size:16px; color:orange;"></i>
					</c:when>
					<c:when test="${ 0.4 < ( 1 - (i - (cart.hotelDTO.score/2)) ) && ( 1-(i - (cart.hotelDTO.score/2)) ) < 1 }">
						<i class="fa fa-star-half-o" style="font-size:16px; color:orange;"></i>
					</c:when>
					<c:otherwise>
						<i class="fa fa-star-o" style="font-size:16px;color:orange;"></i>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			</p>
			<p>가격:${cart.hotelDTO.price}원</p>
		</div>
	</li>
    </c:forEach>
  </ul>
  
 <c:set var="startPage" value="1"/>
<c:set var="endPage" value="${maxPage}"/>
<c:if test="${pageNum > 3 }">
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
			<a href="info_cartlist.do?pageNum=${startPage}"><span class="w3-bar-item w3-button">&laquo;</span></a>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<c:choose>
					<c:when test="${i==pageNum}"> 
					<span class="w3-bar-item w3-button">${i}</span>
					</c:when>
					<c:otherwise>
					<a href="info_cartlist.do?pageNum=${i}"><span class="w3-bar-item w3-button">${i}</span></a>
					</c:otherwise>
				</c:choose>
				</c:forEach>
			<a href="info_cartlist.do?pageNum=${endPage}"><span class="w3-bar-item w3-button">&raquo;</span></a>
			</div>
		</div>
		</c:if>
</div>

<script type="text/javascript">
   	parent.document.all.cart_iframe.height = document.body.scrollHeight; 
</script> 
</body>
</html>