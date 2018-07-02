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
	font-family: �������;
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
		<font class = "Nanum" size = "5px">�� ������ Ư�� ��ǰ ��</font><br>
	</div>
	<iframe style="width: 1197px; height: 350px;" frameborder="0" scrolling="no" src="hotel_list.do" ></iframe>
			
			
<div style=" padding-bottom:100px;">
<div align = "center" style="padding: 80px 0 30px 0">
	<font class = "Nanum" size = "5px">�� �츮���� ���� ������ ��</font>
</div>
	<div align="center" style="width:1197px; height:300px;">		
		<div style="width:100%; height:100%; overflow:hidden;">
	        <div  class= "w3-display-container" style="width: 40%; height:300px; border-radius: 5px; float:left; padding-right: 10px">
				<div  class = "w3-display-container">
					<img src="city_img/����.jpg" class = "city_img">
					<div onclick="go_link('����')" class = "back_black w3-display-middle">
						<span class = "op_black w3-display-middle"></span>
						<span class = "city_font w3-display-middle " >�� ��</span>
					</div>
	           	</div>
	        </div>
			<div class= "w3-display-container" style="width: 60%; height:300px; border-radius: 5px; float:left;">
				<div  class = "w3-display-container">
					<img src="city_img/��õ.jpg" class = "city_img">
					<div onclick="go_link('��õ')" class = "back_black w3-display-middle">
						<span class = "op_black w3-display-middle"></span>
						<span class = "city_font w3-display-middle">�� õ</span>
					</div>	
				</div>
			</div>
		</div>
     </div>
     
     
      <div style="width:1197px; height:400px; padding-top: 10px">  
		<div style="width:100%; height:100%; overflow:hidden; border-radius: 5px;">
             <div  class= "w3-display-container" style="width: 33%; height:100%; border-radius: 5px; float:left; padding-right: 10px">
				<div  class = "w3-display-container">
					<img src="city_img/����.jpg" class = "city_img">
					<div onclick="go_link('����')" class = "back_black w3-display-middle">
						<span class = "op_black w3-display-middle"></span>
						<span class = "city_font w3-display-middle">�� ��</span>
					</div>
				</div>
			</div>
             <div  class= "w3-display-container" style="width: 33%; height:100%; border-radius: 5px; float:left; padding-right: 10px">
				<div  class = "w3-display-container">
					<img src="city_img/����.jpg" class = "city_img">
					<div onclick="go_link('����')" class = "back_black w3-display-middle">
						<span class = "op_black w3-display-middle"></span>
						<span class = "city_font w3-display-middle">�� ��</span>
					</div>
				</div>
			</div>
             <div style="width: 34%; height: 390px; float:left;">
				<div  class= "w3-display-container" style="width: 100%; height:50%; border-radius: 5px; float:left; padding-bottom: 10px">
					<div  class = "w3-display-container">
						<img src="city_img/�λ�.jpg" class = "city_img">
						<div onclick="go_link('�λ�')" class = "back_black w3-display-middle">
							<span class = "op_black w3-display-middle"></span>
							<span class = "city_font w3-display-middle">�� ��</span>
						</div>
					</div>
				</div>
				<div  class= "w3-display-container" style="width: 100%; height:50%; border-radius: 5px; float:left;">
					<div  class = "w3-display-container">
						<img src="city_img/������.jpg" class = "city_img">
						<div onclick="go_link('������')" class = "back_black w3-display-middle">
							<span class = "op_black w3-display-middle"></span>
							<span class = "city_font w3-display-middle">�� �� ��</span>
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
					<img src="city_img/�ȵ�.jpg" class = "city_img">
					<div onclick="go_link('�ȵ�')" class = "back_black w3-display-middle">
						<span class = "op_black w3-display-middle"></span>
						<span class = "city_font w3-display-middle">�� ��</span>
					</div>
				</div>
			</div>
			<div  class= "w3-display-container" style="width: 40%; height:100%; border-radius: 5px; float:left;">
				<div  class = "w3-display-container">
					<img src="city_img/����.jpg" class = "city_img">
					<div onclick="go_link('����')" class = "back_black w3-display-middle">
						<span class = "op_black w3-display-middle"></span>
						<span class = "city_font w3-display-middle">�� ��</span>
					</div>
				</div>
			</div>
	    </div>  
    </div>
</div>
</div>
