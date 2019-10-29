<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import = "java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id = "today" class="java.util.Date" />
<c:set var="tomorrow" value="<%=new Date(new Date().getTime()+60*60*24*1000) %>"/>
<style type="text/css">
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

.box{
   display: block;
    position: relative;
    font-size: 0;
    padding-bottom: 15px;
    padding-top: 15px;
    background-color: hsla(0,0%,100%, .65);
    margin-top: 45px;
}

.min_box{
	padding-right: 80px;
   background-color: white;
   vertical-align : middle;
   display: table-cell;
}

.min_box_img{
   background-color: none;
   vertical-align : middle;
   display: table-cell;
}

i{
    background-color: white;
    margin: 0;
    padding: 13px;
    padding-top: 15px;
}

.box .img_next{
   vertical-align: middle;
   border-radius: 5px;
   display: table-cell;
}

input[type="text"]{
	width: 100%;
	padding-right:13px;
	padding-top : 14px;
	padding-bottom: 13px;
	font-family: inherit;
	letter-spacing: inherit;
	outline: none;
	cursor: pointer;
}

input[type="password"]{
	width: 100%;
	padding-right:13px;
	padding-top : 14px;
	padding-bottom: 13px;
	font-family: inherit;
	letter-spacing: inherit;
	outline: none;
	cursor: pointer;
}

input[type="date"]{
   width: 100%;
   padding: 12px;
   padding-top : 13px;
   border: none;
   font-family: inherit;
    letter-spacing: inherit;
    outline: none;
}

.box .search{
   cursor: pointer;
}

.box .gong{
   vertical-align: middle;
   display: table-cell;
   width: 5px;
}


.box_input{
   width: 100%;
    vertical-align: middle;
    line-height: 1.25;
}



.Nanum{
   font-family: NanumGothic;
   font-weight: bold;
}

.main_image{
   width: 100%;
   height: 500px;
}


.line{
   border-top: 1px solid;
   border-top-color: white;
}

.jbMenu {
	background-color: hsla(0,0%,100%, .55);
	top: 400;
	padding: 25px 0px;
	width:100%;
	vertical-align: middle;
}


.jbFixed {
	background-color: #4C4C4C;
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

.dropbtn {
    background-color: #3498DB;
    color: white;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;
}

.dropbtn:hover, .dropbtn:focus {
    background-color: #2980B9;
}

.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f1f1f1;
    min-width: 160px;
    overflow: auto;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdown a:hover {background-color: #ddd}

.show {display:block;}


</style>

<%@ include file="top.jsp"%>
<script>
 	
 	$( document ).ready( function() {
        var jbOffset = $('#Menu').offset();
        $( window ).scroll( function() {
    	 	if ( $( document ).scrollTop() >= jbOffset.top+12 ) {
    	 		$( '#Menu' ).addClass( 'jbFixed' );
				$( '#Menu' ).removeClass( 'display-topmiddle' );
			}else {
				$( '#Menu' ).addClass( 'display-topmiddle' );
				$( '#Menu' ).removeClass( 'jbFixed' );
			}
		});
	});

   
  function search_img() {
       document.getElementById("search").focus();
   }
  function go_search() {
		if (f_search.search.value == "") {
			alert("지역이나 호텔명을 입력하세요!!");
			return false;
		}else{
			f_search.submit();
		}
	}

	function search_img() {
		document.getElementById("search").focus();
	}

	function myFunction_end() {
		document.getElementById("myDropdown_end").classList.toggle("show");
	}
	function myFunction_start() {
		document.getElementById("myDropdown_start").classList.toggle("show");
	}
	window.onclick = function(event) {
		if (!event.target.matches('.dropbtn')) {
			var dropdowns = document.getElementsByClassName("dropdown-content");
		}
	}
</script>
	<div align = "center" class ="" style="width:100%; max-width: 100%; vertical-align: middle; margin-top: 30px;">
		<img src="img/main.png" class="w3-round">
		<!-- TEXT -->
			<div class = "w3-display-topmiddle" style="top: 220px; min-height: 130px;">
				<font class = "Nanum" size="10" color="white" style="text-shadow: 2px 2px 5px black;">당신이 원하는 곳 어디든지</font><br>
		        <font class = "Nanum" size = "10" color = "Yellow" style="text-shadow: 2px 2px 5px black;">ODIGA</font>
		        <font class = "Nanum" size = "10" color = "white" style="text-shadow: 2px 2px 5px black; ">가 함께합니다</font><br>
		    </div>
		  	<div id="Menu" class = "jbMenu display-topmiddle">
		  		<form name = "f_search" action="hotel_search.do"  method="post" style="margin: 0; ">
					<input name = "search" type="text" class="w3-input" style="display: table-cell; width: 300px;  border-radius: 5px;" placeholder="도시,지역,숙소명">
					<div class="dropdown">
		                 <input type = "date" name = "start" min="<fmt:formatDate value="${today }" type="DATE" pattern="yyyy-MM-dd"/>"
		        		value="<fmt:formatDate value="${today }" type="DATE" pattern="yyyy-MM-dd"/>" class = "w3-input" style="display: table-cell; width: 200px; border-radius: 5px;">
		            </div>
					<div class="dropdown">
						 <input type = "date" name = "end" min="<fmt:formatDate value="${tomorrow }" type="DATE" pattern="yyyy-MM-dd"/>"
				 	value="<fmt:formatDate value="${tomorrow }" type="DATE" pattern="yyyy-MM-dd"/>" class = "w3-input" style="display: table-cell; width: 200px; border-radius: 5px;">
		            </div>
		            <input type = "submit" class="button_ok" onclick="return go_search()" value ="요금검색하기" style="display: table-cell;">
					<input type = "hidden" name = "pageNum" value = "1">
				</form>
			</div>
		</div>
<%@include file = "body.jsp" %>
<%@ include file="bottom.jsp"%>