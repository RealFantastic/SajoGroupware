<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재 대기 문서</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>

<link href="<%=request.getContextPath() %>/resources/css/all_form.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/elec_approval_main.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/eap_sidebar.css" rel="stylesheet">
<!-- JSTree -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/mayoJstree.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/template_header.jsp"/>
	<jsp:include page="/WEB-INF/views/eap/eap_sidebar_template.jsp"/>
	<div class="bodyContent">
		<div class="content_top">
			<h1>결재 대기 문서</h1>
		</div>
		<div class="content_page">
			<div id="my_doc_list_container">
				<table class="table mylist">
				  <thead>
				    <tr>
				      <th scope="col">문서번호</th>
				      <th scope="col">기안일</th>
				      <th scope="col">결재양식</th>
				      <th scope="col">긴급</th>
				      <th scope="col">제목</th>
				      <th scope="col">첨부</th>
				      <th scope="col">기안자</th>
				    </tr>
				  </thead>
				  <tbody class="table-group-divider">
					  <c:choose>
					  	<c:when test="${empty waitList}">
					  		<tr>
					  			<td colspan="7" style="font-weight:bold; color: blue;"> 결재할 문서가 없습니다. </td>
					  		</tr>
					  	</c:when>
					  	<c:otherwise>
					  		<c:forEach var="list" items="${waitList }">
					  			<tr class="waiting_list" data-eano="${list.ea_no }">
							      <th scope="row">${list.ea_no }</th>
							      <td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${list.draft_date }"/></td>
							      <td>${list.form_title }</td>
							      <c:choose>
							      	<c:when test="${list.isemergency eq 'N' }">
										<td><img src="<%=request.getContextPath()%>/resources/images/blackalert.png" style="width:22.2px;"></td>
							      	</c:when>
							      	<c:otherwise>
								      	<td><img src="<%=request.getContextPath()%>/resources/images/alert.png" style="width:22.2px;"></td>
							      	</c:otherwise>
							      </c:choose>
							      <td>${list.ea_title }</td>
							      <c:choose>
							      	<c:when test="${not empty list.approvalFiles }">
							      		<td><i class="fa-solid fa-paperclip"></i></td>
							      	</c:when>
							      	<c:otherwise>
							      		<td>${list.approvalFiles.f_no }</td>
							      	</c:otherwise>
							      </c:choose>
							      <td>${list.drafter_name}</td>
							    </tr>
					  		</c:forEach>
					  	</c:otherwise>
					  </c:choose>
				  </tbody>
				</table>
			</div>
		</div>
	</div>
	
	<script>
	$(function(){
		$(document).on('click','.waiting_list',function(){
			var ea_no = $(this).data('eano');
			let form = document.createElement('form');
			form.setAttribute('method','POST');
			form.setAttribute('adction','<%=request.getContextPath()%>/eap/list/waitApprove/detail ?ea_no=' +eano);
			document.body.appendChild(form);
			form.submit();
		});
	});
	</script>
</body>
</html>