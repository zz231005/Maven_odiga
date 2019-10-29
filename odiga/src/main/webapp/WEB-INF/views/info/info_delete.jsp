<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<%@ include file="../odiga/top.jsp"%>
<style>
.info {
    margin: 0;
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

.info_li a:hover:not(.active) {
    background-color: #555;
    color: white;
}


.input[type=password] {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

.input[type=button] {
    width: 100%;
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.input[type=button]:hover {
    background-color: #45a049;
}

.div {
    border-radius: 5px;
    background-color: #f2f2f2;
    padding: 20px;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		 $('#submit_bt').on('click', function(){
				if (!pw.passwd.value){
					alert("패스워드를 입력해주세요");
					pw.passwd.focus()
					return;
				}else if(!pw.passwdOk.value){
					alert("패스워드를 입력해주세요");
					pw.passwdOk.focus()
					return;
				}else if(pw.passwd.value!=pw.passwdOk.value){
					alert("비밀번호가 일치하지 않습니다.");
					pw.passwd.focus();
				}
				else{
					$.ajax({
						type: 'POST',
						url: 'info_deleteOk.do',
						data: {
							"passwd" : pw.passwd.value
						},
						success: function(data){
							if(data>0){
								alert("탈퇴되셨습니다.")
								document.location.href='index.do';
							}else{
								alert("패스워드가 일치하지 않습니다.")
							}
						}
					});
				}
		 });
	});
	
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
		               alert(data)
		                alert("error");
		             }
		        });
		    });
		});
</script>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<div id="info_top">

</div>

<body class="info">
<div style="padding-top:35px; width:1200px; margin-left: auto; margin-right: auto">
<div style="display: table-cell; box-shadow: 8px 2px 8px #ddd; width: 290px">
		<ul class="info_ul w3-padding">
			<li class="info_li">
				<a style="cursor: pointer;">
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
				<a href="info_cart.do" style="cursor: pointer;">
					<i class="fa fa-truck w3-large" style="padding-right: 20px;"></i>
					<font style="font-size: 18px; font-weight: bold; cursor: pointer;" >찜목록</font>
				</a>
			</li>
			<li class="info_li">
				<a style="cursor: pointer;">
					<i class="fa fa-search w3-large" style="padding-right: 20px;"></i>
					<font style="font-size: 18px; font-weight: bold; cursor: pointer;" >회원 탈퇴</font>
				</a>
			</li>
		</ul>
	</div>

	<div id="delete" class="w3-container" style="height:1000px; padding-left: 40px; display: table-cell; width: 75%;">
	<h4>본인 확인을 위해 비밀번호를 입력해 주세요.</h4><br><br><br><br>
	<div name="div">
	<form name="pw" id="pw">
    <label for="fpasswd">비밀번호</label>
    <input class="input" type="password" id="passwd" name="passwd">

    <label for="lpasswd">비밀번호 재확인</label>
    <input class="input" type="password" id="passwdOk" name="passwdOk">

	<input type="button" class="input" id="submit_bt" value="확인">
  </div>
  </form>
  
	</div>
</div>

</body>

<%@ include file="../odiga/bottom.jsp"%>
</html>