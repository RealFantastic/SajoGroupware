<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>죄송합니다</title>

<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/error.css" rel="stylesheet">
</head>

<body id="error_body">

	<div id="error_img">
		<img src="<%=request.getContextPath()%>/resources/images/400.png" alt="긴급"/>
	</div>
	<div>
		<!-- 메인 버튼 눌러서 돌아가는 로그인 페이지로 일단 설정해둠 / 로그인은 안풀림/ TODO 홈화면으로 넘겨줘야 할듯  -->
		<button type="button" class="btn_red main_btn" onclick="location.href='<%=request.getContextPath()%>/member/login'" >MAIN</button>
	</div>


</body>
</html>