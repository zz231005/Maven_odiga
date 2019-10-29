<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>내 찜목록</title>
<style>
#side{
width:25%;
}

#cart{
width:75%;
}

.info_ul {
    list-style-type: none;
    margin-top:20px;
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
</style>
</head>

<div id="info_top">
<%@ include file="../odiga/top.jsp"%>
</div>

<body>
<div style="padding-top:35px; width:1200px; margin-left: auto; margin-right: auto">
<div style="display: table-cell; box-shadow: 8px 2px 8px #ddd; width: 290px;">
	<ul class="info_ul w3-padding">
		<li class="info_li">
			<a href="info_member.do" style="cursor: pointer;">
				<i class="glyphicon glyphicon-user w3-large" style="padding-right: 20px;"></i>
				<font style="font-size: 18px; font-weight: bold; cursor: pointer;" >회원정보</font>
			</a>
		</li>
		<li class="info_li">
			<a href="info_schedule.do" style="cursor: pointer;">
				<i class="fa fa-bars w3-large" style="padding-right: 20px;"></i>
				<font style="font-size: 18px; font-weight: bold; cursor: pointer;" >예약 관리</font>
			</a>
		</li>
		<li class="info_li">
			<a style="cursor: pointer;">
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

<div id="cart" style="display:table-cell; padding-left: 40px; padding-bottom:20px;">
	<iframe name="cart_iframe" frameborder="0" scrolling="no" width="800px;"  src="info_cartlist.do?pageNum=1" style="min-height: 800px;"></iframe>
</div>
</div>
</body>

<%@ include file="../odiga/bottom.jsp"%>

</html>