<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 직원 근태내역 리스트</title>
	<!-- 부트스트랩 -->
	<link 
		rel="stylesheet" 
		href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" 
		integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" 
		crossorigin="anonymous">
	<script 
		src="https://code.jquery.com/jquery-3.5.1.slim.min.js" 
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" 
		crossorigin="anonymous"></script>
	<script 
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" 
		crossorigin="anonymous"></script>
	<!-- J쿼리 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>
	
	<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/commute_list.css" rel="stylesheet">
	<!-- JSTree -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script> <!-- 돋보기 -->
	
</head>

<body>

<jsp:include page="/WEB-INF/views/template_header.jsp"/>
<jsp:include page="/WEB-INF/views/template_left.jsp"/>


	<div class="left_bar_exception">
	
		<div class="commute_list font4">전체 직원별 근태내역 리스트</div>
		
		<!-- 	검색 -->
		<div class="search_bar">
		
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<button class="btn btn-outline-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						사원번호
					</button>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="#">사원명</a>
						<a class="dropdown-item" href="#">부서명</a>
					</div>
				</div>
				<input type="text" class="form-control" aria-label="Text input with dropdown button" placeholder="검색내용 입력 후 Enter">
			</div>

		</div>




		<div>
			<table class="commute_list_table">
				<colgroup>
					<col width="25%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="25%">
					<col width="20%">
				</colgroup>
				<thead>
					<tr>
						<th class="commute_table_list_th font2">사원번호</th>
						<th class="commute_table_list_th font2">사원명</th>
						<th class="commute_table_list_th font2">직함</th>
						<th class="commute_table_list_th font2">부서명</th>
						<th class="commute_table_list_th font2">연락처</th>
						<th class="commute_table_list_th font2">수정</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${fn:length(empCommuteList) == 0 }">
						<tr Class="no_list">
							<!-- 보여질 공지사항이 없을 경우 -->
							<td colspan="6"> 조회된 내용이 없습니다. </td>
						</tr>
					</c:if>
					<c:forEach var="emp" items="${empCommuteList}">
						<tr>
							<td class="commute_table_list_td">${emp.emp_no}</td>
							<td class="commute_table_list_td">${emp.emp_name }</td>
							<td class="commute_table_list_td">${emp.job_nm }</td>
							<td class="commute_table_list_td">${emp.dept_nm }</td>
							<td class="commute_table_list_td">${emp.phone }</td>
							<td class="commute_table_list_td"><button class="btn_red">수정하기</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>