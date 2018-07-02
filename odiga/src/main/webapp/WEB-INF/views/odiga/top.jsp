<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
</script>
<html>
<head>
<title>Odiga - 당신이 원하는 곳 어디든지</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>
<style type="text/css">
.center {
   padding: 15px 0;
}

.Nanum{
   font-family: NanumGothic;
   font-weight: bold;
}

.header {
   width: 1200px;
   height: 20px;
}

.header .line_log{
   float: left;
   margin: 4px 6px 0 9px;
   width: 1px;
   height: 42px;
   background: #bfc1c3;
}

.header .line {
   float: left;
   margin: 13px 6px 0 14px;
   width: 1px;
   height: 22px;
   background: #bfc1c3;
}

.find_line {
   float: left;
   width: 1px;
   margin-top: 100px;
   height: 340px;
   margin-bottom: -500px;
   background: #bfc1c3;
}

.header .line_text_log {
   margin: 0 0 0 6px;
   float: left;
}

.header .line_text {
   margin: 14px 0 0 8px;
   float: left;
}

.top_font{
   font-family: 나눔고딕;
   font-weight: bold;
   font-size : 15px;
}

.join_id_font{
	margin-top: 5px;
}

.join_email_font{
	margin-top: 5px;
}

.join_passwd_font{
	font-size: 10px;
	color: red;
}
.font_green{
	font-size: 10px;
	color: green;
	font-style: normal;
}
.font_red{
	font-size: 10px;
	color: red;
}
.join_gong{
	padding-top: 20px;
}

.join_text_gong{
	padding-top: 5px;
}

.email_gong{
	padding-top: 20px;
}

.panel{
	max-height: 0;
    overflow: hidden;
    transition: max-height 0.2s ease-out;
}

.panel_hei{
	margin-top: 5;
	max-height: 50px;
}

.x_button:hover {
    background-color: #0ba700;
}

.x_button{
	color: black;
	background-color: inherit;
	text-align: center;
	padding: 8px 16px;
	cursor: pointer;
}

.x_display-topright {
    position: absolute;
    right: 0;
}

.weather_font{
	font-size: 13px;
	text-align: left;
}

.weather_city{
	padding: 0;
	margin: 2px 4px 2px 4px;
	cursor: pointer;
}

.weather_dropdown-content {
    cursor: auto;
    color: #000;
    background-color: #fff;
    display: none;
    position: absolute;
    min-width: 180px;
    margin: 0;
    padding: 0;
    z-index: 1;
}

</style>
<script type="text/javascript">
function is_Weather() {
    var x = document.getElementById("Weather");
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
    } else { 
        x.className = x.className.replace("w3-show", "");
    }
}

function is_city(city){
	document.getElementById("city").innerHTML = city;
	$.ajax({
		type: 'POST',
		url: 'weatherChange.do',
		dataType: "json",
		data: {
			"city" : city
		},
		success:function(data) {
			 $('#icon').attr('src','http://openweathermap.org/img/w/'+data.icon+'.png');
			document.getElementById("weather_temp").innerHTML = data.temp+"℃";
			document.getElementById("weather_temp_min").innerHTML = data.temp_min+"º";
			document.getElementById("weather_temp_max").innerHTML = data.temp_max+"º";
			$('.weather_dropdown-content').removeClass('w3-show');
	    }
	});
}
function myInformation() {
    var x = document.getElementById("information");
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
    } else { 
        x.className = x.className.replace(" w3-show", "");
    }
}
</script>
</head>
<body>
   <div align = "center" class = "center">
      <div class = "header">
         <div style="float: left;">
            <a href="index.do" class="line_text_log">
               <img src="img/odiga_log.png" style="margin: 7px 10px 0 0; height: 30px; width: 90px;">
            </a>
            <span class="line_log"></span>
       		<div class="line_text" style="margin-left: 2px; margin-top: -2px;">
       			<table>
       				<tr>
       					<td>
       						<div class="w3-dropdown-click">
	       						<label onclick="is_Weather()" style="cursor: pointer; font-family: 나눔고딕; font-weight: bold; padding-top: 10px;" id = "city">${city }</label>
	       						<div id="Weather" class="weather_dropdown-content w3-bar-block" style="border: 1px solid #ccc;">
	       							<c:forEach var="city_name" items="${city_list }">
	       								<label class = "weather_city" onclick="is_city(this.innerHTML)">${city_name }</label>
	       							</c:forEach>
							    </div>
       						</div>
       					</td>
       					<td>
       						<img id = "icon" src='http://openweathermap.org/img/w/${icon }.png'>
       					</td>
       					<td>
       						<font id = "weather_temp" style="font-size: 16px; font-weight: bold; font-family: 나눔고딕-B;">
		      					${temp}℃
		      				</font>
       						<div class = "weather_font">
				      			<font id = "weather_temp_min" color="blue">${temp_min}º</font> / <font id = "weather_temp_max" color = "red">${temp_max}º</font>
				     		</div>
       					</td>
       				</tr>
       			</table>
     		</div>
         </div>
        <c:if test = "${empty sessionScope.user}">
			<div style="float: right;">
				<label class = "line_text" style="cursor: pointer;" onclick="document.getElementById('login').style.display='block'">로그인</label>
				<span class="line"></span>
				<label class = "line_text" style="cursor: pointer;" onclick="document.getElementById('join').style.display='block'">회원가입</label>
				<span class="line"></span>
				<label class = "line_text" style="cursor: pointer;" onclick="location.href = 'info_nonMember.do'">비회원 예약정보</label>
			</div>
         </c:if>
         <c:if test = "${!empty sessionScope.user }">
         	<div style="float: right; padding-top: 13px;">
         		<div onclick="myInformation()" style="  cursor: pointer;">
         			<span style="padding: 15px; border: none; margin: 0; font-size: 15px;">
         				<font style="color:gray;" id = "top_name">${sessionScope.user.user_name }</font>님 환영합니다
         			</span>
         		</div>
				<div id="information" class="w3-dropdown-content w3-bar-block w3-border" style="top:63px; border-radius: 5px;width: 172px; " onclick="myInformation()">
					<label class="w3-bar-item" style="font-weight: lighter;">[${points}]point</label> 
					<a href="info_member.do" class="w3-bar-item w3-button">회원정보</a> 
					<a href="info_schedule.do" class="w3-bar-item w3-button">예약 관리</a> 
					<a href="info_cart.do" class="w3-bar-item w3-button">찜목록</a> 
					<c:if test = "${sessionScope.user.admin == '관리자' && sessionScope.user.id == 'admin'}">
						<a href = "hotel_insert.do" class = "w3-bar-item w3-button">호텔추가</a>
					</c:if>
					<a href="logout.do" class="w3-bar-item w3-button">로그아웃</a>
				</div>
			</div>
         </c:if>
		
		<!-- joinMember -->
		<div id="join"  style="top:0; left :0; display: none; z-index: 3; height: 100%; width: 100%;  position: fixed;" >
			<div style="top: 0; left: 0;right: 0;bottom: 0;position: fixed; background-color: rgba(0,0,0,.5); z-index: 3;"></div>
			<div style="display: table; width: 100%;height: 100%;">
				<div style="display:table-cell; vertical-align: middle;">
					<div style="display: table; margin: 0 auto;">
						<div style="width: 600px; height: 750px; background: white;position: relative; border-radius: 5px; z-index: 4;">
							<div style=" position: relative;">
								<span onclick="document.getElementById('join').style.display='none'" class="x_button x_display-topright" style="border-radius: 5px;">&times;</span>
			      				<%@ include file="/WEB-INF/views/member/join_member.jsp"%>
							</div>
						</div>	
					</div>
				</div>
			</div>
		</div>
		
		<!-- loginMember -->
		<div id="login"  style="top:0; left :0; display: none; z-index: 3; height: 100%; width: 100%; position: fixed;" >
			<div style="top: 0; left: 0;right: 0;bottom: 0;position: fixed; background-color: rgba(0,0,0,.5); z-index: 3;"></div>
			<div style="display: table; width: 100%;height: 100%;">
				<div style="display:table-cell; vertical-align: middle;">
					<div style="display: table; margin: 0 auto;">
						<div style="  width: 450px; height: 420px; background: white;position: relative; border-radius: 5px; z-index: 4;">
							<div style=" position: relative;">
								<span onclick="document.getElementById('login').style.display='none'" class="x_button x_display-topright" style="border-radius: 5px;">&times;</span>
								<%@ include file="/WEB-INF/views/login/login.jsp"%>
							</div>
						</div>	
					</div>
				</div>
			</div>
		</div>
		
		<!-- Id Find -->
			<div id="id_pwd_find"  style="top:0; left :0; display: none; z-index: 3; height: 100%; width: 100%; position: fixed;" >
			<div style="top: 0; left: 0;right: 0;bottom: 0;position: fixed; background-color: rgba(0,0,0,.5); z-index: 3;"></div>
			<div style="display: table; width: 100%;height: 100%;">
				<div style="display:table-cell; vertical-align: middle;">
					<div style="display: table; margin: 0 auto;">
						<div style="width:900px;height: 450px; background: white;position: relative; border-radius: 5px; z-index: 4;">
							<div style=" position: relative;">
								<div class = "w3-green" style="height: 90px;  border-radius: 5px;">
									<div  style="width:480px; padding: 0px; display: table-cell;">
										<%@ include file="/WEB-INF/views/login/login_findId.jsp"%>
									</div>
									<div style="padding:0; display: table-cell;">
										<span class = "find_line"></span>
									</div>
									<div  style="width:480px; padding: 0px;display: table-cell;">
										<span onclick="document.getElementById('id_pwd_find').style.display='none'" class="x_button x_display-topright" style="border-radius: 5px;">&times;</span>
										<%@ include file="/WEB-INF/views/login/login_findPwd.jsp" %>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- pwd_update -->
		<div id="pwd_update"  style="top:0; left :0; display: none; z-index: 3; height: 100%; width: 100%; position: fixed;" >
			<div style="top: 0; left: 0;right: 0;bottom: 0;position: fixed; background-color: rgba(0,0,0,.5); z-index: 3;"></div>
			<div style="display: table; width: 100%;height: 100%;">
				<div style="display:table-cell; vertical-align: middle;">
					<div style="display: table; margin: 0 auto;">
						<div style="width: 400px; height: 390px; background: white;position: relative; border-radius: 5px; z-index: 4;">
							<div style=" position: relative;">
								<span onclick="document.getElementById('pwd_update').style.display='none'" class="x_button x_display-topright" style="border-radius: 5px;">&times;</span>
								<%@ include file="/WEB-INF/views/login/login_updatePwd.jsp"%>
							</div>
						</div>	
					</div>
				</div>
			</div>
		</div>
      </div>
   </div>