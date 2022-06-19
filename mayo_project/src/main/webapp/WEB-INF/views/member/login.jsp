<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마요-로그인</title>
<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/login.css" rel="stylesheet">   
   <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
   	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<jsp:include page="/WEB-INF/views/template_header.jsp"/>
<body id="j_body">
    <div>
        <form>
            <div id="j_container">
                <div id="j_container1">
                    <div id="j_logo"><img id="logo" alt="마요로고" src="https://cdn.discordapp.com/attachments/976717450655694879/988136708518346832/unknown.png"></div>
        
                    <div id="j_container2">
                        <div id="j_emp_no">
                            <label for="emp_no" class="font3">ID</label>
                            <input type="text" id="emp_no" name="emp_no">
                        </div>
                        <div id="j_pwd">
                            <label for="password" class="font3">PW</label>
                            <input type="password" id="password" name="password">
                        </div>
                    </div>
                    <div id="j_login_btn">
                        <button type="submit" class="btn_green" id="login_btn">로그인</button>
                    </div>
                </div>
                <div id="j_btn">
                    
                    <button type="reset" class="btn_yellow" id="join_btn">회원가입</button>
                    <button type="button" class="btn_gray" id="find_id_btn">ID찾기</button>
                    <button type="button" class="btn_gray" id="find_pwd_btn">PW찾기</button>
                </div>
            </div>
        </form>
        <footer>
            <p class="mb-1" id="j_footer">&copy; 2022 참치 마요 주식회사 - 대표자 참지 않아 박정환</p>
        </footer>
    </div>
</body>
</html>