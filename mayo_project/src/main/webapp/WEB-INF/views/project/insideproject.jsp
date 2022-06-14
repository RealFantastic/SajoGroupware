<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/resources/css/insideproj.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/views/template_header.jsp"/>

	<aside id="side">
		<div id="side-content">
			<button class="btn_yellow">프로젝트 정보</button>
			<button id="insertWork" class="btn_green" data-bs-toggle="modal" data-bs-target="#newWork">업무 추가</button>
			<button id="insertSch" class="btn_yellow">일정 추가</button>
		</div>
	</aside>

	<div id="body">
		<!-- 프로젝트 정보 -->
		<div class="font4 proj">
			<div>${project.proj_name } </div>
			
<!-- 			<div>  수정 삭제 버튼--> 
<!-- 				<button class="btn_gray btn_detail">수정</button> -->
<!-- 				<button class="btn_red btn_detail">삭제</button> -->
<!-- 			</div> -->
		</div>
				
		
		<!--  새 업무 추가 모달창 -->
<div class="modal fade" id="newWork" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">새 업무</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
        <form action="<%=request.getContextPath()%>/work/insert" method="POST">
      <div class="modal-body">
      <input type="hidden" class="form-control" id="proj_no" name="proj_no" value="${project.proj_no }">
        <div>
        	<select name="work_status" class="form-select" aria-label="Default select example">
			  <option selected>상태</option>
			  <option value="0">요청</option>
			  <option value="1">진행</option>
			  <option value="2">완료</option>
			  <option value="3">반려</option>
			</select>
        </div>
          <div class="mb-3">
            <label for="isemergency" class="col-form-label">긴급여부</label>
<!--        TODO -->
          </div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">제목</label>
            <input type="text" class="form-control" id="title" name="work_title" required="required">
          </div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">시작일</label>
            <input type="Date" class="form-control" id="work_start_date" name="work_start_date" required="required">
          </div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">마감일</label>
            <input type="Date" class="form-control" id="work_deadline" name="work_deadline" required="required">
          </div>
	    <div>
        	<label for="work_progress" class="col-form-label">진행률</label>
        	<select name="work_progress" class="form-select" aria-label="Default select example">
			  <option selected>0</option>
			  <option value="100">100</option>
			  <option value="10">10</option>
			  <option value="20">20</option>
			  <option value="30">30</option>
			</select>
        </div>
          <div class="mb-3">
            <label for="message-text" class="col-form-label">내용</label>
            <textarea class="form-control" id="content" name="work_content" placeholder="내용을 입력해주세요"></textarea>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn_gray" data-bs-dismiss="modal">취소</button>
        <button id="submitP" type="submit" class="btn_green">등록</button>
      </div>
        </form>
    </div>
  </div>
</div>
<script>


<%-- $("#submitP").click(function(){
		
	$.ajax(){
 		type: "POST",
		url: "<%=request.getContextPath()%>/work/insert",
		data: { 
				
 				work_title: $("#title").val(),
 				work_content: $("#content").val()
 				},
 		success: function(result){
			if(result){
			console.log(result);
			}
		}
		
 	}
}); --%>
</script>
		
		
	</div>
		
</body>
</html>