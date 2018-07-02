<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <script>
 function go_link(city_name){
	 var city = encodeURIComponent(city_name);
	 location.href = "hotel_cate.do?title="+city;
 }
 </script>
 <style>
.op_black{
	opacity: 0.20;
	width:100%;
	height: 100%;
	background-color: black;
	border-radius: 5px;
	cursor: pointer;
}

.back_black:hover{
	background-color: rgba(0,0,0,0.3);
}

.back_black{
	cursor: pointer;
	border-radius: 5px;
	width: 100%;
	height: 100%;
}

.city_font{
	color: white;
	font-size: 35px;
	font-weight: bolder;
	font-family: 나눔고딕;
}

.city_img{
	width: 100%;
	height:100%;
	border-radius: 5px;
	object-fit: cover;
}

 </style>
 <div   align = "center">
	<div style="padding: 80px 0 20px 0">
		<font class = "Nanum" size = "5px">《 오늘의 특가 상품 》</font><br>
	</div>
	<iframe style="width: 1197px; height: 350px;" frameborder="0" scrolling="no" src="hotel_list.do" ></iframe>
			
			
<div style=" padding-bottom:100px;">
<div align = "center" style="padding: 80px 0 30px 0">
	<font class = "Nanum" size = "5px">《 우리나라 유명 관광지 》</font>
</div>
	<div align="center" style="width:1197px; height:300px;">		
		<div style="width:100%; height:100%; overflow:hidden;">
	        <div  class= "w3-display-container" style="width: 40%; height:300px; border-radius: 5px; float:left; padding-right: 10px">
				<div  class = "w3-display-container">
					<img src="city_img/서울.jpg" class = "city_img">
					<div onclick="go_link('서울')" class = "back_black w3-display-middle">
						<span class = "op_black w3-display-middle"></span>
						<span class = "city_font w3-display-middle " >서 울</span>
					</div>
	           	</div>
	        </div>
			<div class= "w3-display-container" style="width: 60%; height:300px; border-radius: 5px; float:left;">
				<div  class = "w3-display-container">
					<img src="city_img/순천.jpg" class = "city_img">
					<div onclick="go_link('순천')" class = "back_black w3-display-middle">
						<span class = "op_black w3-display-middle"></span>
						<span class = "city_font w3-display-middle">순 천</span>
					</div>	
				</div>
			</div>
		</div>
     </div>
     
     
      <div style="width:1197px; height:400px; padding-top: 10px">  
		<div style="width:100%; height:100%; overflow:hidden; border-radius: 5px;">
             <div  class= "w3-display-container" style="width: 33%; height:100%; border-radius: 5px; float:left; padding-right: 10px">
				<div  class = "w3-display-container">
					<img src="city_img/경주.jpg" class = "city_img">
					<div onclick="go_link('경주')" class = "back_black w3-display-middle">
						<span class = "op_black w3-display-middle"></span>
						<span class = "city_font w3-display-middle">경 주</span>
					</div>
				</div>
			</div>
             <div  class= "w3-display-container" style="width: 33%; height:100%; border-radius: 5px; float:left; padding-right: 10px">
				<div  class = "w3-display-container">
					<img src="city_img/거제.jpg" class = "city_img">
					<div onclick="go_link('거제')" class = "back_black w3-display-middle">
						<span class = "op_black w3-display-middle"></span>
						<span class = "city_font w3-display-middle">거 제</span>
					</div>
				</div>
			</div>
             <div style="width: 34%; height: 390px; float:left;">
				<div  class= "w3-display-container" style="width: 100%; height:50%; border-radius: 5px; float:left; padding-bottom: 10px">
					<div  class = "w3-display-container">
						<img src="city_img/부산.jpg" class = "city_img">
						<div onclick="go_link('부산')" class = "back_black w3-display-middle">
							<span class = "op_black w3-display-middle"></span>
							<span class = "city_font w3-display-middle">부 산</span>
						</div>
					</div>
				</div>
				<div  class= "w3-display-container" style="width: 100%; height:50%; border-radius: 5px; float:left;">
					<div  class = "w3-display-container">
						<img src="city_img/강원도.jpg" class = "city_img">
						<div onclick="go_link('강원도')" class = "back_black w3-display-middle">
							<span class = "op_black w3-display-middle"></span>
							<span class = "city_font w3-display-middle">강 원 도</span>
						</div>
					</div>
				</div>
            </div>
        </div>
	</div>
      
	<div style="width:1197px; height:300px; padding-top: 10px;"> 
      	<div style="width:100%; height:100%; overflow:hidden; border-radius: 5px;">
	       	<div  class= "w3-display-container" style="width: 60%; height:100%; border-radius: 5px; float:left; padding-right: 10px">
				<div  class = "w3-display-container">
					<img src="city_img/안동.jpg" class = "city_img">
					<div onclick="go_link('안동')" class = "back_black w3-display-middle">
						<span class = "op_black w3-display-middle"></span>
						<span class = "city_font w3-display-middle">안 동</span>
					</div>
				</div>
			</div>
			<div  class= "w3-display-container" style="width: 40%; height:100%; border-radius: 5px; float:left;">
				<div  class = "w3-display-container">
					<img src="city_img/제주.jpg" class = "city_img">
					<div onclick="go_link('제주')" class = "back_black w3-display-middle">
						<span class = "op_black w3-display-middle"></span>
						<span class = "city_font w3-display-middle">제 주</span>
					</div>
				</div>
			</div>
	    </div>  
    </div>
</div>
</div>
