<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WorkDetail</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/resources/css/workDetail.css" rel="stylesheet">
</head>
<body>
<c:if test="${not empty work }">
	<c:forEach var="work" items="${work}">
	<div id="workBody" class='modal-lg' aria-labelledby='exampleModalLabel'>
		<div class='modal-dialog'>
			<div class='modal-content'>
				<div class='modal-header'>
				<div style="display:block;">
					<div> ${work.work_no }</div>
					<h5 class='modal-title font3 work_title' id='exampleModalLabel'
						style='font-weight: bold;'>${work.work_title }</h5>
				</div>
					<div>
						<button type='button' class='btn_gray btn-modify'>수정</button>
						<button type='button' class='btn_red btn-delete'>삭제</button>
					</div>
				</div>
				<form>
					<div class="modal-body">
						<input type="hidden" class="form-control" id="proj_no"
							name="proj_no" value="${project.proj_no }">
						<div style="display: flex;"></div>
						<div>
						<c:if test="${work.isemergency == 'Y'}">
							<img id="eimg"
								src="<%=request.getContextPath() %>/resources/images/alert.png"
								alt="긴급">
						</c:if>
						</div>
					</div>
					<div class="date" style="display: flex;">
							<div class="startDate">기간 ${work.work_start_date }</div> <div style="margin:0 5px 0 5px;">~</div>
							<div class="Deadline" style="color: red;">${work.work_deadline }</div> 
					</div>
					<div>
						<div class="mb-3">
							<label for="work_progress" class="col-form-label">진행률</label>
							<div style="display: flex;">
								<div class="progress">
									<div class="state"></div>
								</div>
								<input id="work_progress" name="work_progress" placeholder="${work.work_progress }" readonly>%
							</div>
						</div>
					</div>
					<div class="mb-3">
						<label for="work_file" class="col-form-label">첨부파일</label>
					</div>
					<div class="mb-3">
						<textarea class="form-control" id="content"
							placeholder="${work.work_content }" style="width:fit-content;" readonly></textarea>
					</div>
				</form>
			</div>
					</div>
		</div>
</c:forEach>
</c:if>
</body>
</html>