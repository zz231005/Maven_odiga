<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- login.jsp-->
<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		 $('#login_bt').on('click', function(){
			 if (!f_log.log_id.value){
					document.getElementById("log_id_text").innerHTML = "아이디를 입력을 하십시오.";
					$('.log_id_font').addClass("font_red");
					$('.log_id_gong').css("padding-top", "5");
					f_log.log_id.focus()
					return;
				}else if (!f_log.log_passwd.value){
					document.getElementById("log_passwd_text").innerHTML = "페스워드를 입력을 하십시오.";
					$('.log_passwd_font').addClass("font_red");
					$('.log_passwd_gong').css("padding-top", "5");
					f_log.log_passwd.focus()
					return;
				}
				else{
					$.ajax({
						type: 'POST',
						url: 'login_ok.do',
						data: {
							"id" : $('#log_id').val(),
							"passwd" : $('#log_passwd').val()
						},
						success: function(data){
							if(data > 0){
								document.location.reload();
							}else{
								alert("아이디 또는 페스워드가 틀렸습니다.")
							}
						}
					});
				}
		 });
	});
	
	function input_logId(){
		document.getElementById("log_id_text").innerHTML = "";
		$('.log_id_gong').css("padding-top", "20");
	}
	
	function input_logPasswd(){
		document.getElementById("log_passwd_text").innerHTML = "";
		$('.log_passwd_gong').css("padding-top", "20");
	}
	
	function find_id_pwd(){
		document.getElementById('login').style.display='none';
		document.getElementById('id_pwd_find').style.display='block';
	}
	
	
</script>

<div class="w3-container w3-green" style="padding-top: 25px; border-radius: 5px;" align="right">
	<h2 style="margin-bottom: 0;">로그인</h2>
</div>
<div align = "left">
	<form class="w3-container" name="f_log" method="POST">
		<p>
		<div>
			<label>아이디</label>
			<input class="w3-input" type="text" name="id" id="log_id" onkeyup="input_logId()" maxlength="20" >
		</div>
		<div class = "log_id_gong" style="padding-top: 20px;">
			<font id = "log_id_text" class = "log_id_font"></font>
		</div>
		<p>
		<div>
			<label>비밀번호</label>
			<input class="w3-input" type="password" name="passwd" id = "log_passwd" style="outline: none; cursor: pointer;" maxlength="15" onkeyup="input_logPasswd()" >
		</div>
		<div class = "log_passwd_gong" style="padding-top: 20px;">
			<font id = "log_passwd_text" class = "log_passwd_font"></font>
		</div>
		<p>
		<input class="w3-input" style=" border-radius: 4px;" id = "login_bt" type="button" value="로그인" >
	</form>
	 <div style = "padding-left: 10px">
	 	<label class = "line_text" style="cursor: pointer; margin-top: 0;" onclick="find_id_pwd()">
	         <font style="font-size: 4px;">아이디 또는 페스워드를 잊어버리셨나요?</font>
	    </label>
	</div> 
</div>