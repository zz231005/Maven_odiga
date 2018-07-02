<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>Odiga 예약관리 입니다.</title>
</head>
<style>
#side{
width:25%;
}

#cart{
width:75%;
}

.info_ul {
	margin-top:20px;
    list-style-type: none;
    background-color: white;
    position: absolute;
    height: 500px;
    overflow: auto;
    text-align: left;
}

.info_li a {
    display: block;
    color: #000;
    padding: 8px 100px 8px 20px;
    text-decoration: none;
}


.info_li a:hover{
    background-color: #555;
    color: white;
}

.pagination {
    display: inline-block;
}

.pagination div {
    color: black;
    float: left;
    padding: 8px 16px;
  	text-decoration: none;
}

.pagination div.active {
    background-color: #4CAF50;
    color: white;
    border-radius: 5px;
}

.pagination div:hover:not(.active) {
    background-color: #ddd;
    border-radius: 5px;
}
</style>

<script type="text/javascript">
var c_ccheck_hei, b_bcheck_hei;
function bookingCheck(evt, checked) {
  var i, x, tablinks;
  x = document.getElementsByClassName("booking");
  for (i = 0; i < x.length; i++) {
     x[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < x.length; i++) {
     tablinks[i].className = tablinks[i].className.replace(" w3-border-blue", "");
  }
  document.getElementById(checked).style.display = "block";
  evt.currentTarget.firstElementChild.className += " w3-border-blue";
}

</script>


<%@ include file="../odiga/top.jsp"%>

<div style="padding-top:35px; width:1200px; margin-left: auto; margin-right: auto">
	<div style="display: table-cell; box-shadow: 8px 2px 8px #ddd; width: 290px">
		<ul class="info_ul w3-padding">
			<li class="info_li">
				<a href="info_member.do" style="cursor: pointer;">
					<i class="glyphicon glyphicon-user w3-large" style="padding-right: 20px;"></i>
					<font style="font-size: 18px; font-weight: bold; cursor: pointer;" >회원정보</font>
				</a>
			</li>
			<li class="info_li">
				<a style="cursor: pointer;">
					<i class="fa fa-bars w3-large" style="padding-right: 20px;"></i>
					<font style="font-size: 18px; font-weight: bold; cursor: pointer;" >예약 관리</font>
				</a>
			</li>
			<li class="info_li">
				<a href="info_cart.do" style="cursor: pointer;">
					<i class="fa fa-truck w3-large" style="padding-right: 20px;"></i>
					<font style="font-size: 18px; font-weight: bold; cursor: pointer;" >찜목록</font>
				</a>
			</li>
			<li class="info_li">
				<a href="info_delete.do" style="cursor: pointer;">
					<i class="fa fa-search w3-large" style="padding-right: 20px;"></i>
					<font style="font-size: 18px; font-weight: bold; cursor: pointer;" >회원 탈퇴</font>
				</a>
			</li>
		</ul>
	</div>

	<div  style="padding-left: 40px;display: table-cell;">
		<div class="w3-row">
			<div onclick="bookingCheck(event, 'Schedule');" style="cursor: pointer;">
				<div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding w3-border-blue">
					<label style="cursor: pointer;">투숙 예정인 예약</label>
				</div>
		   </div>
			<div onclick="bookingCheck(event, 'Complete');" style="cursor: pointer;">
				<div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding">
				 	<label style="cursor: pointer;">투숙 완료된 예약</label>
				</div>
			</div>
		</div>
	
		<div id="Schedule" class="w3-container booking">
			<iframe name="c_iframe" frameborder="0" scrolling="no" width="800px;" src="info_ccheck.do?pageNum=1"></iframe>
		</div>
		
		<div id="Complete" class="w3-container booking start" >
			<iframe name="b_iframe" frameborder="0" scrolling="no" width="800px;" src="info_bcheck.do?pageNum=1" style="min-height: 800px;"></iframe>
		</div>
	</div>
	
</div>

<%@ include file="../odiga/bottom.jsp" %>

</html>