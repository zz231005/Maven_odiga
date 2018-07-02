<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<%
	request.setCharacterEncoding("UTF-8");  //한글깨지면 주석제거
	String inputYn = request.getParameter("inputYn");
	String roadAddrPart1 = request.getParameter("roadAddrPart1");
	String addrDetail = request.getParameter("addrDetail");
	String zipNo = request.getParameter("zipNo");
%>
</head>
<script language="javascript">
function init(){
	var url = location.href;
	var confmKey = "U01TX0FVVEgyMDE4MDMyMjE0MDAyNzEwNzc1NjI=";//승인키
	var resultType = "4"; 
	var inputYn= "<%=inputYn%>";
	if(inputYn != "Y"){
		document.form.confmKey.value = confmKey;
		document.form.returnUrl.value = url;
		document.form.action="http://www.juso.go.kr/addrlink/addrLinkUrl.do"; // 인터넷망
		document.form.submit();
	}else{
		opener.jusoCallBack("<%=roadAddrPart1%>","<%=addrDetail%>","<%=zipNo%>");
		window.close();
	}
}
</script>
<body onload="init();">
	<form id="form" name="form" method="post">
		<input type="hidden" id="confmKey" name="confmKey" value="" /> 
		<input type="hidden" id="returnUrl" name="returnUrl" value="" /> 
	</form>
</body>
</html>