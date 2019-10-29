<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<html>
<head> 
<script type="text/javascript">
function myFunction(num) {
	if(num == 1){
		return
	}
    var x = document.getElementById("room"+num);
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
    }else { 
    	for(var j = num; j <= 5; j++){
    		x = document.getElementById("room" + j);
    		x.className = x.className.replace(" w3-show", "");
    	}
    }
}

function del_hotel(num){
	if("${sessionScope.user.admin}" == "" || "${sessionScope.user.admin}" == null){
		alert("관리자 계정외의 계정은 삭제가 불가능합니다.")
		return;
	}
	location.href = "hotel_delete.do?num="+num;
}
</script>
<style type="text/css">
.x_button{
	color: black;
	background-color: rgba(234,234,234,0.5);
	text-align: center;
	padding: 4px 8px;
	cursor: pointer;
	right :5px;
	outline: none;
	border-radius: 5px;
}

.label_text{
	font-size:13px;
	padding: 0 20px;
	width: 120px;
}
.div_text{
	padding: 5px 0;
	text-align: left;
}

.x_display-topright {
    position: absolute;
}

.in_hotel_text{
	padding:5px;
	background: white;
	border: 1px solid #ddd;
	border-radius: 5px;
}

.option_1{
	display:block!important;
	border: solid 1px #ddd;
}

.in_hotel_text{
	padding:5px;
	background: white;
	border: 1px solid #ddd;
	border-radius: 5px;
}


.in_hotel_bt{
	cursor: pointer;
	background-color: #EAEAEA;
	border: none;
    padding: 8px 16px;
	display: block;
    width: 100%;
    text-align: left;
    outline: none;
    border-radius: 5px;
}

</style>
<title>Insert title here</title>
</head>
<body>
	<div align = "center">
		<form action= "insert_Room.do" method = "post"  enctype="multipart/form-data">
			<input type = "hidden" name = "hotel_num" value = "${hotel_num }">
			<div style="display: table-cell; width: 500px; padding: 15px; background:#E1F6FA; ">
				<c:forEach var = "j" begin="1" end = "5">
					<button onclick="myFunction('${j}')" type="button" class="in_hotel_bt">Room_Option ${j }</button>
					<div id="room${j }" class="w3-hide option_${j }">
						<div style="text-align: left;" class = "div_text">
							<div style="display: table-cell;" class = "label_text">
								객실 이름
							</div>
							<div style="display: table-cell;">
								<input type = "text" name = "room_name_${j}"class="in_hotel_text" size = "30">
							</div>
						</div>
						<div style="text-align: left;" >
							<div class = "div_text">
								<div style="display: table-cell; " class = "label_text">
									기준 인원
								</div>
								<div style="display: table-cell;">
									<input type = "text" name = "minp_${j}"class="in_hotel_text" size = "10">
								</div>
								<div style="display: table-cell;">
									<label style="font-size: 12px; color:#A6A6A6; padding-left: 5px;">요금기준 인원을 입력하세요.</label>
								</div>
							</div>
							<div class = "div_text">
								<div style="display: table-cell;" class = "label_text">
									최대 인원
								</div>
								<div style="display: table-cell;">
									<input type = "text" name = "maxp_${j}"class="in_hotel_text" size = "10">
								</div>
								<div style="display: table-cell;">
									<label style="font-size: 12px; color:#A6A6A6; padding-left: 5px;">객실의 최대인원을 입력하세요.</label>
								</div>
							</div>
							<div class = "div_text">
								<div style="display: table-cell;" class = "label_text">
									룸 옵션
								</div>
								<div style="display: table-cell;">
									<input type="checkbox" name="breakfast_${j}" value="true" />조식포함
									<input type="checkbox" name="wifi_${j}" value="true" />Wifi
									<input type="checkbox" name="smoking_${j}" value="true" />흡연가능
									<input type="checkbox" name="cooking_${j}" value="true" />취사 가능
								</div>
							</div>
						</div>
						<div>
							<div class = "div_text">
								<div style="display: table-cell;" class = "label_text">
									면적 크기
								</div>
								<div style="display: table-cell;">
									<input type = "text" name = "room_size_${j }"class="in_hotel_text" size = "10">
								</div>
								<div style="display: table-cell;">
									<label style="font-size: 12px; color:#A6A6A6; padding-left: 5px;">객실의 크기 단위(m²)</label>
								</div>
							</div>
						</div>
						<div>
							<div class = "div_text">
								<div style="display: table-cell;" class = "label_text">
									가격
								</div>
								<div style="display: table-cell;">
									<input type = "text" name = "price_${j }"class="in_hotel_text" size = "10">
								</div>
								<div style="display: table-cell;">
									<label style="font-size: 12px; color:#A6A6A6; padding-left: 5px;">각 객실의 가격</label>
								</div>
							</div>
						</div>
						<div>
							<div class = "div_text">
								<div style="display: table-cell;" class = "label_text" >
									사진
								</div>
								<div style="display: table-cell;">
									<input type="file" name="room_img_${j }" multiple>
								</div>
							</div>
						</div>
				</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div style="background:#E1F6FA; width: 500px; padding-bottom: 20px;">
				<button class = "button" type="submit" class = "button_ok" onclick="insertSave()">상품등록</button>
				<button class = "button" type="button" class = "button_ok" onclick="del_hotel('${hotel_num}')">상품목록</button>
			</div>
		</form>
	</div>
</body>
</html>