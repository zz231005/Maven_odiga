<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<script type='text/javascript'>
var update_emailCheck = false;
var password = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[`~!@#$%^&*+=-?/,.<>{}:;]).{6,15}$/;
var passwdOk;

function sendPasswd(){
	if(!f_update.passwd1.value){
		document.getElementById("pwd1_update_text").innerHTML = "��й�ȣ�� �Է��Ͻʽÿ�.";
		$('.pwd1_update_font').addClass('font_red');
		f_update.passwd1.focus();
		return;
	}else if(!f_update.passwd2.value){
		document.getElementById("pwd2_update_text").innerHTML = "��й�ȣ�� �Է��Ͻʽÿ�.";
		$('.pwd2_update_font').addClass('font_red');
		$('.pwd2_update_gong').css("padding-top", "5");
		f_update.passwd2.focus();
		return;
	}else{
		if( passwdOk || update_emailCheck ){
			alert("��й�ȣ�� ����Ǿ����ϴ�.")
			f_update.update_id.value = find_pwd_id.value;
			f_update.submit();
		}else{
			
		}
		
	}
}

function pwd1_update_Ok(){
	if(!password.test(f_update.passwd1.value)) {
		document.getElementById("pwd1_update_text").innerHTML = "����,����,Ư�����ڰ� ���Ե� 6~15�� ������ ���ڷ� �Է����ּ���.";
		$('.pwd1_update_font').removeClass('font_green');
		$('.pwd1_update_font').addClass('font_red');
		passwdOk = false;
	}else {
		document.getElementById("pwd1_update_text").innerHTML = "��� ������ ��й�ȣ�Դϴ�.";
		$('.pwd1_update_font').removeClass('font_red');
		$('.pwd1_update_font').addClass('font_green');
		passwdOk = true;
	}
}

function pwd2_update_Ok(){
	$('.pwd2_update_gong').css("padding-top", "5");
	
	if(f_update.passwd1.value == f_update.passwd2.value && passwdOk){
		document.getElementById("pwd2_update_text").innerHTML = "��й�ȣ�� ��ġ�մϴ�.";
		$('.pwd2_update_font').removeClass('font_red');
		$('.pwd2_update_font').addClass('font_green');
		update_emailCheck = true;
	}else{
		document.getElementById("pwd2_update_text").innerHTML = "��й�ȣ�� ��ġ���� �ʽ��ϴ�.";
		$('.pwd2_update_font').removeClass('font_green');
		$('.pwd2_update_font').addClass('font_red');
		update_emailCheck = false;
	}
}

<!-- ��ǲ 1�� 2 update_emailCheck = false; -->
</script>

<div class="w3-container w3-green" align="right" style="padding-top: 25px;  border-radius: 5px;">
	<h2 style="margin-bottom: 0;">��й�ȣ �缳��</h2>
</div>
<form action = "login_updatePwdOk.do" name = "f_update" method = "post">
	<div align = "left" style="padding: 1em;">
		<label>��й�ȣ</label><br>
		<input class="w3-input" style="display: table-cell; outline: none;" type="password" name="passwd1" onkeyup="pwd1_update_Ok()">
		<div class = "pwd1_update_gong" style="padding-top:5px;">
			<font class = "pwd1_update_font font_red" id = "pwd1_update_text">����,����,Ư�����ڰ� ���Ե� 6~15�� ������ ���ڷ� �Է����ּ���.</font>
		</div>
		
		 <div style="padding-top: 15px;">
			<label>��й�ȣ ���Է�</label><br>
			<input class="w3-input" style="display: table-cell; outline: none;" type="password" name="passwd2" onkeyup="pwd2_update_Ok()">
			<div class = "pwd2_update_gong" style="padding-top:20px;">
				<font class = "pwd2_update_font" id = "pwd2_update_text"></font>
			</div>
		</div>
		 	
		
		<div class = "w3-container" style="padding: 0;padding-top: 30px;">
			<input class="w3-input" style="border-radius: 4px;" type="button" value="��й�ȣ ����" onclick="sendPasswd()">
		</div>
		
		<input type="hidden" name = "update_id" id = "update_id">
	</div>
</form>