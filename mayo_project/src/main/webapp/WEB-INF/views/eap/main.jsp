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
<link href="<%=request.getContextPath()%>/resources/css/eap_sidebar.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/elec_approval_main.css" rel="stylesheet">
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
<c:if test="${not empty msg }">
	<script>
		alert('${msg}');
	</script>
</c:if>
	<jsp:include page="/WEB-INF/views/template_header.jsp"/>	
    <jsp:include page="/WEB-INF/views/eap/eap_sidebar_template.jsp"/>
    <div class="bodyContent">
    	<div class="content_top">
			<h1> 전자결재 홈 </h1>
		</div>
		<div class="content_page">
			<div id="home_my_draftedlist">
				<div class="list_title">
					<h1>기안 진행중</h1>				
				</div>
				<div id="drafted_doc_table_container">
					<table id="list_app" class="table draft_list">
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
							<tbody class="table-group-divider">
							<c:choose>
								<c:when test="${empty proceeding }">
									<tr>
										<td colspan="6" style="font-weight:bold; color: blue;"> 기안한 문서가 없습니다. </td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${proceeding }" begin="0" step="1" end="4" >
										<tr class="my_list" data-eano="${list.ea_no }" data-drafter_id="${list.drafter_id }">
							  				<th scope="row">${list.ea_no }</th>
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
											<c:choose>
										      	<c:when test="${list.result_code gt 0 }">
										      		<c:choose>
										      			<c:when test="${list.result_code eq 1 }">
										      				<td><div class="btn_gray">회수</div></td>
										      			</c:when>
										      			<c:when test="${list.result_code eq 2 }">
										      				<td><div class="btn_yellow">진행</div></td>
										      			</c:when>
										      			<c:when test="${list.result_code eq 3 }">
										      				<td><div class="btn_red">반려</div></td>
										      			</c:when>
										      			<c:otherwise>
										      				<td><div class="btn_gray">완료</div></td>
										      			</c:otherwise>
										      		</c:choose>
										      	</c:when>
										      	<c:otherwise>
										      		<td><div class="btn_green">접수</div></td>
										      	</c:otherwise>
										    </c:choose>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
			<div id="complete_list">
				<div class="list_title">
					<h1>완료 문서</h1>				
				</div>
				<div id="complete_doc_table_list">
					<table id="list_app" class="table draft_list">
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
						<tbody class="table-group-divider">
							<c:choose>
								<c:when test="${empty completeList }">
									<tr>
										<td colspan="6" style="font-weight:bold; color: blue;"> 완료된 문서가 없습니다. </td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${completeList }" begin="0" step="1" end="4" >
										<tr class="my_list" data-eano="${list.ea_no }" data-drafter_id="${list.drafter_id }">
							  				<th scope="row">${list.ea_no }</th>
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
											<td><div class="btn_gray">완료</div></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
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
    
    <c:if test="${not empty form_code }">
	    <script>
	    	var form_code = '${form_code}';
	    	if(form_code != null){
	   			$('.content_page').children().hide();
	    		switch(form_code){
	    		case"AR":
					$('#vacationForm').show();
					$('.content_top').children('h1').text("휴가신청서");
					break;
	    		case"BP":
					$('#bpForm').show();
					$('.content_top').children('h1').text("업무기안");
					break;
				case "SR":
					$('#srForm').show();
					$('.content_top').children('h1').text("지출결의서");
					break;
	    		}
	    	}
	    	<% request.getSession().removeAttribute("form_code");%>
	    </script>
    </c:if>
    
    <script>
     $('.my_list').click(function(){
    	var ea_no = $(this).data('eano');
    	var drafter_id = $(this).data('drafter_id');
    	console.log(ea_no);
    	console.log(drafter_id);
    	let form = document.createElement('form');
    	form.setAttribute('method','POST');
    	form.setAttribute('action','<%=request.getContextPath()%>/eap/list/detail?ea_no='+ea_no+'&drafter_id=' + drafter_id);
    	document.body.appendChild(form);
    	form.submit();
     });
    </script>
</body>
</html>