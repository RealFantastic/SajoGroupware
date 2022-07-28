<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<c:choose>
	<c:when test="${not empty sked }">
		<c:forEach var="sked" items="${sked}">
			<div class="reloadBody">
				<div id="sked" class="modal-lg workBody">
					<div class="modal-dialog ">
						<div class="modal-content">
							<div class="modal-header">
								<div style="display: block;">
									<div>일정번호 ${sked.sked_no }</div>
									<h5 class="modal-title font3" style='font-weight: bold;'>${sked.sked_name }</h5>
								</div>
								<div style="display: flex;">
									<form action="<%=request.getContextPath()%>/schedule/toUpdate" method="POST">
										<input type="hidden" name="sked_no" value="${sked.sked_no }">
										<button type='submit' class='btn_gray btn-modify sUpdate'>수정</button>
										<input type='hidden' value="${sked.sked_emp_id }"/>
									</form>
									<button type='button' class='btn_red btn-delete deleteS'>삭제</button>
									<input type='hidden' value="${sked.sked_emp_id }"/>
									<input type='hidden' value="${emp_no }"/>
 								</div>
							</div>
							<div class="modal-body">
								<input type="hidden" class="form-control" name="proj_no"
									value="${project.proj_no }">
								<div class="writer" style="display: flex;">
									<div class="mgr" style="margin-right: 10px;">${sked.emp_name}</div>
									<div class="date" style="color: gray;">
										<fmt:formatDate pattern="yyyy-MM-dd"
											value="${sked.sked_date }" />
									</div>
								</div>
								<div class="date" style="display: flex;">
									<div class="mb-3" style="margin-right: 13px;">
										<div class="col-form-label skedStart">
											<i class="fa-regular fa-calendar"></i> ${sked.sked_start_date }
											~
										</div>
									</div>
									<div class="mb-3">
										<div class="col-form-label skedEnd" style="color: red;">
											${sked.sked_end_date }</div>
									</div>
								</div>
								<c:if test="${not empty sked.sked_location}">
									<div class="mb-3">
										<i class="fa-solid fa-location-dot"></i> ${sked.sked_location }
									</div>
								</c:if>
								<div class="mb-3">
									<div class="readContent">${sked.sked_content }</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<div class="nothing font2">작성된 일정이 없습니다.</div>
	</c:otherwise>
</c:choose>

<script>

var emp = ${loginSsInfo.emp_no}; // 로그인 세션 아이디

// TODO 수정하기 버튼 비활성화 

// 일정 글 수정하기
$(".sUpdate").click(function(event){ 
	
var sked_mgr = $(event.target).next('input').val(); // 일정 작성자

console.log($(event.target).prev('input').val());

// 일정 작성자만 수정 가능
if(emp != sked_){
	alert("작성자만 수정할 수 있습니다.");
	return false;
}	
	
var sked_no = $(event.target).next('input').val();

		// ajax로 컨트롤러 이동 - delete
		$.ajax({
			type:"POST",
			url: "<%=request.getContextPath()%>/schedule/toUpdate",
			data : {sked_no: sked_no},
		 // 일정 번호 들고가기
		success : function(result) {
			alert(result);
			location.href = "<%=request.getContextPath()%>/project/insideprojectSked";
			}
		});

});

// 일정 글 삭제하기
$(".deleteS").click(function(event){ 
	
console.log($(event.target).prev().children('input').val());
	
var sked_mgr = $(event.target).next('input').val(); // 일정 작성자

console.log($(event.target).next('input').val());
console.log(${loginSsInfo.emp_no});

// 일정 작성자만 삭제 가능
if(emp != sked_mgr){
	alert("작성자만 삭제할 수 있습니다.");
	return false;
}	
	
//삭제 여부 확인하기
var check = confirm("일정을 삭제하시겠습니까?");
var sked_no = $(event.target).prev().children('input').val();

	if(check){
		// ajax로 컨트롤러 이동 - delete
		$.ajax({
			type:"POST",
			url: "<%=request.getContextPath()%>/schedule/delete",
			data : {sked_no: sked_no},
		 // 일정 번호 들고가기
		success : function(result) {
			alert(result);
			location.reload();
			}
		});
	} else {
		return false;
	}
});

</script>
