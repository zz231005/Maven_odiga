<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>
<style>
.hotel_list { 
   position:absolute;
}
body{
   margin: 0;
}
.list_box{
   background-color: white;
   position: absolute;
   height: 100%;
    width: 45px;
   display: table-cell;
}

.box_margin{
   background-color:#abc;
   width:100px;
   height:100px;
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

.list_button:hover{
   background-color: #E7E7E7;
}

.gallery {
   margin: 3px;
   border: 1px solid #ccc;
   float: left;
   width: 210px;
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
   padding: 27px 15px 10px  15px;
   text-align: right;
}

.gallery_pointer{
   display: table-cell;
   padding-right: 5px;
   cursor: pointer;
}
</style>
<script>
   var click = true;
   var list_size = '${hotel_list.size() - 6}';
   var size = 33-(list_size*210);
   
   $(document).ready(function(){
      $("#left").on("click",function(){
         if($(".hotel_list").offset().left < 32 && click){ 
            click = false;  
            $(".hotel_list").animate({"left": "+=221px"}, "fast");
            setTimeout(function() {
               click = true;
            }, 300)
         }
      });
   
      $("#right").bind('click',function(){
         if($(".hotel_list").offset().left > size && click){ /* (장수/2) 홀수(반올림) = x    |     33 - (x*210)*/
            click = false;
            $(".hotel_list").animate({"left": "-=221px"}, "fast"); 
            setTimeout(function() {
               click = true;
            }, 300)
         }
      });
   });
   
</script>
</head>
<body>
   <div class = "hotel_list" style="left: 48px; width: 683px;"> <!-- left로 좌우 간격 맞추기 -->
      <c:forEach var = "dto" items="${hotel_list }">
         <div class = "gallery_pointer">
            <div class="gallery" onclick="parent.location.href = 'hotel_getOne.do?num=${dto.num}'">
               <img src=" hotel_img/${dto.getOneFilename() }" width=100% height=170 style="object-fit: cover;">
               <div class="desc" style="height: 75px;">
                  <font size = "3px" color="blue" style="font-weight: bold;">${dto.name }</font><br>
                  <font size = "2px">${dto.getAdd_Easy()}</font>
                  <div align="right" style="padding-top:40px;">
                  	<c:forEach var = "i" begin="1" end="5">
						<c:choose>
								<c:when test="${(dto.score / 2) >= i}">
									<i class="fa fa-star" style="font-size:18px; color:orange;"></i>
								</c:when>
								<c:when test="${ 0.4 < ( 1 - (i - (dto.score/2)) ) && ( 1-(i - (hotel.score/2)) ) < 1 }">
									<i class="fa fa-star-half-o" style="font-size:18px; color:orange;"></i>
								</c:when>
								<c:otherwise>
									<i class="fa fa-star-o" style="font-size:18px;color:orange;"></i>
								</c:otherwise>
							</c:choose>
					</c:forEach>
               </div>
            </div>
               <div class="price">
                	<hr size="3" style="margin-bottom: 10px;">
                    <font size="4px" color="Red" style="font-weight: bold;">￦ 
                     <fmt:formatNumber value="${dto.price }" groupingUsed="true" /></font>
               </div>
            </div>
         </div>
      </c:forEach>
   </div>
   <div class = "list_box">
      <button id="left" class = "list_button w3-xlarge w3-circle"  style="margin-top:150px; outline: none;">&laquo;</button>
   </div>
   <div class = "list_box" style="left: 1152px;">
      <button id="right" class = "list_button w3-xlarge w3-circle"  style="margin-top:150px; outline: none;">&raquo;</button>
   </div>
</body>
</html>