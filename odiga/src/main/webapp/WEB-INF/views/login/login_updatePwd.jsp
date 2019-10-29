<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type='text/javascript'>
var update_emailCheck = false;
var password = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[`~!@#$%^&*+=-?/,.<>{}:;]).{6,15}$/;
var passwdOk;

function sendPasswd(){
	if(!f_update.passwd1.value){
		document.getElementById("pwd1_update_text").innerHTML = "비밀번호를 입력하십시오.";
		$('.pwd1_update_font').addClass('font_red');
		f_update.passwd1.focus();
		return;
	}else if(!f_update.passwd2.value){
		document.getElementById("pwd2_update_text").innerHTML = "비밀번호를 입력하십시오.";
		$('.pwd2_update_font').addClass('font_red');
		$('.pwd2_update_gong').css("padding-top", "5");
		f_update.passwd2.focus();
		return;
	}else{
		if( passwdOk || update_emailCheck ){
			alert("비밀번호가 변경되었습니다.")
			f_update.update_id.value = find_pwd_id.value;
			f_update.submit();
		}else{
			
		}
		
	}
}

function pwd1_update_Ok(){
	if(!password.test(f_update.passwd1.value)) {
		document.getElementById("pwd1_update_text").innerHTML = "영문,숫자,특수문자가 포함된 6~15자 사이의 문자로 입력해주세요.";
		$('.pwd1_update_font').removeClass('font_green');
		$('.pwd1_update_font').addClass('font_red');
		passwdOk = false;
	}else {
		document.getElementById("pwd1_update_text").innerHTML = "사용 가능한 비밀번호입니다.";
		$('.pwd1_update_font').removeClass('font_red');
		$('.pwd1_update_font').addClass('font_green');
		passwdOk = true;
	}
}

function pwd2_update_Ok(){
	$('.pwd2_update_gong').css("padding-top", "5");
	
	if(f_update.passwd1.value == f_update.passwd2.value && passwdOk){
		document.getElementById("pwd2_update_text").innerHTML = "비밀번호가 일치합니다.";
		$('.pwd2_update_font').removeClass('font_red');
		$('.pwd2_update_font').addClass('font_green');
		update_emailCheck = true;
	}else{
		document.getElementById("pwd2_update_text").innerHTML = "비밀번호가 일치하지 않습니다.";
		$('.pwd2_update_font').removeClass('font_green');
		$('.pwd2_update_font').addClass('font_red');
		update_emailCheck = false;
	}
}

<!-- 인풋 1때 2 update_emailCheck = false; -->
</script>

<div class="w3-container w3-green" align="right" style="padding-top: 25px;  border-radius: 5px;">
	<h2 style="margin-bottom: 0;">비밀번호 재설정</h2>
</div>
<form action = "login_updatePwdOk.do" name = "f_update" method = "post">
	<div align = "left" style="padding: 1em;">
		<label>비밀번호</label><br>
		<input class="w3-input" style="display: table-cell; outline: none;" type="password" name="passwd1" onkeyup="pwd1_update_Ok()">
		<div class = "pwd1_update_gong" style="padding-top:5px;">
			<font class = "pwd1_update_font font_red" id = "pwd1_update_text">영문,숫자,특수문자가 포함된 6~15자 사이의 문자로 입력해주세요.</font>
		</div>
		
		 <div style="padding-top: 15px;">
			<label>비밀번호 재입력</label><br>
			<input class="w3-input" style="display: table-cell; outline: none;" type="password" name="passwd2" onkeyup="pwd2_update_Ok()">
			<div class = "pwd2_update_gong" style="padding-top:20px;">
				<font class = "pwd2_update_font" id = "pwd2_update_text"></font>
			</div>
		</div>
		 	
		
		<div class = "w3-container" style="padding: 0;padding-top: 30px;">
			<input class="w3-input" style="border-radius: 4px;" type="button" value="비밀번호 변경" onclick="sendPasswd()">
		</div>
		
		<input type="hidden" name = "update_id" id = "update_id">
	</div>
</form>