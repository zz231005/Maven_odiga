<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<style>
label{
	color:black;
}
</style>
<script type='text/javascript'>

function find_email_Check(){
	if(find_email3.value == '0'){
		find_email2.readOnly=false;
		find_email2.value=''
		find_email2.focus()
	}else{
		find_email2.readOnly=true;	
		find_email2.value=find_email3.value;
	}
}

function input_name_text(){
	document.getElementById("find_name_text").innerHTML = "";
	$('.find_name_gong').css("padding-top", "20");
}

function input_find_email(){
	document.getElementById("find_email_text").innerHTML = "";
	$('.find_email_gong').css("padding-top", "20");
}

function find_sendEmail(){
	if(!find_name.value){
		document.getElementById("find_name_text").innerHTML = "�̸��� �Է� �Ͻʽÿ�.";
		$('.find_name_font').addClass('font_red');
		$('.find_name_gong').css("padding-top", "5");
		find_name.focus();
		return;
	}else if(!find_email1.value || !find_email2.value){
		document.getElementById("find_email_text").innerHTML = "�̸����� �Է� �Ͻʽÿ�.";
		$('.find_email_font').addClass('font_red');
		$('.find_email_gong').css("padding-top", "5");
		find_email1.focus();
		return;
	}else{
		$.ajax({
			type: 'POST',
			url: 'login_findIdCheck.do',
			data: {
				"name" : $('#find_name').val(),
				"email" : $('#find_email1').val() + "@" + $('#find_email2').val()
			},
			success: function(data){
				if(data > 0){
					alert("�Է��Ͻ� E-mail�� ���̵� ���۵Ǿ����ϴ�.\n������ Ȯ���Ͻð� �α��� ��Ź�帳�ϴ�.")
					document.getElementById('login').style.display='block';
					document.getElementById('id_pwd_find').style.display='none';
				}else{
					alert("��ϵ� ������ �����ϴ�.")
					return;
				}
			}
		});
	}
}
</script>


<div class="w3-container" align="right" style="padding-top: 25px;">
	<h2>���̵� ã��</h2>
</div>
	<div style="margin-bottom: 20px; margin: 1em;" align = "left" >
	
	<label>�̸�</label><br>
	<input class = "w3-input" style="width: 100%; outline: none;" type = "text" id = "find_name" name = "find_name" onkeyup="input_name_text()">
	<div class="find_name_gong" style="padding-top: 20px;">
		<font class="find_name_font" id = "find_name_text"></font>
	</div>
	
	<div style="padding-top: 15px;">
		<label>Email</label><br>
		<input class="w3-input" style="width: 36%; display: table-cell; outline: none;" type="text" id = "find_email1"name="find_email1" onkeyup="input_find_email()">
		<font style="font-family: inherit; font-size: 17px; color:black;">@</font>
		<input class="w3-input" style="width: 28%; display: table-cell; outline: none;" type="text" id="find_email2" name="find_email2" readOnly>
		<select style="width: 28%; display: table-cell; outline: none; height: 49px" class="w3-input" name="find_email3" id="find_email3" onChange="find_email_Check()" >
			<option value="">�����ϼ���</option>
			<option value="naver.com">naver.com</option>
			<option value="hanmail.net">hanmail.net</option>
			<option value="nate.com">nate.com</option>
			<option value="gmail.com">gmail.com</option>
			<option value="0">�����Է�</option>
		</select>
	</div>
	<div class="find_email_gong" style="padding-top: 20px;">
		<font class="find_email_font" id = "find_email_text"></font>
	</div>
</div>
<div style="margin-top: 35px;" class = "w3-container">
	<input class="w3-input" type="button" style=" border-radius: 4px;" value="���̵� ����" onclick="find_sendEmail()">
</div>