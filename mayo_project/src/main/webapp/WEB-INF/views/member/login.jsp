<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마요-로그인</title>
   	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
   	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>

	<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/login.css" rel="stylesheet">   
	<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet"> 

   	
   	
</head>
<body id="j_body">
<c:if test="${not empty msg }">
	<script>
		alert('${msg}');
	</script>
</c:if>
<jsp:include page="/WEB-INF/views/template_header_login.jsp"/>
    <div style="padding: 5%;">
        <form  id="login" name="login"
        	 action="<%=request.getContextPath()%>/member/login"
			 method="post"  >
            <div id="j_container">
                <div id="j_container1">
                    <div id="j_logo"><img id="logo" alt="마요로고" src="https://cdn.discordapp.com/attachments/976717450655694879/988136708518346832/unknown.png"></div>
        
                    <div id="j_container2">
                        <div id="j_emp_no">
                            <label for="emp_no" class="font3">ID</label>
                            <input type="text" id="emp_no" name="emp_no" maxlength="9" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required="required">
                        </div>
                        <div id="j_pwd">
                            <label for="password" class="font3">PW</label>
                            <input type="password" id="password" name="password" required="required">
                        </div>
                    </div>
                    <div id="j_login_btn">
                        <button type="submit" class="btn_green" id="login_btn">로그인</button>
                    </div>
                </div>
                <div id="j_btn">
                    <button type="reset" class="btn_yellow" id="join_btn" 
                    	onclick="location.href='<%=request.getContextPath()%>/company/enroll'">회사등록</button>
                    <button type="button" class="btn_gray" id="find_id_btn"
                    onclick="location.href='<%=request.getContextPath()%>/member/findId'">ID찾기</button>
                    <button type="button" class="btn_gray" id="find_pwd_btn"
                    onclick="location.href='<%=request.getContextPath()%>/member/findPwd'">PW찾기</button>
                </div>
            </div>
        </form>
        <footer>
            <p class="mb-1" id="j_footer">&copy; 2022 참치 마요 주식회사 - 대표자 참지 않아 박정환</p>
        </footer>
    </div>
    
    <!-- 유효성 체크  -->
  	<script>
    $("#login_btn").click(function(){
        if ($("#emp_no").val()=='') {
            alert("아이디를 입력하세요.");
            $("#emp_no").focus();
            return false;
        }
        if ($("#password").val()=='') {
            alert("패스워드를 입력하세요.");
        	$("#password").focus();
            return false;
        }
        
});	
    </script>

</body>
</html>