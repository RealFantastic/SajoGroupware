<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 초대</title>

    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
   	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
   	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
   	
   	
   	<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/invite.css" rel="stylesheet">   
	<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet"> 
	
	<!-- JSTree -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
	
</head>
<body id="j_background">
<jsp:include page="/WEB-INF/views/template_header.jsp"/>
 	<div id="j_container">
	    <div id="j_container1">
	        <form id="invite" name="invite" action="<%=request.getContextPath()%>/member/invite" method="post">
	            <div>
	                <div>
	                    <p id="j_title">직원 초대</p>
	                </div>
	                <div>
	                    <p class="point successEmailChk">초대받을 직원의 메일주소를 입력해주세요.</p>
	                </div>
	                <div>
	                    <div>
	                    	<input type="hidden" value="cp_number">
	                        <input type="text" name="email" placeholder="이메일 주소" id="email" class="email">
	                        
	                    </div>
	                    <div>
	                    	<div class='addInput'>
	                    	
	                    	</div>
	                        <button type="button" id="add_btn" class="btn_yellow">+</button>
	                    </div>
	                    <div>
	                    	<button type="button" class="btn_green" id="invite_btn">초대하기</button>
	                    </div>
	                </div>
	                <div id="j_logo_black">
	                    <img alt="마요로고" 
	                    src="https://cdn.discordapp.com/attachments/976717450655694879/996260321780047914/unknown.png" 
	                    id="j_logo_img">
	                </div>
	            </div>
	        </form>
	    </div>
	    <div>
	        <footer>
	            <p class="mb-1" id="j_footer">&copy; 2022 참치 마요 주식회사 - 대표자 참지 않아 박정환</p>
	        </footer>
		</div>
	</div>        
    
    <!-- 추가버튼 -->
    <script type="text/javascript">
    	$(invite).ready (function (){
    		$('#add_btn').click(function(){
    			$('.addInput').append (
    				'<input type="type" name="email" value="이메일 주소" class="email">\
    				<button type="button" class="btnRemove">삭제</button><br>'
    			); //input taf 추가
    			$('.btnRemove').on('click',function(){
    				$(this).prev().remove();
    				$(this).next().remove(); //br삭제
    				$(this).remove();
    			});
    		});
    	});
    </script>
    <!-- 초대하기 버튼 -->
    <script>
	//var code = "";
	$("#invite_btn").click(function(){
		var email = $(".email").val();
		console.log(email);
		$.ajax({
	        type:"GET",
	        url:"<%=request.getContextPath()%>/member/inviteMail?email=" + email,
	        cache : false,
	        success:function(data){
	        	if(data == "error"){
	        		console.log(data);
	        		alert("이메일 주소가 올바르지 않습니다. 유효한 이메일 주소를 입력해주세요.");
					$(".email").attr("autofocus",true);
					$(".successEmailChk").text("유효한 이메일 주소를 입력해주세요.");
					$(".successEmailChk").css("color","red");
	        	}else{	        	
	        		console.log(data);
					alert("직원 초대 이메일 발송이 완료 되었습니다.");
					$("#email").val('');
	        		$("#email_check_btn").css("display","inline-block");
// 					$(".successEmailChk").text("직원 초대 이메일 발송이 완료 되었습니다.");
// 					$(".successEmailChk").css("color","green");

	        		//code = data;
	        	}
	        }
	    });
	});
	</script>
</body>
</html>