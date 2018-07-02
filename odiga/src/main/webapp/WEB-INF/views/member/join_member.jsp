<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script type="text/javascript">
var idcheck = "idUncheck";
var emailcheck = "emailUncheck";
var passwdcheck = "passwdUncheck";
var password = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[`~!@#$%^&*+=-?/,.<>{}:;]).{6,15}$/;
var id_value = /^(?=.*[a-zA-Z])(?=.*[0-9])/;
var input_email_check;
var hp_text= /^[0-9]+$/;
var nameText= /^[��-��]{2,10}$/;

$(document).ready(function(){
	 $('#send_email').on('click', function(){
 		if(!f_join.email1.value || !f_join.email2.value){
 			document.getElementById("email_text").innerHTML = "�̸����� �Է��ϼ���.";
			$('.join_email_font').addClass('font_red');
			$('.email_gong').css("padding-top","5px");
 			f_join.email1.focus()
 		}else {
 			
 			$.ajax({
 				type: 'POST',
 				url: 'member_email.do',
 				data: {
 					"email1" : $('#email1').val(),
 					"email2" : $('#email2').val()
 				},
 				 success: function(data){
 					 if(data == 1){
 						$('.panel').removeClass('panel_hei');
 						document.getElementById("email_text").innerHTML = "�ߺ��� �̸����Դϴ�.";
 						$('.join_email_font').addClass('font_red');
 						$('.email_gong').css("padding-top","5px");
 			 			f_join.email1.focus()
						return
 					 }else{
 						$('.panel').addClass('panel_hei');
						alert("�Է��Ͻ� E-mail�� ������ȣ�� �����Ͽ����ϴ�.")
						input_email_check = data;
 					 }
 				}
 			});
 		}
 	});

	 
	 $('#idcheck_bt').on('click', function(){
         $.ajax({
             type: 'POST',
             url: 'member_check.do',
             data: {
                 "id" : $('#id').val()
             },
             success:function(data){
             	if(f_join.id.value== null){
         			document.getElementById("join_id_text").innerHTML = "���̵� �Է��ϼ���.";
         			$('.join_id_font').addClass('font_red');
         			f_join.id.focus()
         		}else if(f_join.id.value.length < 6 || !id_value.test(f_join.id.value)){
         			document.getElementById("join_id_text").innerHTML = "����, ���ڸ� ������ 6�� �̻� �Է��Ͻʽÿ�.";
         			$('.join_id_font').addClass('font_red');
         			f_join.id.focus()
         		}else if(data  > 0){
         			document.getElementById("join_id_text").innerHTML = "�ߺ��� ���̵��Դϴ�.";
                     $('.join_id_font').addClass('font_red');
                 }else{
                 	document.getElementById("join_id_text").innerHTML = "��� ������ ���̵��Դϴ�.";
                 	idcheck = "idCheck";
                 	$('.join_id_font').removeClass('font_red');
                     $('.join_id_font').addClass('font_green');
                 }
             	$('.join_gong').addClass('join_text_gong');
             }
         });    //end ajax    
     });    //end on
});

function Check(){
	if(!f_join.name.value){
		 document.getElementById("name_text").innerHTML = "�̸��� �Է��� �Ͻʽÿ�.";
		$('.join_name_font').addClass('font_red');
		$("#name_gong").css("padding-top","5")
		f_join.name.focus();
		return;
	}else if(!nameText.test(f_join.name.value)){
		document.getElementById("name_text").innerHTML = "�̸��� �Է� �Ͻʽÿ�.";
		$('.join_name_font').addClass('font_red');
		$("#name_gong").css("padding-top","5")
		f_join.name.focus();
		return;
	}else if(!f_join.id.value){
		document.getElementById("join_id_text").innerHTML = "���̵� �Է��� �Ͻʽÿ�.";
		$('.join_id_font').addClass('font_red');
		$('.join_gong').addClass('join_text_gong');
		f_join.id.focus();
		return;
	}else if(!f_join.passwd.value){
		document.getElementById("join_passwd_text").innerHTML = "��й�ȣ�� �Է��� �Ͻʽÿ�.";
		$('.join_passwd_font').removeClass('font_green');
		$('.join_passwd_font').addClass('font_red');
		f_join.passwd.focus();
		return;
		document.getElementById("join_passwd_text").innerHTML = "��й�ȣ�� �°� �Է��� �Ͻʽÿ�.";
		$('.join_passwd_font').removeClass('font_green');
		$('.join_passwd_font').addClass('font_red');
		f_join.passwd.focus();
		return;
	}else if(!f_join.hp2.value || !f_join.hp3.value){
		document.getElementById("tel_text").innerHTML = "��ȭ��ȣ�� �Է��� �Ͻʽÿ�.";
		$('.join_tel_font').addClass('font_red');
		$("#tel_gong").css("padding-top","5")
		if(!f_join.hp2.value){
			f_join.hp2.focus();
		}else if(!f_join.hp3.value){
			f_join.hp3.focus();
		}
		return;
	}else if(!hp_text.test(f_join.hp2.value) || !hp_text.test(f_join.hp3.value)){
			document.getElementById("tel_text").innerHTML = "���ڸ� �Է��ϼ���.";
			$('.join_tel_font').addClass('font_red');
			$("#tel_gong").css("padding-top","5")
				f_join.hp2.focus();
			return;
	}else if(idcheck=="idUncheck"){
		document.getElementById("join_id_text").innerHTML = "�ߺ�üũ�� �Ͻʽÿ�.";
		$('.join_id_font').addClass('font_red');
		$('.join_gong').addClass('join_text_gong');
		f_join.id.focus();
		return;
	}else if(emailcheck=="emailUncheck"){
		document.getElementById("email_text").innerHTML = "�̸��� ������ �Ͻʽÿ�.";
		$('.join_email_font').addClass('font_red');
		$('.email_gong').css("padding-top","5px");
		emailcheck = "emailUncheck";
		f_join.email1.focus();
		return;
	}
	document.f_join.submit()
}

function limitName(){
	if((event.keyCode<126)||(event.keyCode>33)) {
		 event.returnValue=false;
	}
}

function email_Check(){
	if(f_join.email3.value == '0'){
		f_join.email2.readOnly=false;
		f_join.email2.value=''
		f_join.email2.focus()
	}else{
		f_join.email2.readOnly=true;	
		f_join.email2.value=f_join.email3.value;
	}
}

function inputId(){
	document.getElementById("join_id_text").innerHTML = "";
	$('.join_id_font').removeClass('font_red');
	$('.join_gong').removeClass('join_text_gong');
	idcheck="idUncheck";
}

function nameputId(){
	document.getElementById("name_text").innerHTML = "";
	$('.join_name_font').removeClass('font_red');
	$("#name_gong").css("padding-top","20")
	idcheck="idUncheck";
}

function inputEmail() {
	document.getElementById("email_text").innerHTML = "";
	$('.email_gong').css("padding-top","20px");
	emailcheck = "emailUncheck";
}

function inputTel() {
	document.getElementById("tel_text").innerHTML = "";
	$('.join_tel_font').removeClass('font_red');
	$("#tel_gong").css("padding-top","20")
}


function email_check() {
	if (input_email_check == $('#in_email').val()) {
		emailcheck = "emailcheck";
		document.getElementById("email_text").innerHTML = "������ȣ�� ��ġ�մϴ�.";
		$('.join_email_font').removeClass('font_red');
		$('.join_email_font').addClass('font_green');
	} else {
		document.getElementById("email_text").innerHTML = "������ȣ�� Ʋ�Ƚ��ϴ�.";
		emailcheck = "emailUncheck";
		$('.join_email_font').removeClass('font_green');
		$('.join_email_font').addClass('font_red');
	}
	$('.email_gong').css("padding-top","5px");
}


function pwdCheck() {
	if (password.test(f_join.passwd.value)) {
		document.getElementById("join_passwd_text").innerHTML = "��� ������ ��й�ȣ�Դϴ�.";
		$('.join_passwd_font').removeClass('font_red');
		$('.join_passwd_font').addClass('font_green');
		passwdcheck = "passwdcheck";
		return;
	} else if (!password.test(f_join.passwd.value)) {
		document.getElementById("join_passwd_text").innerHTML = "����, ����, Ư����ȣ�� ����� 6~15�ڱ��� ����� �� �ֽ��ϴ�.";
		$('.join_passwd_font').removeClass('font_green');
		$('.join_passwd_font').addClass('font_red');
		passwdcheck = "passwdUncheck";
		return;
	}
}
</script>

<div class="w3-container w3-green" style="padding-top: 25px; padding-bottom: 5px; border-radius: 5px;" align="right">
	<h2 style="margin-bottom: 0;">ȸ������</h2>
</div>
<div style="padding: 0;" align="left">
	<form name="f_join" class="w3-container" method="POST" action="member_input.do">
		<p>
			<div>
				<label style="padding-top: 10px;">�̸�</label><br><!-- �̸� �Է� -->
				<input class="w3-input" style="outline: none;" type="text" name="name" onkeyup="nameputId()" onkeypress="limitName()"
				maxlength="20">
			</div>
			<div id = "name_gong" style="padding-top: 20px;" >
				<font id = "name_text" class = "join_name_font"></font>
			</div>
			
		<p>	
		
			<div>
				<label>���̵�</label><br>  <!-- ���̵� �Է� -->
				<input class="w3-input" style="width: 79%; outline: none; display: table-cell;" type="text" name="id" id = "id" onkeyup="inputId()" maxlength="20" >
				<input class="w3-input" style="width: 20%; display: table-cell; cursor: pointer; border-radius: 4px;" type="button" value="id�ߺ�Ȯ��" id = "idcheck_bt">
			</div>
			<div class = "join_gong">
				<font  id = "join_id_text" class="join_id_font" ></font>
			</div>
			
		<p>
		
			<div>
				<label>��й�ȣ</label>   <!-- ��й�ȣ �Է� -->
				<input class="w3-input" type="password" name="passwd" style="outline: none;"  maxlength="15" onkeyup="pwdCheck()" >
			</div>
			<div  style="padding-top: 5px;">
				<font id = "join_passwd_text" class = "join_passwd_font">����, ����, Ư����ȣ�� ����� 6~15�ڱ��� ����� �� �ֽ��ϴ�.</font>
			</div>
			
		<p>
		
			<div>
				<label>����ó</label><br>  <!-- ��ȭ��ȣ �Է� -->
				<select class="w3-input" style="width: 30%; display: table-cell; outline: none; height: 49px;" name="hp1">
					<option value="010">010</option>
					<option value="011">011</option>
					<option value="016">016</option>
					<option value="017">017</option>
					<option value="018">018</option>
					<option value="019">019</option>
				</select>-
				<input class="w3-input" style="width: 32%; display: table-cell; outline: none;" type="text" name="hp2" maxlength="4" size="4" onkeyup="inputTel()"> -
				<input class="w3-input" style="width: 32%; display: table-cell; outline: none;" type="text" name="hp3" maxlength="4" size="4" onkeyup="inputTel()">
			</div>
			<div id = "tel_gong" style="padding-top: 20px;" >
				<font id = "tel_text" class = "join_tel_font"></font>
			</div>
		<p>
			<div>
				<label>Email</label><br>  <!-- �̸��� �Է� -->
				<input class="w3-input" style="width: 33%; display: table-cell; outline: none;" type="text" id = "email1"name="email1" onkeyup="inputEmail()">
				<font style="font-family: inherit; font-size: 17px;">@</font>
				<input class="w3-input" style="width: 20%; display: table-cell; outline: none;" type="text" id="email2" name="email2" readOnly>
				<select style="width: 20%; display: table-cell; outline: none; height: 49px" class="w3-input" name="email3" onChange="email_Check()" >
					<option value="">�����ϼ���</option>
					<option value="naver.com">naver.com</option>
					<option value="hanmail.net">hanmail.net</option>
					<option value="nate.com">nate.com</option>
					<option value="gmail.com">gmail.com</option>
					<option value="0">�����Է�</option>
				</select>
				<input id = "send_email" class="w3-input" style="width: 20%; display: table-cell; border-radius: 4px;" type="button" value="�����ϱ�">
				
				
				<div id = "email_input" class="panel">
					<input id = "in_email" type = "text" class = "w3-input" style="width: 79%; display: table-cell; outline: none;">
					<input class = "w3-input" style="width: 20%;display: table-cell;cursor: pointer; border-radius: 4px;" type= "button" value = "�̸��� ����" onclick="email_check()">
				</div>
				<div class = "email_gong">
					<font  id = "email_text" class = "join_email_font" ></font>
				</div>
			</div>
		<p>
		 	<input class="w3-input" style="cursor: pointer; border-radius: 4px;" type="button" value="�����ϱ�" onclick="Check()">
	</form>
</div>
