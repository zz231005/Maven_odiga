<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="euc-kr"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .button_ok {
   background-color: #4CAF50;
   border: none;
   border-radius: 7px;
   color: white;
   padding:13px 35px;
   text-align: center;
   text-decoration: none;
   display: inline-block;
   font-size: 17px;
   -webkit-transition-duration: 0.4s;
   transition-duration: 0.4s;
   cursor: pointer;
}

.button_ok_on {
    background-color: #4CAF50; 
    color: white; 
}

.button_ok_on:hover {
    background-color: #59DA50;
    color: white;
}
</style>
    
    
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<%@ include file="../odiga/top.jsp"%>


<div style="padding-bottom: 20px;" align="center">
	<div align = "center" style="width: 1200px; padding-top:40px; min-height: 900px; ">
		<form action = "info_nonMember.do" method = "post">
			<input type = "hidden" name = "pageNum" value = "1">
			<div style="display: table-cell; padding-right: 8px ">
				<input name = "name" type="text" value = "${name }" class="w3-input" style="display: table-cell; width: 300px; border: 1px solid #ddd; border-radius:5px; box-shadow: 0px 0px 15px #cacaca;padding: 17px 10px;" placeholder="이름">
				<input name = "email" type="text" value = "${email }"  class="w3-input" style="display: table-cell; width: 300px; border: 1px solid #ddd; border-radius:5px; box-shadow: 0px 0px 15px #cacaca; padding: 17px 10px;" placeholder="이메일">
			</div>
			<div  style="display: table-cell; width: 300px; border: 1px solid #ddd; box-shadow: 0px 0px 15px #cacaca; padding: 10px 0; border-radius:5px;">
				<div style="display: table-cell;">
					<label>결제방식 :</label>
				</div>
				<div style="display: table-cell;">
					<select name = "pay_mode" class="w3-input" style="width: 200px;" >
						<option value="card" style="padding: 5px;">카드</option>
						<option value ="deposit"  style="padding: 5px;"
							<c:if test = "${pay_mode ==  'deposit'}">selected</c:if>>무통장입금</option>
					</select>
				</div>
			</div>
			<div style="display: table-cell;padding-left: 8px">
				<input type = "submit" class="button_ok" value ="조회하기" style="display: table-cell;">
			</div>
		</form>
		<ul class="w3-ul w3-card-4" style="border:1px solid #ddd; margin-top:10px;">
			<c:forEach var="non_list" items="${non_list}">
				<li class="w3-bar" style="border-bottom:1px solid #ddd; margin-bottom:5px; text-align: left;">
					<span onclick="location.href='deleteSchedule.do?num=${non_list.num}&id=${email}'" class="w3-bar-item w3-button w3-white w3-xlarge w3-right">×</span>
					<img onclick="location.href='hotel_content.do?num=${non_list.hotelDTO.num}'" src="hotel_img/${non_list.hotelDTO.getOneFilename()}" class="w3-bar-item w3-round w3-hide-small" style="width:200px">
					<div class="w3-bar-item">
						<span class="w3-large"><p>${non_list.hotelDTO.name}</p></span>
						<p>${non_list.hotelDTO.roadaddrpart1}</p>
						<p>평점:
						<c:forEach var = "i" begin="1" end="5">
							<c:choose>
								<c:when test="${(non_list.hotelDTO.score / 2) >= i}">
									<i class="fa fa-star" style="font-size:16px; color:orange;"></i>
								</c:when>
								<c:when test="${ 0.4 < ( 1 - (i - (non_list.hotelDTO.score/2)) ) && ( 1-(i - (non_list.hotelDTO.score/2)) ) < 1 }">
									<i class="fa fa-star-half-o" style="font-size:16px; color:orange;"></i>
								</c:when>
								<c:otherwise>
									<i class="fa fa-star-o" style="font-size:16px;color:orange;"></i>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						</p>
						<p>가격:${non_list.price}원</p>
						<p>예약일 : ${non_list.startdate} ~ ${non_list.enddate}</p>
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
		<c:if test = "${!empty maxPage && maxPage != 0}">
			<div class="w3-center" style="padding-top:20px;">
				<div class="w3-bar w3-border">
					<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<c:choose>
						<c:when test="${i == pageNum}"> 
						<span class="w3-bar-item w3-button">${i}</span>
						</c:when>
						<c:otherwise>
						<a href="info_nonMember.do?pageNum=${i}"><span class="w3-bar-item w3-button">${i}</span></a>
						</c:otherwise>
					</c:choose>
					</c:forEach>
				</div>
			</div>
		</c:if>
		</div>
	</div>
<%@ include file="../odiga/bottom.jsp" %>