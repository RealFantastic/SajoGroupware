<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<c:choose>
<c:when test="${not empty sked }">
	<c:forEach var="sked" items="${sked}">
<div id="sked" class="modal-lg workBody">
  <div class="modal-dialog ">
    <div class="modal-content skedModal">
      <div class="modal-header">
      <div style="display: block;">
       <div>${sked.sked_no }</div>
        <h5 class="modal-title font3" style='font-weight: bold;'>${sked.sked_name }</h5>
		</div>		
		 <div>
			<form action="<%=request.getContextPath()%>/sked/toUpdate" method="POST">
				<input type="hidden" name="work_no" value="${sked.sked_no }">
				<button type='submit' class='btn_gray btn-modify wUpdate'>수정</button>
			</form>
				<button type='button' class='btn_red btn-delete sked_delete'>삭제</button>
			</div>
		 </div>
      <div class="modal-body">
           <div class="date" style="display:flex;">
          	<div class="mb-3" style="margin-right:13px;">
            	<div class="col-form-label skedStart"><i class="fa-regular fa-calendar"></i> ${sked.sked_start_date }</div>
          	</div>
          	<div class="mb-3">
            	<div class="col-form-label skedEnd" style="color:red;">${sked.sked_end_date }</div>
          	</div>
          </div>
          <div class="mb-3">
          	위치
          	<div class="skedLoca"></div>
			 </div>
          <div class="mb-3">
            <div class="col-form-label skedContent">${sked.sked_content }</div>
          </div>
      </div>
      </div>
	</div>
	</div>
  </c:forEach>
</c:when>
	<c:otherwise>
		<div class="nothing font2">
		작성된 일정이 없습니다.
		</div>
	</c:otherwise>
</c:choose>	
