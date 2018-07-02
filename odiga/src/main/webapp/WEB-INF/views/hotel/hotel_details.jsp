<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:scriptlet>
   pageContext.setAttribute("cr", "\r");
   pageContext.setAttribute("lf", "\n");
   pageContext.setAttribute("crlf", "\r\n");
</jsp:scriptlet>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%-- <%
	response.setContentType("text/html; charset=UTF-8");
 	request.setCharacterEncoding("UTF-8");
%> --%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<jsp:useBean id = "today" class="java.util.Date" />
<c:set var="tomorrow" value="<%=new Date(new Date().getTime()+60*60*24*1000) %>"/>
<style>
.button_ok {
   background-color: #4CAF50;
   border: none;
   border-radius: 4px;
   color: white;
   padding: 12px 40px;
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

.jbMenu {
	background-color: #4C4C4C;
	top: 75px;
	padding: 12px 0px;
	width:100%;
	vertical-align: middle;
}


.jbFixed {
	position: fixed;
  	padding: 12px 0px;
  	top: 0;
  	z-index:2;
}

.display-topmiddle {
    position: absolute;
    left: 50%;
    transform: translate(-50%,0%);
}


.div2 {
   border: 0;
   padding: 20px 20px;
}

.btng {
   margin-top: 20px;
   border:red;
}

.button1 {
   width: 50%;
   height: 55px;
   background-color: #4CAF50;
   color: white;
   border:0px solid black;
   font-weight: bold;
   text-align: center;
   text-decoration: none;
   display: inline-block;
   font-size: 20px;
   cursor: pointer;
   float: left;
}
.button1:hover {
   background-color: #59DA50;
}

.button2 {
   width: 50%;
   height: 55px;
   background-color: #F6F6F6;
   border:1px solid #59DA50;
   color: black;
   font-family: Arial, Helvetica, sans-serif;
   text-align: center;
   text-decoration: none;
   font-weight: bold;
   display: inline-block;
   font-size: 20px;
   cursor: pointer;
   float:left;
}
.button2:hover {
   background-color: white;
}

hr  {
   size:2px; 
   width:100%;
   
}

input[type="text"]{
	 border-radius: 5px;
   padding-right:13px;
   padding-top : 14px;
   padding-bottom: 13px;
   font-family: inherit;
    letter-spacing: inherit;
    outline: none;
    cursor: pointer;
}


input[type="date"]{
	border-radius: 5px;
	padding: 12px;
	padding-top : 13px;
	border: none;
	font-family: inherit;
    letter-spacing: inherit;
    outline: none;
}

.sin_text{
	padding: 10px; 20px;
   	border:none;
   	width:275px;
   	border: 1px solid #ddd;
   	border-radius: 5px;
}


.icon_big{
	font-size:20px
}

img{
	border-radius: 5px;
}

.x_button:hover{}
</style>
<script type="text/javascript">


function login_Check(){
	if("${sessionScope.user}" =="" || "${sessionScope.user}" == null){
		document.getElementById('if_login').style.display='block'
		return false;
	}
	document.pay_go.submit();
}

function go_search() {
	if (f_search.search.value == "") {
		alert("지역이나 호텔명을 입력하세요!!");
		return false;
	}else{
		f_search.submit();
	}
}

function del_hotel(num){
	if("${sessionScope.user.admin}" == "" || "${sessionScope.user.admin}" == null){
		alert("관리자 계정외의 계정은 삭제가 불가능합니다.")
		return;
	}
	location.href = "hotel_delete.do?num="+num;
}
$( document ).ready( function() {
    var jbOffset = $('#Menu').offset();
    $( window ).scroll( function() {
	 	if ( $( document ).scrollTop() >= jbOffset.top) {
	 		$( '#Menu' ).addClass( 'jbFixed' );
			$( '#Menu' ).removeClass( 'display-topmiddle' );
		}else {
			$( '#Menu' ).addClass( 'display-topmiddle' );
			$( '#Menu' ).removeClass( 'jbFixed' );
		}
	});
});

function scroll_comment() {
	var element = $("#hei1").height() + $("#hei2").height();
    document.body.scrollTop= element+205;
}
function getScore(){
	return $("#score").html();
}
function getPopul(){
	return $("#population").html();
	
}
$(document).ready(function(){
	$('#cart_bt').on('click', function(){
		if("${sessionScope.user }"==null || "${sessionScope.user }"== ""){
			alert("찜하실려면 로그인으로 이용부탁드립니다.")
			document.getElementById("login").style.display='block';
			return
		}
		$.ajax({
		       type:'POST',
		       url:'info_inputcart.do',
		       data:{
		          "num": "${hotel.num }",
		          "id":  "${sessionScope.user.id }"
		       },
		       success:function(data){
	             if(data>0){
	             	document.getElementById("cart").style.display='block';
	              }else{
	                 alert("이미 장바구니에 존재합니다.");
	              }
	       },
		      error:function(data){
		          alert("error : 현제페이지에서 오류가 발생하였습니다. \n 다시 이용부탁드립니다.");
		       }
		  });
	 });
});

</script>
<%@include file="/WEB-INF/views/odiga/top.jsp"%>
	<div align = "center" id="Menu" class = "jbMenu display-topmiddle">
 		<form name = "f_search" action="hotel_search.do" method="post" style="margin: 0; ">
	        <input type = "text" name = "search" class = "w3-input" style="display: table-cell; width: 300px;" placeholder="도시,지역,숙소명">
		       <c:if test = "${!empty start}">
		        	 <input type = "date" name = "start" min="${start }"
		        		value="${start }" class = "w3-input" style="display: table-cell; width: 300px;">
		        </c:if>
		        <c:if test = "${empty start }">
		        	 <input type = "date" name = "start" min="<fmt:formatDate value="${today }" type="DATE" pattern="yyyy-MM-dd"/>"
		        		value="<fmt:formatDate value="${today }" type="DATE" pattern="yyyy-MM-dd"/>" class = "w3-input" style="display: table-cell; width: 300px;">
		        </c:if>
		        <c:if test = "${!empty end}">
		        	 <input type = "date" name = "end" min="${end }"
				 	value="${end }" class = "w3-input" style="display: table-cell; width: 300px;">
		        </c:if>
		        <c:if test = "${empty end }">
		        	 <input type = "date" name = "end" min="<fmt:formatDate value="${tomorrow }" type="DATE" pattern="yyyy-MM-dd"/>"
				 	value="<fmt:formatDate value="${tomorrow }" type="DATE" pattern="yyyy-MM-dd"/>" class = "w3-input" style="display: table-cell; width: 300px;">
		        </c:if>
			<input type = "submit" class="button_ok" onclick="return go_search()" value ="요금검색하기" style="display: table-cell;">
			<input type = "hidden" name = "pageNum" value = "1">
		</form>
	</div>
	<div align="center">
	<div id = "hei1" style="width: 100%; height: 700px; padding-top: 98px;">
		<c:set var = "filename" value="${hotel.getFilename_list() }"/>
		<div style=" display: table-cell; padding-right:10px; vertical-align: top; width: 65%;"  >
			<div style="width: 100%; height: 500px; padding-bottom: 10px;">
				<img src="hotel_img/${filename[0]}" style="width: 100%; height: 100%; object-fit: cover;" />
			</div>	
			<div style=" display: table-cell; width: 1000px; height:200px; padding-right: 10px;">
				<img src="hotel_img/${filename[1]}" style="width: 100%; height:100%; object-fit: cover;"/>
			</div>
			<div style=" display: table-cell; width: 600px; height:200px;">
				<img src="hotel_img/${filename[2]}" style="width: 100%; height:100%; object-fit: cover;"/>
			</div>
		</div>
		<div style="display: table-cell; vertical-align: top; width: 35%;">
			<img src="hotel_img/${filename[3]}" style="width: 100%; height: 550px; object-fit: cover; padding-bottom: 10px;"/>
			<div style=" display: table-cell;">
				<img src="hotel_img/${filename[4]}" style="width: 100%; height: 150px; padding-right: 10px; object-fit: cover; "/>
			</div>
			<div style=" display: table-cell;">
				<img src="hotel_img/${filename[5]}" style="width: 100%;  height: 150px; object-fit: cover;"/>
			</div>
		</div>
	</div>
	
	<div align = "center" style="padding-top : 100px; display: table-cell">
		<div id = "hei2">
			<div style="width: 900px;" >
			<!-- 이름 장소 -->
			<div align="left" style="padding-top: 20px; margin-top: 30px; border-top: 1px solid #ddd; padding-bottom: 20px; ">
				<div style="margin-left: 10px;">
					<label style="font-size: 30px; font-family: 나눔고딕; font-weight: bold; color: #1266FF;">
						 ${hotel.name }
					</label>
					<div style="margin-top: 5px;">
						<i class="fa fa-leanpub"style="font-size: 20px; color:#41FF3A"></i>
						<label style="font-size: 15px;">${hotel.roadaddrpart1 } ${hotel.addrdetail }</label> 
						<label style="color: #A6A6A6; font-size: 12px;"> (우 ${hotel.zipno })</label>
					</div>
					<div style="margin-top: 10px;"><!-- 별 점수 넣는 곳 -->
						<div style="display: table-cell;">
						<c:forEach var = "i" begin="1" end="5">
							<c:choose>
								<c:when test="${(hotel.score / 2) >= i}">
									<i class="fa fa-star" style="font-size:24px; color:orange;"></i>
								</c:when>
								<c:when test="${ 0.4 < ( 1 - (i - (hotel.score/2)) ) && ( 1-(i - (hotel.score/2)) ) < 1 }">
									<i class="fa fa-star-half-o" style="font-size:24px; color:orange;"></i>
								</c:when>
								<c:otherwise>
									<i class="fa fa-star-o" style="font-size:24px;color:orange;"></i>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						</div>
						<div style="display: table-cell; vertical-align: middle;">
							<label id = "score" style="padding-left: 10px;">${hotel.score }</label><br>
						</div>
						<div style="margin-top: 5px; height: 30px;">
							<div style="float: left;">
								<i class="fa fa-edit" style="font-size:24px; color: #1266FF; display: table-cell;"></i>
								<div style="display: table-cell; vertical-align: middle; padding-left: 5px;">
									이용후기 <label id = "population" >${hotel.population }</label>건
								</div>
							</div>
							<div style="float: right;">
								<c:if test="${!empty sessionScope.user.admin }">
									<button style="cursor:pointer; padding:5px; border-radius: 5px; background: #FFA7A7; font-size : 14px; border: none; color:white; outline: none;" onclick = "del_hotel(${hotel.num})">삭제하기</button>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div style="padding-top: 40px; margin-top:20px;  border-top: 1px solid #ddd;"> <!-- 내용 -->	
				<iframe name = "rooms_iframe" src = "rooms.do?hotel_num=${hotel.num }" frameborder="0" scrolling="no"  width="900px"></iframe>
			</div>
			
			<div style="padding-top: 40px; margin-top:20px;  border-top: 1px solid #ddd;"><!-- 맵 -->
				<div style="width:800px; height:500px;">
					<%@ include file="map.jsp" %>
				</div>
			</div>
				
				
				
			<div align="left" style="margin-top: 30px; padding-bottom: 30px; border-bottom: 1px solid #ddd; ">
				<img src="hotel_img/${filename[0]}" style="object-fit: cover; width: 100%; height: 400px; margin-bottom: 30px;"/>
				<div style=" display: table-cell; border-right: 1px solid #ddd; width: 180px; ">
					<label style="font-size: 20px; margin-left: 10px; ">둘러보기</label>
				</div>
				<div style="display: table-cell;" ><!-- 호텔 설명란 -->
					<div style="margin: 5px 0 5px 20px;  vertical-align: top;">
						<label style="font-size: 13px;"><!-- ${context }  -->
							${fn:replace(hotel.content,crlf,'</br>')}
						</label>
					</div>
				</div>
			</div>
				
				
			<div align="left" style="margin-top: 30px; padding-bottom: 30px; border-bottom: 1px solid #ddd;">
				<div style=" display: table-cell; border-right: 1px solid #ddd; width: 180px;" >
					<label style="font-size: 20px; margin-left: 10px;">시설 및 서비스</label><!-- 시설 -->
				</div>
				<div style="display: table-cell;">
					<div style="margin: 5px 0 5px 20px;">
						<c:if test="${hotel.parking }">
							<i class="fa fa-car " style="font-size: 16px;"></i>
		    					주차가능<br>
			   			</c:if>
					</div>
				</div>
			</div>
		
			<div align="left" style="margin-top: 30px; padding-bottom: 30px; border-bottom: 1px solid #ddd;"> <!-- 체크인/아웃 -->
				<div style=" display: table-cell; border-right: 1px solid #ddd; width: 180px;" >
					<label style="font-size: 20px; margin-left: 10px;">이용 정보</label>
				</div>
				<div style="display: table-cell; vertical-align: top;" >
					<div style="margin: 5px 0 5px 20px; ">
						<label style="font-size: 13px;">
							체크인 : ${hotel.checkin }<br>
							체크아웃 :  ${hotel.checkout }<br>
							환불여부 : 
							<c:choose>
								<c:when test="${hotel.refund }">
		    						<label style="font-size: 13px; color :green; font-weight: bold;">환불가능</label>
		    					</c:when>
		    					<c:otherwise>
		    						<label style="font-size: 13px; color :red; font-weight: bold;">환불 불가능</label>
		    					</c:otherwise>
			   				</c:choose>
						</label>
					</div>
				</div>
			</div>
			</div>
	</div>
	<div id = "comment_scr"style="margin-top: 30px; padding-bottom: 30px; "> <!-- 댓글 -->
		<iframe id = "comment_div" name ="comment_iframe" src="commentPage.do?hotel_num=${hotel.num }&pageNum=1" width="900px" frameborder="0"scrolling="No"></iframe>
	</div>
</div>
<div style="display: table-cell; padding-left: 30px;">
	<div style="border: 1px solid #ddd; padding: 0 15px; height: 440px; width: 400px; box-shadow: 0 0 4px #D5D5D5; ">
		<form name = "pay_go" action="payment_Form.do" method="post" accept-charset="euc-kr">
			<input type = "hidden" name = "hotel_num" value ="${hotel.num }">
			<input type = "hidden"name = "score" value = "${hotel.score }">
			<input type = "hidden" name = "roadaddrpart1" value = "${hotel.roadaddrpart1 }">
			<input type = "hidden" name =  "refund"	 value = "${hotel.refund }">
			<input type ="hidden" name="price" value = "${hotel.price }">
       		<div style="margin: 20px 10px; text-align: right; ">
       			<label style="font-size: 30px; font-family: 나눔고딕-B; font-weight: 500;">결제하기</label>
       		</div>
            <div align="center" style="text-align: left; padding-bottom: 10px;">
	            <div style="padding-left:4px; display: table-cell;">
	            	<label>
						여&nbsp;행&nbsp;지&nbsp;
					</label>
				</div>
	            <div style="display: table-cell;">
	            	<label>:</label>
	            </div>
	            <div style="display: table-cell; padding-left: 10px;">
	            	<input type="text" class = "sin_text" style="width: 280px; border-radius: 5px; cursor: auto;" name="hotel_name" value="${hotel.name}" ReadOnly size="13" >
	            </div>
            </div>
        
            <div align="center" style="text-align: left;">
            	<div style="display: table-cell;">
	            	<label>
	                	숙박일정 :
	                </label>
                </div>
                <div style="display: table-cell; padding-left: 10px;">
                	<div style="border: 1px solid #ddd;  border-radius: 5px; width: 280px;">
		                <c:if test = "${!empty start}">
				        	 <input type = "date" name = "startdate" min="${start }"
				        		value="${start }" class = "w3-input" style="display: table-cell; width: 275px;">
				        </c:if>
				        <c:if test = "${empty start }">
				        	 <input type = "date" name = "startdate" min="<fmt:formatDate value="${today }" type="DATE" pattern="yyyy-MM-dd"/>"
				        		value="<fmt:formatDate value="${today }" type="DATE" pattern="yyyy-MM-dd"/>" class = "w3-input" style="display: table-cell; width: 275px;">
				        </c:if>
				        <c:if test = "${!empty end}">
				        	 <input type = "date" name = "enddate" min="${end }"
						 	value="${end }" class = "w3-input" style="display: table-cell; width: 275px;">
				        </c:if>
				        <c:if test = "${empty end }">
				        	 <input type = "date" name = "enddate" min="<fmt:formatDate value="${tomorrow }" type="DATE" pattern="yyyy-MM-dd"/>"
						 	value="<fmt:formatDate value="${tomorrow }" type="DATE" pattern="yyyy-MM-dd"/>" class = "w3-input" style="display: table-cell; width: 275px;">
				        </c:if>
            		</div>
            	</div>
            </div>
	            
	      	<div align="center" style="text-align: left; padding-top: 20px;">
	      		<div style="display: table-cell;">
	      			<label style="padding-right: 10px;">일박가격 : </label>
           		</div>
           		<div style="display: table-cell; ">
           			<input class = "sin_text"  style="display: table-cell; padding-top:10px; width: 280px; cursor: auto;" type="text" 
           				value="<fmt:formatNumber value="${hotel.price}" groupingUsed="true"/>" size="10" ReadOnly>
            	</div>
            </div>
            
	         <div align="center" class="btng div2" style=" border-top: 1px solid #ddd;">
	            <div align="center"  >
	               <input type="button" id= "cart_bt" class="button2" value="찜하기" style="outline: 0;">
	               <input type="button" class="button1" onclick = "login_Check()" value="지금 예약하기" style="outline: 0;">
	            </div>
	         </div>
	      </form>
		</div>
	</div>
	<!-- 장바구니 갈련지 말련지 -->
	<div id="cart"  style="top:0; left :0; display: none; z-index: 3; height: 100%; width: 100%;  position: fixed;" >
		<div style="top: 0; left: 0;right: 0;bottom: 0;position: fixed; background-color: rgba(0,0,0,.5); z-index: 3;"></div>
		<div style="display: table; width: 100%;height: 100%;">
			<div style="display:table-cell; vertical-align: middle;">
				<div style="display: table; margin: 0 auto;">
					<div style="  width: 400px; height: 200px; background: white;position: relative; border-radius: 5px; z-index: 4;">
						<div style=" position: relative;">
							<span onclick="document.getElementById('cart').style.display='none'" class="x_button x_display-topright" style="border-radius: 5px;">&times;</span>
							<div style="padding-top: 2px; font-size: 25px; font-weight: bold; background-color: #4CAF50; border-radius: 5px 5px 0 0;">
								<i class="fa fa-shopping-cart" style="font-size:24px; color: white;"></i>
								<label style="font-size: 13px; color : white;">장바구니</label>
							</div>
							<div style="padding-top:40px;">
								<div style="padding-bottom:24px;">
									<label style="font-size: 20px; font-weight: bold;">장바구니에 추가하였습니다.</label>
								</div>
								<div style="display: table-cell; padding-right: 10px;">
									<input type = "button" value = "장바 구니"  style="font-weight:bold; padding: 10px 20px;border-radius: 5px;background: #ddd;border: none;outline:none; cursor: pointer;" onclick="location.href ='info_cart.do'">
								</div>
								<div style="display: table-cell;">
									<input type = "button" value = "계속 하기" onclick="document.getElementById('cart').style.display='none'" style="cursor: pointer; font-weight:bold;padding: 10px 20px;border-radius: 5px;background: #ddd;border: none;outline:none;" >
								</div>
							</div>
						</div>
					</div>	
				</div>
			</div>
		</div>
	</div>
	<!-- 로그인 할그냐 안할그냐 -->
	<div id="if_login"  style="top:0; left :0; display: none; z-index: 3; height: 100%; width: 100%;  position: fixed;" >
		<div style="top: 0; left: 0;right: 0;bottom: 0;position: fixed; background-color: rgba(0,0,0,.5); z-index: 3;"></div>
		<div style="display: table; width: 100%;height: 100%;">
			<div style="display:table-cell; vertical-align: middle;">
				<div style="display: table; margin: 0 auto;">
					<div style="  width: 400px; height: 200px; background: white;position: relative; border-radius: 5px; z-index: 4;">
						<div style=" position: relative;">
							<span onclick="document.getElementById('if_login').style.display='none'" class="x_button x_display-topright" style="border-radius: 5px;">&times;</span>
							<div style="font-size: 25px; font-weight: bold; background-color: #4CAF50; border-radius: 5px 5px 0 0; padding: 10px 0;">
								<label style="font-size: 13px; color : white;;">비회원 이용중입니다.</label>
							</div>
							<div style="padding-top:40px;">
								<div style="padding-bottom:24px;">
									<label style="font-size: 20px; font-weight: bold;">로그인을 하시겠습니까?</label>
								</div>
								<div style="display: table-cell; padding-right: 10px;">
									<input type = "button" value = "로그인 예약"  onclick="document.getElementById('if_login').style.display='none'; document.getElementById('login').style.display='block';"
									style="font-weight:bold; padding: 10px 20px;border-radius: 5px;background: #ddd;border: none;outline:none; cursor: pointer;" onclick="location.href ='info_cart.do'">
								</div>
								<div style="display: table-cell;">
									<input type = "button" onclick = "document.pay_go.submit();" value = "비회원 예약" style="cursor: pointer; font-weight:bold;padding: 10px 20px;border-radius: 5px;background: #ddd;border: none;outline:none;" >	
								</div>
							</div>
						</div>
					</div>	
				</div>
			</div>
		</div>
	</div>
</div>


<%@include file="/WEB-INF/views/odiga/bottom.jsp"%>