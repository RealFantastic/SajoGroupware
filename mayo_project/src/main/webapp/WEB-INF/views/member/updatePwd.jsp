<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정 페이지</title>
   <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
   	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
   	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
   	
   	
   	<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/updatePwd.css" rel="stylesheet">   
	<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet"> 
	
	<!-- JSTree -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
</head>
<body id="j_body">
<c:if test="${not empty msg }">
	<script>
		alert('${msg}');
	</script>
</c:if>
<jsp:include page="/WEB-INF/views/template_header.jsp"/>
  <form action="<%=request.getContextPath()%>/member/updatePwd" method="post" id="updatePwd" name="updatePwd">
    <div id="j_container" style="position: relative; top: 100px;">
        <div id="j_container1">
            <div id="j_container2">
            	<p class="font3">비밀번호 재설정</p>
                <p>변경하실 비밀번호를 입력해 주세요.</p>
    			<div id="j_emp_no" class="j_div">
    				<label for="emp_no">아이디 : </label>
    				<input type="text" id="emp_no" name="emp_no" placeholder="아이디 입력" maxlength="9"  required="required">
    			</div>
                <div id="j_pwd1" class="j_div">
                    <input type="password" id="password_new" name="password" placeholder="새 비밀번호" required="required"/>
                </div>
                <div id="j_pwd2" class="j_div">
                    <input type="password" id="password_new_chk" name="password_new_chk"  placeholder="새 비밀번호 확인" required="required"/>
                </div>
                <div id="j_btn">
               		<button type="button" id="j_cancle_btn" name="j_cancle_btn" class="btn_yellow">뒤로가기</button>
                	<button type="submit" id="updatePwd_btn" name="updatePwd_btn" class="btn_green">비밀번호 변경</button> 
                </div> 
            </div>
       	    <div id="j_footer_c">
		        <footer>		
		            <p class="mb-1" id="j_footer">&copy; 2022 참치 마요 주식회사 - 대표자 참지 않아 박정환</p>
		        </footer>
			</div>
        </div>

    </div>
    </form>
 	<!-- 뒤로 가기 버튼 -->
	<script>
	   //뒤로 가기
	   $("#j_cancle_btn").click(function() {
	        var result = confirm('이전페이지로 이동하시겠습니까?'); 
	        if(result) { 
	            location.href="history.go(-1);";
	            } else { 
	            //no 
            	 location.href="history.go(0);";
	            }
	    });
	</script>   
<script type="text/javascript">
		
			$("#updatePwd_btn").on("click", function(){
				var emp_no = $('#emp_no').val();
				var password = $('input[name=password]').val();
				
			    if(emp_no == "") {
					alert("아이디를 입력해주십시오");
					$("#emp_no").focus();

					return false;
				}
		    	var regExpEmpNo = /^[0-9]{8,9}$/; //숫자9
		    	if(!regExpEmpNo.test(emp_no)){
		    		alert("유효하지 않는 아이디 입니다.");
		    		$("#emp_no").val('');
		    		$("#emp_no").focus();
		    		return false;
		    	}
				if($("#password_new").val() == ""){
					alert("새 비밀번호를 입력해주세요");
					$("#password_new").focus();
					return false
				}
				if($("#password_new_chk").val() == ""){
					alert("새 비밀번호 확인을 입력해주세요");
					$("#password_new_chk").focus();
					return false
				}
			    //새 비밀번호 형식 체크
				var regExpPassword = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}$/; // 영문자, 숫자가 적어도 1개이상, 8~16글자
				if(!regExpPassword.test(password)){
					alert("패스워드 입력란에는 영문자, 숫자가 적어도 1개이상, 8~16글자를 입력해주세요.");
					$("#password_new").val("");
					$("#password_new_chk").val("");
					$("#password_new").focus();
					return false;
				}
				if ($("#password_new").val() != $("#password_new_chk").val()) {
					alert("새 비밀번호가 일치하지 않습니다.");
					$("#password_new_chk").focus();
					return false
				}

				
			});
			
				
			
	</script>    
</body>
</html>