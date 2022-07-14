<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>

   <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
   	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
   	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
   	
 	<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet">
	
	<!-- JSTree -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
</head>
<body>
	<div>
		<form action="">
			<div>
				<label>이름 : </label>
				<input type="text">
			</div>
			<div>
				<label>사원번호 : </label>
				<input type="text"> 
			</div>
			<div>
				<label>주민등록번호 : </label>
				<input type="text"> 
			</div>
			<div>
				<button type="submit">비밀번호 찾기</button>
			</div>
		</form>
	</div>
</body>
</html>