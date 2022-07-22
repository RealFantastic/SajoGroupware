<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

   <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
   	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
   	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
   	
 	<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
 	<link href="<%=request.getContextPath()%>/resources/css/findPwd.css" rel="stylesheet">
 	<link href="<%=request.getContextPath()%>/resources/css/chk_findPwd.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet">
	
	<!-- JSTree -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
</head>
<body id="j_body">

<jsp:include page="/WEB-INF/views/template_header.jsp"/>
	<form action="findPwd" method="post" name="findPwd">
		<div id="j_container">
			<div id="j_container1" style="height: 495px">
				<div id="j_container2" >
					<img id="j_logo_green"
					alt="mayo로고-초록색" 
					src="https://cdn.discordapp.com/attachments/976717450655694879/988136708518346832/unknown.png">
				</div>
					<div id="j_container3" class="j_div"> 
                        <div id="j_email" class="j_e">
                            <label>이메일 : </label>
                            <div>
                            <input type="text" id="email_id" name="email_id" required="required">
                            <span id="middle">@</span>
                            <input type="text" id="domain" name="domain" required="required"/>
                            <select id="domain_list" name="domain_list" required="required">
                                <option value="naver.com">naver.com</option>
                                <option value="google.com">google.com</option>
                                <option value="hanmail.net">hanmail.net</option>
                                <option value="nate.com">nate.com</option>
                                <option value="kakao.com">kakao.com</option>
                                <option value="direct">직접입력</option>
                              </select>
                              <button type="button"
                               id="emailChk_send_btn"
                               class="j_btn_gray" 
                               name="emailChk_send_btn" required="required">전송</button>
                              <input type="hidden" id="totalemail" name="email" value="" required="required">
                            </div>
                            <br><font class="feedback" size ="2"></font>
                        </div>
				
                       <div id="email_check" class="j_e" required="required">
                            <label>인증번호 : </label>
                            <input type="text" id="email_check_no" disabled required="required" >
                            <button type="button" id="email_check_btn" class="doubleChk" >인증</button>
 							<p class="point successEmailChk">인증번호 인증 해주십시오.</p>
							<input type="hidden" id="emailDoubleChk" required="required"/>
                            <br><font class="feedback" size ="2"></font>
                        </div>
				</div>
				<div id="j_btn" >
						<div class="j_div">
							<button type="button" id='updatePwd_btn' class="btn_yellow"
							onclick="location.href='<%=request.getContextPath()%>/member/updatePwd'"
							disabled>PW 재설정</button>
						</div>
						<div class="j_div">
						<button id="j_back_btn" type="button" onclick="history.go(-1);" 
						class="btn_gray">뒤로가기</button>
						</div>
				</div>
				<div id="j_logo_black">
					<img id="logo_black"
						alt="마요로고_검정" 
						src="https://cdn.discordapp.com/attachments/976717450655694879/996260321780047914/unknown.png">
				</div>
				<footer>
					<p class="mb-1" id="j_footer">&copy; 2022 참치 마요 주식회사 - 대표자 참지 않아 박정환</p>
				</footer>
			</div>
		</div>
	</form>
    <!-- 이메일 직접입력 -->
    <script>
        $(function (){

	        //직접입력 인풋박스 기존에는 숨어있다가
	        $("#domain").hide();
	        $("#domain_list").change(function() {
	            console.log("변했음.");
	            //  직접입력을 누를 때 나타남
	            if($(this).val()=="direct") {
	                $("#domain").show();
	                
	            }  else {
	                $("#domain").hide();
	            }
	        }); 
        });
        
        </script>
	<!-- 이메일 합치기 -->
	<script type="text/javascript">
		//이메일주소 가져오기
		$("#email_id").blur(function(){
			email();	
		});
		
		$("#domain_list").change(function(){
			email();	
		});
	
		function email() {
			const email = $("#email_id").val();
			const middle = $("#middle").text();
			const address = $("#domain_list").val();
			if(email != "" && address != "") {
				$("#totalemail").val(email+middle+address);
			}
		};
	</script>        
    <!-- 이메일 인증 -->
    <script>
	var code = "";
	$("#emailChk_send_btn").click(function(){
		var email = $("#totalemail").val();
		$.ajax({
	        type:"GET",
	        url:"findPwdEmail?email=" + email,
	        cache : false,
	        success:function(data){
	        	if(data == "error"){
	        		alert("이메일 주소가 올바르지 않습니다. 유효한 이메일 주소를 입력해주세요.");
					$("#totalemail").attr("autofocus",true);
					$(".successEmailChk").text("유효한 이메일 주소를 입력해주세요.");
					$(".successEmailChk").css("color","red");
	        	}else{	        		
					alert("인증번호 발송이 완료되었습니다.\n입력한 이메일에서 인증번호 확인을 해주십시오.");
	        		$("#email_check_no").attr("disabled",false);
	        		$("#email_check_btn").css("display","inline-block");
	        		$(".successEmailChk").text("인증번호를 입력한 뒤 이메일 인증을 눌러주십시오.");
	        		$(".successEmailChk").css("color","black");
	        		code = data;
	        	}
	        }
	    });
	});
	</script>
	<!-- 이메일 인증번호 대조  -->
	<script type="text/javascript">
		$("#email_check_btn").click(function(){
		if($("#email_check_no").val() == code){
			$(".successEmailChk").text("인증번호가 일치합니다.");
			$(".successEmailChk").css("color","green");
			$("#emailDoubleChk").val("true");
			$("#email_check_no").attr("disabled",true);
			$("#updatePwd_btn").attr("disabled",false);
		}else{
			$(".successEmailChk").text("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
			$(".successEmailChk").css("color","red");
			$("#emailDoubleChk").val("false");
			$("#email_check_no").attr("autofocus",true);
		}
	});
	</script>
</body>
</html>