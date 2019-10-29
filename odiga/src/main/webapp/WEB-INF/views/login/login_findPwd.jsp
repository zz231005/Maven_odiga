<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
label{
	color:black;
}

.find_pwd_panel{
	max-height: 0;
	overflow: hidden;
  	transition: max-height 0.2s ease-out;
}

.find_pwd_panel_hei{
	margin-top: 5;
	max-height: 50px;
}
</style>
<script type='text/javascript'>
var pwd_check_email;
var find_email_check = false;

function find_pwd_email_Check(){
	if(find_pwd_email3.value == '0'){
		find_pwd_email2.readOnly=false;
		find_pwd_email2.value=''
		find_pwd_email2.focus()
	}else{
		find_pwd_email2.readOnly=true;	
		find_pwd_email2.value = find_pwd_email3.value;
	}
}

function find_pwd_sendEmail(){
	if(!find_pwd_id.value){
		document.getElementById("find_id_text").innerHTML = "아이디를 입력 하십시오.";
		$('.find_id_font').addClass('font_red');
		$('.find_id_gong').css("padding-top", "5");
		find_pwd_id.focus();
		return;
	}else if(!find_pwd_email1.value || !find_pwd_email2.value){
		document.getElementById("send_pwd_email_text").innerHTML = "이메일을 입력 하십시오.";
		$('.send_pwd_email_font').addClass('font_red');
		$('.send_pwd_email_gong').css("padding-top", "5");
		find_pwd_email1.focus();
		return;
	}else if(pwd_email_bt.value == "인증번호 확인"){
		if(find_email_check){
			document.getElementById('id_pwd_find').style.display='none';
			document.getElementById('pwd_update').style.display='block';
		}else{
			document.getElementById("find_pwd_email_text").innerHTML = "인증번호를 확인하십시오.";
			$('.find_pwd_email_font').removeClass('font_green');
			$('.find_pwd_email_font').addClass('font_red');
			$('.find_pwd_email_gong').css("padding-top", "5");
			find_pwd_in_email.focus();
		}
	}else{
		if(pwd_email_bt.value == "인증번호 전송"){
			$.ajax({
				type: 'POST',
				url: 'login_findpwdCheck.do',
				data: {
					"id" : $('#find_pwd_id').val(),
					"email" : $('#find_pwd_email1').val() + "@" + $('#find_pwd_email2').val()
				},
				success: function(data){
					if(data == 0){
						alert("등록된 정보가 없습니다.")
						return;
					}else{
						alert("입력하신 E-mail로 인증번호가 전송되었습니다.");
						pwd_check_email = data;
						$('.find_pwd_panel').addClass('find_pwd_panel_hei');
						document.getElementById("pwd_email_bt").value = "인증번호 확인";
					}
				}
			});
		}
	}
}

function input_find_id(){
	document.getElementById("find_id_text").innerHTML = "";
	$('.find_id_gong').css("padding-top", "20");
}

function input_find_send_email(){
	document.getElementById("send_pwd_email_text").innerHTML = "";
	$('.send_pwd_email_gong').css("padding-top", "20");
}

function input_pwd_find_email(){
	document.getElementById("find_pwd_email_text").innerHTML = "";
	$('.find_pwd_email_gong').css("padding-top", "20");
}

function find_pwd_email_Ok(){
	if(pwd_check_email == find_pwd_in_email.value){
		document.getElementById("find_pwd_email_text").innerHTML = "인증번호가 일치합니다.";
		$('.find_pwd_email_font').removeClass('font_red');
		$('.find_pwd_email_font').addClass('font_green');
		$('.find_pwd_email_gong').css("padding-top", "5");
		find_email_check = true;
		return;
	}else{
		document.getElementById("find_pwd_email_text").innerHTML = "인증번호가 틀렸습니다.";
		$('.find_pwd_email_font').removeClass('font_green');
		$('.find_pwd_email_font').addClass('font_red');
		$('.find_pwd_email_gong').css("padding-top", "5");
		find_pwd_in_email.focus();
		find_email_check = false;
		return;
	}
}
</script>

<div class="w3-container" align="right" style="padding-top: 25px;">
	<h2>비밀번호 찾기</h2>
</div>
<div style="margin-top: 15px; margin: 1em;" align="left">
	<label>아이디</label><br>
	<input class="w3-input" style="outline: none;" type="text" id="find_pwd_id" onkeyup="input_find_id()">
	<div class="find_id_gong" style="padding-top: 20px;">
		<font class="find_id_font" id = "find_id_text"></font>
	</div>

	<div style="padding-top: 15px;">
		<label>Email</label><br>
		<input class="w3-input" style="width: 36%; display: table-cell; outline: none;" type="text" id = "find_pwd_email1"name="find_pwd_email1" onkeyup="input_find_send_email()" >
		<font style="font-family: inherit; font-size: 17px; color:black;">@</font>
		<input class="w3-input" style="width: 28%; display: table-cell; outline: none;" type="text" id="find_pwd_email2" name="find_pwd_email2" readOnly>
		<select style="width: 28%; display: table-cell; outline: none; height: 49px" class="w3-input" name="find_pwd_email3" id="find_pwd_email3" onChange="find_pwd_email_Check()" >
			<option value="">선택하세요</option>
			<option value="naver.com">naver.com</option>
			<option value="hanmail.net">hanmail.net</option>
			<option value="nate.com">nate.com</option>
			<option value="gmail.com">gmail.com</option>
			<option value="0">직접입력</option>
		</select>
	</div>
	<div class="send_pwd_email_gong" style="padding-top: 20px;">
		<font class="send_pwd_email_font" id = "send_pwd_email_text"></font>
	</div>
	<div class="find_pwd_panel">
		<input id = "find_pwd_in_email" type = "text" class = "w3-input" style="width: 73%; display: table-cell; outline: none;" onkeyup="input_pwd_find_email()" >
		<input class = "w3-input" style="width: 25%;display: table-cell;cursor: pointer; border-radius: 4px;" type= "button" value = "이메일 인증" onclick="find_pwd_email_Ok()">
	</div>
	<div class = find_pwd_email_gong style="padding-top: 20px;">
		<font  id = "find_pwd_email_text" class = "find_pwd_email_font" ></font>
	</div>
</div>
<div style="margin-top: 15px;" class = "w3-container">
	<input id = "pwd_email_bt" class="w3-input" type="button" style=" border-radius: 4px;" value="인증번호 전송" onclick="find_pwd_sendEmail()">
</div>