<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Date"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<jsp:useBean id="today" class="java.util.Date" />
<c:set var="tomorrow" value="<%=new Date(new Date().getTime() + 60 * 60 * 24 * 1000)%>" />

<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
    <script type="text/javascript">
    
	function insertCheck() {
		if (f_input.name.value == "") {
			alert("호텔명을 입력하세요!!");
			f_input.name.focus();
			return false;
		}else if (f_input.price.value == "") {
			alert("가격을 입력하세요!!");
			f_input.price.focus();
			return false;
		}else if(!f_input.addrdetail){
			alert("주소를 입력하세요.")
			f_input.addrdetail.focus();
		}else if (count < 6 || count >6) {
			alert("이미지를 6개를 넣어주세요");
			return false;
		}else if(f_input.content ==""){
			alert("호텔 소개를 입력하세요")
			f_input.content.focus();
		}
		f_input.submit();
	}
	
	 function goPopup() {
	      var pop = window.open("hotel_jusoPopup.do", "pop",
	            "width=570,height=420, scrollbars=yes, resizable=yes");
	   }

	   function jusoCallBack(roadAddrPart1, addrDetail, zipNo) {
	      document.f_input.roadaddrpart1.value = roadAddrPart1;
	      document.f_input.addrdetail.value = addrDetail;
	      document.f_input.zipno.value = zipNo;
	      self.close();
	   }
    
    
        $(function() {
            $("#imgInp").on('change', function(){
                readURL(this);
            });
        });
        
        var count = 0;
        var count_Max = false;
        function readURL(input) {
        	if(input.files.length > 6){
        		count_Max = true;
        	}
        	for(var i=0; i<input.files.length; i++){
            	if(input.files[i]) {
            		var reader = new FileReader();
           	 		reader.onload = function (e) {
           	 			count = count + 1;
           	 			if(count > 6){
           	 				return;
           	 			}
            	    	$('#blah'+count).attr('src', e.target.result);
            		}
					reader.readAsDataURL(input.files[i]);  
          		}
      		}
        	if(count_Max){
        		alert("사진은 6개까지 가능합니다.")
        		count_Max = false;
        	}
       	}
        
      
</script>  

<style>
p, h1, form, button {
	border: 0;
	margin: 0;
	padding: 0;
}

td {
	vertical-align: middle;
}


.myform {
	margin: 10px;
	width: 450px;
	padding: 10px;
}

#stylized {
	background-color : #E1F6FA;
}


#stylized .small {
	color: #666666;
	display: block;
	font-size: 11px;
	font-weight: normal;
	text-align: right;
	width: 140px;
	font-family: dotum;
	letter-spacing: -1px;
}

.button {
	clear: both;
	width: 70px;
	height: 23px;
	text-align: center;
	border: 1px solid #32A4FF;
	background-color: #FAF8F8;
	color: #32A4FF;
	font-size: 11px;
	font-weight: bold;
	font-family: tahoma;
	vertical-align: middle;
	border-radius:3px 3px 3px 3px;
}
.button_ok{
	clear: both;
	width: 70px;
	height: 23px;
	text-align: center;
	border: 1px solid #32A4FF;
	background-color: #FAF8F8;
	color: #32A4FF;
	font-size: 11px;
	font-weight: bold;
	font-family: tahoma;
	vertical-align: middle;
	border-radius:3px 3px 3px 3px;
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

	<div align="center" >
	<div style="width: 500px; background: #E1F6FA; padding-top:20px;">
		<label style="font-size: 30px; font-weight: bold;">호텔 등록하기</label>
	</div>
	<form name="f_input" id="form" action="hotel_insert.do" method="post" enctype="multipart/form-data">
		<div id="stylized" class="myform" align="center" style="width: 500px; display: table-cell;">

			<div class = "div_text">
				<div class = "label_text" style="display: table-cell;">
					<label>호텔 명</label>
				</div>
				<div style="display: table-cell;">
					<input type="text" name="name" size="35" class = "in_hotel_text">
				</div>
			</div>
			
			<div class ="div_text">
				<div class = "label_text" style="display: table-cell;">
					<label>주소</label>
				</div>
				<div style="display: table-cell;">
					<input class = "in_hotel_text" type="text" size="26" id="roadaddrpart1" name="roadaddrpart1"  ReadOnly>
					<button class = "button" type="button" style="margin-left: 5px;" onclick="goPopup();">주소검색</button>
				</div>
			</div>
			
			<div class ="div_text">
				<div class = "label_text" style="display: table-cell;">
					<label>상세주소</label>
				</div>
				<div style="display: table-cell;">
					<input class = "in_hotel_text" type="text" size="35" id="addrdetail" name="addrdetail" >
				</div>
			</div>
			
			<div class ="div_text">
            <div class = "label_text" style="display: table-cell;">
               <label>우편번호 :</label>
            </div>
            <div style="display: table-cell;">
               <input class = "in_hotel_text" type="text" size="35" id="zipno" name="zipno" value="(우)" ReadOnly>
            </div>
         </div>
			
			
			<div class ="div_text">
				<div class = "label_text" style="display: table-cell;">
					<label>가격</label>
				</div>
				<div style="display: table-cell;">
					<input class = "in_hotel_text" type="text" id = "price" name="price" size="35" value="${dto.price }">
				</div>
			</div>
			

			<div class ="div_text">
				<div class = "label_text" style="display: table-cell;">
					<label>체크인</label>
				</div>
				<div style="display: table-cell;">
					<select class = "in_hotel_text" name="checkin">
						<c:forEach var = "i" begin="0" end="23">
							<c:if test = "${i < 10 }">
								<c:set var = "i" value = "0${i }"/>
							</c:if>
							<option value="00:00">${i }:00</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			
			
			<div class ="div_text">
				<div class = "label_text" style="display: table-cell;">
					<label>체크아웃</label>
				</div>
				<div style="display: table-cell;">
					<select class = "in_hotel_text" name="checkout">
						<c:forEach var = "i" begin="0" end="23">
							<c:if test = "${i < 10 }">
								<c:set var = "i" value = "0${i }"/>
							</c:if>
							<option value="00:00">${i }:00</option>
						</c:forEach>
					</select>
				</div>
			</div>
		
		
			<div class ="div_text">
				<div class = "label_text" style="display: table-cell;">
					<label>첨부사진</label>
				</div>
				<div style="display: table-cell;">
					<input id = "imgInp" type="file" name="filename" size="39" multiple>
					<div style="padding-top: 5px;">
						<c:forEach var = "j" begin="1" end="6">
							<div style=" position: relative; width: 100px; height: 100px; padding: 5px; display: table-cell;">
								<div style="width: 100px; height: 100px; border: 1px solid #ddd; "> 
									<img id="blah${j }" width="100px" height="100px" style="position: absolute;"/>
									<button type = "button" class = "x_button x_display-topright" >&times;</button>
								</div>
							</div>
							<c:if test = "${j % 3 == 0 }">
								<span  style="display: table;"></span>
							</c:if>
				   		</c:forEach>
			   		</div>
					<label style="font-size: 13px; color :red; width: 300px;">첫 번째 사진이 메인페이지로 설정됩니다.</label>
				</div>
			</div>
			
			
			<div class ="div_text">
				<div class = "label_text" style="display: table-cell;">
					<label>옵션</label>
				</div>
				<div style="display: table-cell;">
					<input type="checkbox" name="parking" value="true" />주차가능<br>
					<input type="checkbox" name="refund" value="true" />환불가능
				</div>
			</div>
			
			
			<div class ="div_text">
				<div class = "label_text" style="display: table-cell;">
					<label style="vertical-align: middle; position: absolute;padding-top: 100px;">호텔소개</label>
				</div>
				<div style="display: table-cell;">
					<textarea name = "content" id = "content" cols = "41" rows = "11" style="resize: none; font-size : 13px;"></textarea>
				</div>
			</div>
			
		</div>
		<div style="background:#E1F6FA; width: 500px; padding-bottom: 20px;">
			<button class = "button" type="button" class = "button_ok" onclick="insertCheck()">상품등록</button>
			<button class = "button" type="button" class = "button_ok" onclick="window.location='index.do'">상품목록</button>
		</div>
	</form>
	</div>
