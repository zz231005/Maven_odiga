<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 
<jsp:scriptlet>
	pageContext.setAttribute("cr", "\r");
	pageContext.setAttribute("lf", "\n");
	pageContext.setAttribute("crlf", "\r\n");
</jsp:scriptlet>

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<style type="text/css">
.context{
	outline: none;
	border: none;
	padding: 0 25px;
	width: 100%;
	resize: none;
	font-size: 12px;
}
.sub_bt{
	background-color: #4CAF50;
	border: none;
	border-radius: 4px;
	color: white;
	padding: 5px 20px;
	text-align: center;
	text-decoration: none;
	display: inline-bl ock;
	font-size: 13px;
}


fieldset, label { margin: 0; padding: 0; }
.rating_div {
	padding-left: 20px;
	padding-top: 5px;
	font-size: 15px;
}

/****** Style Star Rating Widget *****/

.rating { 
  border: none;
  float: left;
}

.rating > input { display: none; } 
.rating > label:before { 
  margin: 2px;
  font-size: 1.25em;
  font-family: FontAwesome;
  display: inline-block;
  content: "\f005";
}

.rating > .half:before { 
  content: "\f089";
  position: absolute;
}

.rating > label { 
  color: #ddd; 
 float: right; 
}

.dropdown {
	padding-left: 30px;
    position: relative;
    display: inline-block;
}

.del_dropdown-content {
	position: absolute;
	margin-top:11px;
	width: 152px;
    left: -82px;
    display: none;
    overflow: auto;
    box-shadow: 1px 1px 2px rgba(0,0,0,0.2);
    z-index: 1;
    background:white;
    border: 1px solid #ddd;
}

.edit_dropdown-content {
	position: absolute;
	margin-top:11px;
	width: 152px;
    left: -18px;
    display: none;
    overflow: auto;
    box-shadow: 1px 1px 2px rgba(0,0,0,0.2);
    z-index: 1;
    background:white;
    border: 1px solid #ddd;
}



.del_bt{
	 background-color: red;
	 outline:none;
	 color :white; 
	 border: none; 
	 border-radius: 4px; 
	 padding: 3px 6px;
	 cursor: pointer;
}

.edit_bt{
	 background-color: green;
	 outline:none;
	 color :white; 
	 border: none; 
	 border-radius: 4px; 
	 padding: 3px 6px;
	 cursor: pointer;
}

.del_dropdown a:hover {background-color: #ddd}

.show {display:block;}


/***** CSS Magic to Highlight Stars on Hover *****/

.rating > input:checked ~ label, /* show gold star when clicked */
.rating:not(:checked) > label:hover, /* hover current star */
.rating:not(:checked) > label:hover ~ label { color: #FFD700;  } /* hover previous stars in list */

.rating > input:checked + label:hover, /* hover current star when changing rating */
.rating > input:checked ~ label:hover,
.rating > label:hover ~ input:checked ~ label, /* lighten current selection */
.rating > input:checked ~ label:hover ~ label { color: #FFED85;  } 
</style>
<script type="text/javascript">

$(document).ready(function(){
	$('.full').on('click', function(){
		star_rate.value = $(this).attr('id');
	});
	$('.half').on('click', function(){
		star_rate.value = $(this).attr('id');
	});
});

function scro_top(){
	parent.scroll_comment();
}

function to_ajax(){
	var queryString = $("form[name=comment]").serialize() ;
	$.ajax({
        type : 'post',
        url : 'comment_write.do',
        data : queryString,
        success : function(){
        	parent.document.location.reload();
        },
    });
}


function del_commnet_go(num, star_rate){
	$.ajax({
        type : 'post',
        url : 'comment_delete.do',
        data : {
        	"passwd" : $('#del_passwd_'+num).val(),
        	"num": num,
        	"hotel_num" : $('#hotel_num').val(),
        	"score" : $('#score').val(),
        	"population" : $('#population').val(),
        	"star_rate" : star_rate
        },
        success : function(data){
        	if(data == 1){
	        	alert("삭제되었습니다.")
	        	parent.document.location.reload();
        	}else{
        		alert("페스워드가 틀렸습니다.")
        	}
        }
    });
}

function edit_comment_go(num){
	$.ajax({
        type : 'post',
        url : 'comment_update.do',
        data : {
        	"title" : $('#title_edit_'+num).val(),
        	"num": num,
        	"comments": $('#comments_'+num).val(),
        	"passwd" : $("#edit_passwd_"+num).val(),
        },
        success : function(data){
        	if(data == 1){
	        	alert("수정이 완료되었습니다.")
	        	document.location.reload();
        	}else{
        		alert("페스워드가 틀렸습니다.")
        	}
        }
    });
}

function edit_comment(num){
	if($("#edit_lab_"+num).html() == "수정"){
		if($("#del_lab_"+num).html() == "삭제취소"){
			document.getElementById("del_lab_"+num).innerHTML = "삭제";
			document.getElementById("del_Dropdown_"+num).classList.toggle("show");
		}
		document.getElementById("edit_lab_"+num).innerHTML = "수정취소";
		$("#title_edit_"+num).attr("readonly", false);
		document.getElementById("comments_edit_"+num).style.display='block';
		document.getElementById("comments_read_"+num).style.display='none';
		document.getElementById("bg_"+num).style.background = '#F2FFED';
		$("#title_edit_"+num).focus()
	}else{
		document.location.reload();
	}
}

function del_comment(num){
	if($("#del_lab_"+num).html() == "삭제"){
		if($("#edit_lab_"+num).html() == "수정취소"){
			document.getElementById("edit_lab_"+num).innerHTML = "수정";
			document.getElementById("edit_Dropdown_"+num).classList.toggle("show");
		}
		document.getElementById("del_lab_"+num).innerHTML = "삭제취소";
		document.getElementById("bg_"+num).style.background = '#FFEAEA';
	}else{
		document.location.reload();
	}
}

function del_pass(num){
	document.getElementById("del_Dropdown_"+num).classList.toggle("show");
}

function edit_pass(num){
	document.getElementById("edit_Dropdown_"+num).classList.toggle("show");
}

</script>

</head>
<body>
	<div align="center">
		<c:if test ="${!empty sessionScope.user}">
			<div style=" margin-bottom:40px; padding-top: 5px; " >
				<form name = "comment" id = "comment">
					<input type="hidden" name="hotel_num" id = "hotel_num" value = "${num}">
					<input type="hidden" name="id" value = "${sessionScope.user.id }">
					<input type="hidden" id = "score"name = "score" value = "true">
					<input type="hidden" id = "population" name = "population">
					<input type = "hidden" id = "star_rate" name = "star_rate" value = "1">
					<div style="width: 800px; height: 230px; border: 2px solid #ddd; border-radius: 7px;  box-shadow: 0 0 10px #8C8C8C;"><!-- 입력 -->
						<div style="margin: 10px 0 0 20px; font-size: 13px;" align = "left">
							<div style="display: table-cell; padding:0; padding-right: 5px; padding-top:3px;">
								<i class="material-icons" >person</i>
							</div>
							<div style="vertical-align: middle; display: table-cell; width: 665px;">
								<c:if test = "${sessionScope.user.admin != null }">
									${sessionScope.user.admin }
								</c:if>
								<c:if test = "${sessionScope.user.admin == null }">
									<label>${sessionScope.user.id }</label>
								</c:if>
							</div>
							<div style="display: table-cell; vertical-align: middle;">	
								<input class="sub_bt" type="button" value="등록" style="cursor: pointer;" onclick="to_ajax()"/>
							</div>
						</div>
						<div style="padding: 10px 18px;">
							<div style="width: 100%; border: 1px solid #ddd; border-left: 0;  border-right: 0; padding: 5px 0;" align="left">
								<div style="padding: 0 10px;">
									<div style="padding-right:10px;   display: table-cell; border-right: 1px solid #ddd;" >
										<label style="font-size: 13px">제목</label>
									</div>
									<div style="display: table-cell;padding-left: 10px;">
										<input type = "text" name = "title" style="width: 570px;; outline: none; border: none; font-size: 13px">
									</div>
									<div  style="padding-right:10px;   display: table-cell; border-right: 1px solid #ddd;">
										<label style="font-size: 13px">비밀번호</label>
									</div>
									<div style="display: table-cell; padding-left: 10px;">
										<input name = "passwd" id = "passwd" type = "password" size="6" maxlength="6"  style="width:50px; outline: none; border: none;">
									</div>
								</div>
							</div>
						</div>
						<div style="outline: none; margin-left: 1px;">
							<textarea class = "context" name="comments" rows="5" cols="100" placeholder="100글자 이내로 입력 부탁합니다."></textarea>
						</div>
							<div class = "rating_div" >
								<fieldset class="rating">
									<input type="radio" id="10" name="rating" value="5"/><label class = "full" for="10" id="10"></label>
									<input type="radio" id="9" name="rating" value="4 and a half" /><label class="half" for="9" id="9"></label>
									<input type="radio" id="8" name="rating" value="4" /><label class = "full" for="8" id="8"></label>
									<input type="radio" id="7" name="rating" value="3 and a half" /><label class="half" for="7" id="7"></label>
									<input type="radio" id="6" name="rating" value="3" /><label class = "full" for="6" id="6"></label>
									<input type="radio" id="5" name="rating" value="2 and a half" /><label class="half" for="5" id="5"></label>
									<input type="radio" id="4" name="rating" value="2" /><label class = "full" for="4" id="4"></label>
									<input type="radio" id="3" name="rating" value="1 and a half"/><label class="half" for="3" id="3" ></label>
									<input type="radio" id="2" name="rating" value="1" /><label class = "full" for="2" id="2"></label>
									<input type="radio" id="1" name="rating" value="half" checked/><label class="half" for="1" id="1"></label>
								</fieldset>
								<div style="font-size:12px; color: #A6A6A6; padding-top: 7px; float: left; padding-left: 5px;">
									별점은 수정이 불가능 합니다.
								</div>
						</div>
					</div>	
				</form>
			</div>
			<script type="text/javascript">
				score.value = parent.getScore();
				population.value = parent.getPopul();
			</script>
		</c:if>
		<c:forEach var="comment_dto" items="${commentList}"><!-- border: 1px solid #ddd; -->
			<div  style="width: 880px; border: 2px solid #ddd; margin-bottom: 20px; border-radius: 7px; box-shadow:3px 3px 16px #BDBDBD;">
				<div align = "left"><!-- title -->
					<div style="display: table-cell; border-right: 2px solid #ddd; vertical-align: middle;">
						<div  style="padding: 0 20px; font-size: 12px; text-align:center; width: 100px; ">
							${comment_dto.id}<br>
						</div>
					</div>
					<div style="display: table-cell; ">
						<div id = "bg_${comment_dto.num }" style="border-bottom: 1px solid #ddd; padding: 10px 0 32px 20px; width: 775px; border-radius: 7px;">
							<div>
							<div style="display: table-cell; float:left;">
								<input  id = "title_edit_${comment_dto.num }" type = "text" value = "${comment_dto.title}" readonly size = "50" style="border:none; outline:none; font-size: 15px; font-weight:bolder; font-family: 나눔고딕-B; background: none;">
							</div>
							<c:if test ="${!empty sessionScope.user}">
								<div style="font-size: 12px; font-weight: bold; display: table-cell; padding-right:15px; padding-top:3px; float:right;">
									<div class="dropdown"  style="border-right: 1px solid #ddd; display: table-cell; padding-right: 9px;">
										<label class="del_dropbtn" id = "edit_lab_${comment_dto.num }" style="cursor: pointer;"onclick="edit_comment(${comment_dto.num }), edit_pass(${comment_dto.num })">수정</label>
										<div id="edit_Dropdown_${comment_dto.num }"  class="edit_dropdown-content">
											<div style="margin: 5px 7px;">
												<input type = "password" id = "edit_passwd_${comment_dto.num }" size ="6" maxlength="6" style="display: table-cell;">
												<input type = "button" class = "edit_bt" style="display: table-cell;" value ="수정하기" onclick="edit_comment_go(${comment_dto.num  })" >
											</div>
										</div>
									</div>
									<div class="dropdown"   style="display: table-cell; padding-left: 8px; ">
										<label id = "del_lab_${comment_dto.num }" class="del_dropbtn" onclick="del_pass(${comment_dto.num }), del_comment(${comment_dto.num })"  style="cursor: pointer;">삭제</label>
										<div id="del_Dropdown_${comment_dto.num }"  class="del_dropdown-content">
											<div style="margin: 5px 7px;">
												<input type = "password" id = "del_passwd_${comment_dto.num }" size ="6" maxlength="6" style="display: table-cell;">
												<input type = "button" class = "del_bt" style="display: table-cell;" value ="삭제하기" onclick="del_commnet_go(${comment_dto.num }, ${comment_dto.star_rate  })" >
											</div>
										</div>
									</div>
								</div>
							</c:if>
							</div>
						</div>
						<div id = "comments_read_${comment_dto.num }" style="padding: 20px; padding-top:35px; font-size: 12px;">
							${fn:replace(comment_dto.comments,crlf,'</br>')}
						</div>
						 <div id = "comments_edit_${comment_dto.num }" style="padding: 18px; padding-top:33px; padding-bottom:0; font-size: 12px; display: none;" >
							<textarea id = "comments_${comment_dto.num }"rows="2" cols="100" style="outline: none;border: none; resize: none;">${comment_dto.comments}</textarea>
						</div> 
						<div style="padding:20px 0 20px 20px; font-size: 12px; color: #A6A6A6; float: left; ">
							작성일:${comment_dto.logtime}
						</div>
						<div style="float: right; padding:18px 20px 0 0;">
							<c:forEach var="j" begin="1" end="5">
								<c:choose>
									<c:when test="${(comment_dto.star_rate / 2) >= j}">
										<i class="fa fa-star" style="font-size: 18px; color: orange;"></i>
									</c:when>
									<c:when
										test="${ 0.4 < ( 1 - (j - (comment_dto.star_rate/2)) ) && ( 1-(j - (comment_dto.star_rate/2)) ) < 1 }">
										<i class="fa fa-star-half-o"style="font-size: 18px; color: orange;"></i>
									</c:when>
									<c:otherwise>
										<i class="fa fa-star-o" style="font-size: 18px; color: orange;"></i>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	
	<c:set var = "currentPage" value = "1"/>
	<c:set var = "endPage" value = "${maxPage }"/>
	<c:if test = "${pageNum > 3 }">
		<c:set var = "currentPage" value = "${pageNum-2 }"/>
		<c:if test = "${pageNum >= maxPage -1 && pageNum !=  3 }">
				<c:set var = "currentPage" value = "${currentPage -1 }"/>
			<c:if test = "${pageNum ==  maxPage && pageNum !=  4}">
				<c:set var = "currentPage" value = "${currentPage -1 }"/>
			</c:if>
		</c:if>
	</c:if>
	<c:if test = "${maxPage > 5 }">
		<c:set var = "endPage" value = "${currentPage + 4 }"/>
	</c:if>
	
	<div class="w3-bar" align = "center" style="padding-top: 10px;">
		<c:forEach var = "i" begin="${currentPage }" end="${endPage }">
			<c:choose>
				<c:when test="${i == pageNum }">
					<label class="w3-button w3-green">${i}</label>
				</c:when>
				<c:otherwise>
					 <a href="commentPage.do?hotel_num=${num}&pageNum=${i }" class="w3-button" onclick= "scro_top()">${i }</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>
<script type="text/javascript">
	parent.document.all.comment_iframe.height = document.body.scrollHeight; 
</script>
</body>
</html>