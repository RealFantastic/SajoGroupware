<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정 페이지</title>
</head>
<body id="j_body">
<script>
	${msg}
</script>
  <form action="<%=request.getContextPath()%>/member/updatePwd" method="post" id="updatePwd" name="updatePwd">
    <div>
        <div>
            <div>
                <p>변경하실 비밀번호를 입력해 주세요.</p>
    			<div>
    				<label for="emp_no">아이디 : </label>
    				<input type="text" id="emp_no" name="emp_no" >
    			</div>
                <div>
                    <input type="password" id="password_new" name="password" placeholder="새 비밀번호" required="required"/>
                </div>
                <div>
                    <input type="password" id="password_new_chk" name="password_new_chk"  placeholder="새 비밀번호 확인" required="required"/>
                </div>
                <div>
                	<button type="submit" id="updatePwd_btn" name="updatePwd_btn">비밀번호 변경</button> 
               		<button type="reset" id="j_cancle_btn" name="j_cancle_btn" class="btn_green">취소</button>
                </div> 
            </div>
        </div>
    </div>
    </form>
    
<script type="text/javascript">
		
			$("#updatePwd_btn").on("click", function(){

				if($("#password_new").val() == ""){
					alert("변경비밀번호을를 입력해주세요");
					$("#password_new").focus();
					return false
				}
				if($("#password_new_chk").val() == ""){
					alert("변경비밀번호를 입력해주세요");
					$("#password_new_chk").focus();
					return false
				}
				if ($("#password_new").val() != $("#password_new_chk").val()) {
					alert("변경비밀번호가 일치하지 않습니다.");
					$("#password_new_chk").focus();
					return false
				}
				
			});
			
				
			
	</script>    
</body>
</html>