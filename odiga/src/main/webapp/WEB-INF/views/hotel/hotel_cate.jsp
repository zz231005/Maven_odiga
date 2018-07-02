<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<jsp:useBean id="today" class="java.util.Date" />
<%@ page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<c:set var="tomorrow" value="<%=new Date(new Date().getTime() + 60 * 60 * 24 * 1000)%>" />

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>
<style>
.hotel_list {
	position: absolute;
}

.list_box {
	background-color: white;
	position: absolute;
	height: 300px;
	width: 45px;
	display: table-cell;
}

.box_margin {
	background-color: #abc;
	width: 100px;
	height: 100px;
	display: table-cell;
}

.list_button {
	border: none;
	display: inline-block;
	padding: 5px 15px;
	vertical-align: middle;
	overflow: hidden;
	text-decoration: none;
	color: inherit;
	background-color: inherit;
	text-align: center;
	cursor: pointer;
	white-space: nowrap;
}

.list_button:hover {
	background-color: #E7E7E7;
}

.gallery {
	margin: 3px;
	border: 1px solid #ccc;
	float: left;
	width: 350px;
}

.gallery:hover {
	border: 1px solid #777;
	box-shadow: 3px 3px 6px #A6A6A6;
}

.desc {
	padding: 15px;
	text-align: left;
}

.price {
	padding: 15px;
	text-align: right;
}

.gallery_pointer {
	display: table-cell;
	padding-right: 5px;
	cursor: pointer;
}

.button_ok {
	background-color: #4CAF50;
	border: none;
	border-radius: 4px;
	color: white;
	padding: 12px 23px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
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

.box {
	display: block;
	position: relative;
	font-size: 0;
	padding-bottom: 15px;
	padding-top: 15px;
	background-color: hsla(0, 0%, 100%, .65);
	margin-top: 45px;
}

.min_box {
	padding-right: 80px;
	background-color: white;
	vertical-align: middle;
	display: table-cell;
}

.min_box_img {
	background-color: none;
	vertical-align: middle;
	display: table-cell;
}

i {
	padding: 10px 3px;
}


.box .img_next {
	vertical-align: middle;
	border-radius: 5px;
	display: table-cell;
}

input[type="text"] {
	width: 100%;
	padding-right: 13px;
	padding-top: 14px;
	padding-bottom: 13px;
	font-family: inherit;
	letter-spacing: inherit;
	outline: none;
	cursor: pointer;
}

input[type="password"] {
	width: 100%;
	padding-right: 13px;
	padding-top: 14px;
	padding-bottom: 13px;
	font-family: inherit;
	letter-spacing: inherit;
	outline: none;
	cursor: pointer;
}

input[type="date"] {
	width: 100%;
	padding: 12px;
	padding-top: 13px;
	border: none;
	font-family: inherit;
	letter-spacing: inherit;
	outline: none;
}

.box .search {
	cursor: pointer;
}

.box .gong {
	vertical-align: middle;
	display: table-cell;
	width: 5px;
}

.box_input {
	width: 100%;
	vertical-align: middle;
	line-height: 1.25;
}

body {
	margin: 0px;
	padding: 0px;
}

.Nanum {
	font-family: NanumGothic;
	font-weight: bold;
}

.main_image {
	width: 100%;
	height: 500px;
}

.line {
	border-top: 1px solid;
	border-top-color: white;
}

.jbMenu {
	background-color: hsla(0, 0%, 100%, .55);
	top: 470px;
	padding: 25px 0px;
	width: 100%;
	vertical-align: middle;
}

.jbFixed {
	background-color: #4C4C4C;
	position: fixed;
	padding: 12px 0px;
	top: 0;
	z-index: 999;
}

.display-topmiddle {
	position: absolute;
	left: 50%;
	transform: translate(-50%, 0%);
	width: 950px;
	border-radius: 7px;
}
</style>
<script>
	$(document).ready(function() {
		var jbOffset = $('#Menu').offset();
		$(window).scroll(function() {
			if ($(document).scrollTop() >= jbOffset.top + 12) {
				$('#Menu').addClass('jbFixed');
				$('#Menu').removeClass('display-topmiddle');
			} else {
				$('#Menu').addClass('display-topmiddle');
				$('#Menu').removeClass('jbFixed');
			}
		});
	});

	function search_img() {
		document.getElementById("search").focus();
	}
	
	$.fn.generateStars = function() {
	    return this.each(function(i,e){$(e).html($('<span/>').width($(e).text()*8));});
	};
	
	function go_search() {
		if (f_search.search.value == "") {
			alert("지역이나 호텔명을 입력하세요!!");
			return false;
		}else{
			f_search.submit();
		}
	}

	
</script>
<%@include file="/WEB-INF/odiga/top.jsp"%>
<%
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("YYYY-MM-dd");
	String date = sdf.format(new java.util.Date());
%>

<div align="center" style="width: 100%; max-width: 100%; vertical-align: middle; margin-top: 30px;">
	<img src="city_img/${city}.jpg"  width=100% height=600 style="object-fit: cover;">
	<!-- TEXT -->
	<div class="w3-display-topmiddle" style="top: 260px; min-height: 130px;">
		<font class="Nanum" size="10" color="white"
			style="text-shadow: 2px 2px 5px black;">당신이 원하는 곳 어디든지</font><br>
		<font class="Nanum" size="10" color="Yellow"
			style="text-shadow: 2px 2px 5px black;">${title }_ODIGA</font> <font
			class="Nanum" size="10" color="white"
			style="text-shadow: 2px 2px 5px black;">가 함께합니다</font><br>
	</div>
	<div id="Menu" class="jbMenu display-topmiddle">
		<form name = "f_search" action="hotel_search.do"  method="post" style="margin: 0; ">
			<!-- 검색 -->
			<input name = "search" type="text" class="w3-input"
				style="display: table-cell; width: 300px;" placeholder="도시,지역,숙소명">
			<input type="date" name="start"
				min="<fmt:formatDate value="${today }" type="DATE" pattern="yyyy-MM-dd"/>"
				value="<fmt:formatDate value="${today }" type="DATE" pattern="yyyy-MM-dd"/>"
				class="w3-input" style="display: table-cell; width: 200px;">
			<input type="date" name="end"
				min="<fmt:formatDate value="${tomorrow }" type="DATE" pattern="yyyy-MM-dd"/>"
				value="<fmt:formatDate value="${tomorrow }" type="DATE" pattern="yyyy-MM-dd"/>"
				class="w3-input" style="display: table-cell; width: 200px;">
			<input type = "submit" class="button_ok" onclick="return go_search()" value ="요금검색하기" style="display: table-cell;">
			<input type = "hidden" name = "pageNum" value = "1">
		</form>
	</div>
</div>

<div align="center">
	<div style="padding: 80px 0 20px 0">
		<font class="Nanum" size="5px">《 지역 상품 보기 》</font><br>
	</div>
	<div class="hotel_cate" style="padding-bottom: 50px; width: 1080px; text-align: center;">
		<div style="text-align: left;">
		<!-- left로 좌우 간격 맞추기 -->
			<c:set var = "j" value = "0"/>
			<c:forEach var="dto" items="${hotel_cate}">
				<c:if test="${j % 3 == 0}">
					<br>
				</c:if>
				<c:set var = "j" value = "${j + 1 }"/>
				<div class="gallery_pointer">
					<div class="gallery"
						onclick="parent.location.href = 'hotel_getOne.do?num=${dto.num}'">
						<img src="hotel_img/${dto.getOneFilename() }" width=100%
							height=200 style="object-fit: cover;">
						<div class="desc" style="height: 70px;">
							<font size="3px" color="blue" style="font-weight: bold;">${dto.name }</font><br>
							<font size="2px">${dto.getAdd_Easy()}</font><br>
							<c:forEach var="i" begin="1" end="5">
								<c:choose>
									<c:when test="${(dto.score / 2) >= i}">
										<i class="fa fa-star" style="font-size: 24px; color: orange;"></i>
									</c:when>
									<c:when
										test="${ 0.4 < ( 1 - (i - (dto.score/2)) ) && ( 1-(i - (dto.score/2)) ) < 1 }">
										<i class="fa fa-star-half-o"style="font-size: 24px; color: orange;"></i>
									</c:when>
									<c:otherwise>
										<i class="fa fa-star-o" style="font-size: 24px; color: orange;"></i>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
						<div class="price">
							<hr size="3">
							<font size="4px" color="Red" style="font-weight: bold;">
								￦  <fmt:formatNumber value="${dto.price }"
								groupingUsed="true" /></font>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
<%@include file="/WEB-INF/odiga/bottom.jsp"%>