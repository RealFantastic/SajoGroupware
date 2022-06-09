<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 목록</title>
</head>
<body>
	<c:choose>
		<c:when test="${empty emp }">
			<h1>조회된 회원이 없음.</h1>
		</c:when>
		<c:otherwise>
			<c:forEach items="${emp }" var="emp">
				<div>사원번호 : ${emp.emp_no }</div>
				<div>이름 : ${emp.emp_name }</div>
				<div>이메일 : ${emp.email }</div>
				<div>전화번호 : ${emp.phone }</div>
				<div>입사일 : ${emp.hire_date }</div>
				<div>부서번호 : ${emp.dept_no }</div>
				<div>직급번호 : ${emp.job_no }</div>
			</c:forEach>
		</c:otherwise>
	
	</c:choose>
</body>
</html>