<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ include file="../odiga/top.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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

#name_panel, #name_form {
    padding: 40px;
    text-align: left;
    background-color: pink;
    margin: 20px;
    box-shadow: 0 0 10px;
}

#name_panel {
    padding: 50px;
    display: none;
}

#name_update{
	padding: 10px;
 	text-align: right;
    background-color: pink;
}

.name_input[type=text] {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

.name_input[type=submit] {
    width: 25%;
    background-color: cornflowerblue;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}
.name_input[type=button] {
    width: 25%;
    background-color: cornflowerblue;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.name_input[type=submit]:hover {
    background-color: white;
    color: cornflowerblue;
}
.name_input[type=button]:hover {
   	background-color: white;
    color: cornflowerblue;
}

.name_div {
    border-radius: 5px;
    background-color: #f2f2f2;
    padding: 20px;
}

#email_update{
	padding: 10px;
 	text-align: right;
}
#email_panel {
    padding: 50px;
    display: none;
}

#check_panel {
    padding: 50px;
    display: none;
}

#email_panel, #email_form, #check_panel {
    padding: 40px;
    text-align: left;
    background-color: white;
    margin: 20px;
    box-shadow: 0 0 10px;
}

.input[type=text] {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

.input[type=password] {
    width: 50%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

.input[type=submit] {
    width: 25%;
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}
.input[type=button] {
    width: 25%;
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}
.input[type=submit]:hover {
    background-color: #45a049;
}
.div {
    border-radius: 5px;
    background-color: #f2f2f2;
    padding: 20px;
}
#phone_update{
	padding: 10px;
 	text-align: right;
}
#phone_panel {
    padding: 50px;
    display: none;
}
#phone_panel, #phone_form {
    padding: 40px;
    text-align: left;
    background-color: white;
    margin: 20px;
    box-shadow: 0 0 10px;
}

#passwd_update{
	padding: 10px;
 	text-align: right;
}
#passwd_panel {
    padding: 50px;
    display: none;
}
#passwd_panel, #passwd_form {
    padding: 40px;
    text-align: left;
    background-color: white;
    margin: 20px;
    box-shadow: 0 0 10px;
}
</style>
<script type="text/javascript">
var emailText=/^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
var hp_text= /^[0-9]+$/;
var passwd_text = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[`~!@#$%^&*+=-?/,.<>{}:;]).{6,15}$/;
var name_text= /^[가-힝]{2,10}$/;
var hp1_text=/^01(?:0|1|[6-9])$/;

function info(id) {
    var x = document.getElementById(id);
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
    } else { 
        x.className = x.className.replace(" w3-show", "");
    }
}

var user_id='<c:out value="${id}"/>';
$(document).ready(function(){
    $("#name_update").click(function(){
        $("#name_panel").slideDown("fast");
        $("#name_form").hide();
    });
    
    $("#name_cancel").click(function(){
    	$("#name_panel").slideUp("fast");
        $("#name_form").slideDown("fast");
    }); 
    
    $("#email_update").click(function(){
        $("#email_panel").slideDown("fast");
        $("#email_form").hide();
        $("#check_panel").hide();
    });
    
    $("#email_cancel").click(function(){
    	$("#email_panel").slideUp("fast");
    	$("#check_panel").hide();
    	$("#email_form").slideDown("fast");
    }); 
    
    $("#check_cancel").click(function(){
    	$("#check_panel").slideUp("fast");
        $("#email_form").slideDown("fast");
        $("#email_panel").hide();
    }); 
    
    $("#phone_update").click(function(){
    	$("#phone_panel").slideDown("fast");
    	$("#phone_form").hide();
    }); 
    
    $("#phone_cancel").click(function(){
    	$("#phone_panel").slideUp("fast");
        $("#phone_form").slideDown("fast");
    });
    
    $("#passwd_update").click(function(){
    	$("#passwd_panel").slideDown("fast");
    	$("#passwd_form").hide();
    }); 
    
    $("#passwd_cancel").click(function(){
    	$("#passwd_panel").slideUp("fast");
        $("#passwd_form").slideDown("fast");
    });
    
    $('#name_bt').on('click', function(){
    	if(!name_text.test($('#name').val())){
			alert("한글만 입력 가능합니다.");
			f_name.name.focus();
			return;
    }
    $.ajax({
    	type:'POST',
    	url:'info_update.do',
    	data:{
    		"name":$('#name').val(),
    		"id":user_id
    	},
    		success:function(data){
    				if(data>0){
        				$('#name_panel').slideUp("fast");
        		        $('#name_form').slideDown("fast");
        		        document.getElementById("font_name").innerHTML = $('#name').val()
        		        $("#info_top").load("info_member.do");
        		        $('#top_name').html($('#name').val());
        			}else{
        				document.getElementById('id01').style.display='block';
        			}
    			
    		},
    	error:function(data){
    		document.getElementById('id01').style.display='block';
    	}
    });
    });
    
    $('#email_bt').on('click', function(){
    	if(!emailText.test($('#email').val())){
			alert("이메일 형식만 입력 가능합니다.");
			f_email.email.focus();
			return;
    }
    	$.ajax({
        	type:'POST',
        	url:'info_email.do',
        	data:{
        		"email":$('#email').val(),
        		"id":user_id,
        	},
        		success:function(data){
        			if(data==1){
        				alert("이미 가입된 이메일입니다.");
        			}else{
        				$('#email_panel').slideUp("fast");
        		        $('#check_panel').slideDown("fast");
        		        $('#check_bt').on('click', function(){
        		        if(data==$('#emailcheck').val()){
            	    					alert("이메일 수정에 성공하셨습니다.");
                        		        $('#check_panel').slideUp("fast");
                        				$('#email_form').slideDown("fast");
                        		        document.getElementById("font_email").innerHTML = $('#email').val()
            	        			}else{
            	        				alert("이메일 수정 실패!"); 
            	    			
            			}
         });
        		        
        			}
        		},
        	error:function(data){
        		document.getElementById('id01').style.display='block';
        	}
        });
        });

    
    $('#hp_bt').on('click', function(){
    	if(!hp_text.test($('#hp1').val()) || !hp_text.test($('#hp2').val()) || !hp_text.test($('#hp3').val())){
			alert("번호만 입력 가능합니다.");
			f_phone.hp1.focus();
			return;
    }else if(!hp1_text.test($('#hp1').val())){
    	alert("휴대폰 번호만 입력 가능합니다.");
    	f_phone.hp1.focus();
    	return;
    }
        $.ajax({
        	type:'POST',
        	url:'info_update.do',
        	data:{
        		"hp1":$('#hp1').val(),
        		"hp2":$('#hp2').val(),
        		"hp3":$('#hp3').val(),
        		"id":user_id
        	},
        		success:function(data){
        			if(data>0){
        				$('#phone_panel').slideUp("fast");
        		        $('#phone_form').slideDown("fast");
        		        document.getElementById("font_phone").innerHTML = $('#hp1').val()+"-"+$('#hp2').val()+"-"+$('#hp3').val()
        			}else{
        				document.getElementById('id01').style.display='block';
        			}
        		},
        	error:function(data){
        		document.getElementById('id01').style.display='block';
        	}
        });
        });
    
    $('#passwd_bt').on('click', function(){
    	if(!passwd_text.test($('#passwd').val()) || !passwd_text.test($('#new_passwd').val()) || !passwd_text.test($('#passwd_check').val())){
			alert("특수문자, 영문, 숫자를 포함한 6~15자 이내의 길이만 입력 가능합니다.");
			if(!passwd_text.test($('#passwd').val())){ 
				f_passwd.passwd.focus();
			}else if(!passwd_text.test($('#new_passwd').val())){
				f_passwd.new_passwd.focus();
			}else if(!passwd_text.test($('#passwd_check').val())){
				f_passwd.passwd_check.focus();
			}
			return;
    }else if($('#passwd').val()!=$('#original').val()){
    	f_passwd.passwd.focus();
    	alert("현재 비밀번호가 일치하지 않습니다.");
    	return;
    }else if($('#new_passwd').val()!=$('#passwd_check').val()){
    	f_passwd.passwd_check.focus();
    	alert("수정할 비밀번호를 확인해주세요");
    	return;
    }
        $.ajax({
        	type:'POST',
        	url:'info_update.do',
        	data:{
        		"passwd":$('#passwd_check').val(),
        		"id":user_id
        	},
        		success:function(data){
        			if(data>0){
        				$('#passwd_panel').slideUp("fast");
        		        $('#passwd_form').slideDown("fast");
        		        alert("비밀번호 수정성공");
        			}else{
        				document.getElementById('id01').style.display='block';
        			}
        		},
        	error:function(data){
        		document.getElementById('id01').style.display='block';
        	}
        });
        });
});

function limitName(){
	if((event.keyCode<126)||(event.keyCode>33)) {
		 event.returnValue=false;
	}
}
</script>

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
				<a href="info_delete.do" style="cursor: pointer;">
					<i class="fa fa-search w3-large" style="padding-right: 20px;"></i>
					<font style="font-size: 18px; font-weight: bold; cursor: pointer;" >회원 탈퇴</font>
				</a>
			</li>
		</ul>
	</div>

	<div id="information" class="w3-container" style="height:1000px; padding-left: 40px; display: table-cell; width: 75%;">
	  	<h3>회원정보</h3><p>
		<div id="name_form"><label id="name_update" style="float:right; cursor: pointer;">변경</label>
			이름<br>
			<font id="font_name" style="color:gray;">${info.name}</font>
		</div>
		<div id="name_panel" class="name_div">
		    <label for="name">이름</label>
			    <form name="f_name">
			    <input class="name_input" type="text" id="name" name="name" maxlength="10" onkeypress="limitName()" placeholder="${info.name}">
			    <input class="name_input" type="button" value="확인" id="name_bt">
			    <input class="name_input" type="button" value="취소" id="name_cancel">
		    </form>
		</div>
		
		<div id="email_form" style="padding:40px; text-align: left;">
			<label id="email_update" style="float:right; cursor: pointer;">수정</label>
			Email<br>
			<font id="font_email" style="color:gray;">${info.email}</font>
		</div>
		<div id="email_panel" class="div">
		    <label for="email">Email</label>
		    <form name="f_email">
			    <input class="input" type="text" id="email" name="email" maxlength="30" placeholder="${info.email}">
			    <input class="input" type="button" value="확인" id="email_bt">
			    <input class="input" type="button" value="취소" id="email_cancel">
		    </form>
		</div>	
		<div id="check_panel" class="div">
		    <label for="email">인증번호</label>
		    <form name="f_emailcheck">
			    <input class="input" type="text" id="emailcheck" name="emailcheck" maxlength="10">
			    <input class="input" type="button" value="확인" id="check_bt">
			    <input class="input" type="button" value="취소" id="check_cancel">
		    </form>
		</div>	
		
		
		<div id="phone_form" style="padding:40px; text-align: left;">
			<label id="phone_update" style="float:right; cursor: pointer;">수정</label>
			Phone Number<br>
			<font id="font_phone" style="color:gray;">${info.hp1}-${info.hp2}-${info.hp3}</font>
		</div>
		<div id="phone_panel" class="div">
			<label for="phone">Phone Number</label>
			<form name="f_phone">
			    <input class="input" style="width:25%;" type="text" id="hp1" name="hp1" maxlength="3" placeholder="${info.hp1}">
			    <input class="input" style="width:25%;" type="text" id="hp2" name="hp2" maxlength="4" placeholder="${info.hp2}">
			    <input class="input" style="width:25%;" type="text" id="hp3" name="hp3" maxlength="4" placeholder="${info.hp3}">
			    <input class="input" type="button" value="수정" id="hp_bt">
			    <input class="input" type="button" value="취소" id="phone_cancel">
			</form>
		</div>
		  
		<div id="passwd_form" style="padding:40px; text-align: left;">
			<label id="passwd_update" style="float:right; cursor: pointer;">수정</label>
			비밀번호<br>
			<font style="color:gray;">●●●●●●●●●●●●</font>
		</div>
		<div id="passwd_panel" class="div">
		    <label for="passwd">현재 비밀번호</label>
			<form name="f_passwd">
			    <input class="input" type="password" id="passwd" name="passwd" maxlength="15" placeholder="●●●●●●●●●●●●"><br>
			    <label for="newpasswd">수정할 비밀번호</label><br>
			    <input class="input" type="password" id="new_passwd" name="new_passwd" maxlength="15" placeholder="new password"><br>
			    <label for="passwdcheck">비밀번호 재확인</label><br>
			    <input class="input" type="password" id="passwd_check" name="passwd_check" maxlength="15" placeholder="reconfirm password"><br>
			    <input type="hidden" id="original" name="original" value="${info.passwd}">
			    <input class="input" type="button" value="수정" id="passwd_bt">
			    <input class="input" type="button" value="취소" id="passwd_cancel">
			</form>
		</div>
	  
	</div>
</div>


<%@ include file="../odiga/bottom.jsp"%>
