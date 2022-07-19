<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>죄송합니다</title>
<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
</head>
<body style="background-color:rgb(255, 138, 0);">
<div class="errorCode font5">
	<c:out value="${requestScope['javax.servlet.error.status_code']}"/>
</div>
<img src="<%=request.getContextPath()%>/resources/images/error.png" alt="긴급"/>
<button type="button" class="btn_yellow">메인으로</button>
</body>
</html>