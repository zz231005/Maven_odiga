<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<style>
.bottom {
	background-color: #747474; height : 300px;
	width: 100%;
	height: 200px
}
.text {
	margin-top:-160px;
	text-align: center;
}

.bottom .body {
	
}

.text_font{
	font-size: 15px;
	color:#EAEAEA;
}

.body{
   height: 1650px;
}
</style>
<script>
	
	
</script>
<div class="bottom"></div>

	<div class = "text">
		<font class="Nanum, text_font" > 
			All material herein C 2018  Odiga Company Pte. Ltd., All Rights Reserved.
		</font><br>
		<font class="Nanum, text_font"> 
			오디가는 온라인 여행 및 관련 서비스 분야를 편히 이용하도록 제작하였습니다.
		</font>
	</div>
	<%
		if(session.getAttribute("user") != null){
			session.setMaxInactiveInterval(30*60);
		}
	%>
	
</body>
</html>