<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자결재</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>

<link href="<%=request.getContextPath() %>/resources/css/all_form.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/elec_approval_main.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/eap_sidebar.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet">
<!-- JSTree -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/mayoJstree.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/template_header.jsp"/>
	<jsp:include page="/WEB-INF/views/eap/eap_sidebar_template.jsp"/>
    <div class="bodyContent">
    	<div class="content_top">
			<h1> 전자결재 홈 </h1>
		</div>
		<div class="content_page">
			<div id="home_my_draftedlist">
				<h1>기안 진행중</h1>
				<div id="drafted_doc_table_container">
					<div>
						<table id="list_app">
							<thead>
								<tr>
									<th>기안일</th>
									<th>결재양식</th>
									<th>긴급</th>
									<th>제목</th>
									<th>첨부</th>
									<th>결재상태</th>
								</tr>
							</thead>
							<tbody>
								<!-- TODO : 결재 작성 후 리스트 뿌릴 예정 -->
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div id="vacationForm">
				<jsp:include page="/WEB-INF/views/ea_form/vacationForm.jsp"></jsp:include>
			</div>
			<div id="bpForm">
				<jsp:include page="/WEB-INF/views/ea_form/bpForm.jsp"></jsp:include>
			</div>
			
		</div>
    </div> 

     
</body>
</html>