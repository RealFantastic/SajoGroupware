<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>업무관리 메인 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/projectmain.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
<!-- JSTree -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/mayoJstree.js"></script>
</head>
<body>
<script>
	var msg = "${msg}";
	if(msg){
		alert(msg);
	}
</script>
<jsp:include page="/WEB-INF/views/template_header.jsp"/>
 
<div id="body">
 
<aside id="side">
	<div id="insertProj">
	<button id="newProj" class="btn_green" data-bs-toggle="modal" data-bs-target="#newProject">새 프로젝트</button>
	</div>
</aside>

<!--  새 프로젝트 추가 모달창 -->
<div class="modal fade" id="newProject" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">새 프로젝트</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
        <form action="<%=request.getContextPath()%>/project/insert" method="POST">
      <div class="modal-body">
        <div>
        	<select name="proj_type" class="form-select" aria-label="Default select example">
			  <option selected>종류</option>
			  <option value="1">업무</option>
			  <option value="2">동호회</option>
			  <option value="3">정보공유</option>
			  <option value="0">기타</option>
			</select>
        </div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">프로젝트명</label>
            <input type="text" class="form-control" id="title" name="proj_name" required="required">
          </div>
          <div class="mb-3">
            <label for="message-text" class="col-form-label">설명</label>
            <textarea class="form-control" id="content" name="proj_content"></textarea>
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
$("#submitP").click(function(){
	
	location.href="<%=request.getContextPath()%>/project/insert";
	
// 	$.ajax(){
// 		type: "POST",
<%-- 		url: "<%=request.getContextPath()%>/project/insert", --%>
// 		data: { 
// 				proj_name: $("#title").val(),
// 				proj_content: $("#content").val()
// 				},
// 		success: function(result){
// 			if(result){
// 				console.log(result);
// 			}
// 		}
		
// 	}
});

</script>

<div id="container">
<!--  전체 프로젝트 리스트 -->
<div id="projList">
<div class="font4">전체 프로젝트</div>
<div>
	<table class="table tabletext">
		<tr class="font2" style="background-color:rgb(242, 184, 75);">
			<td>번호</td>
			<td>프로젝트명</td>
			<td>종류</td>
<!-- 			<td></td> -->
		</tr>
	<c:forEach var="project" items="${project }">
		<tr class="font1">
			<td>${project.proj_no }</td>
			<td><a href="<%=request.getContextPath()%>/project/select?proj_no=${project.proj_no}">${project.proj_name }</a></td> <!-- 프로젝트 페이지로 이동 -->
			<td>
			<c:if test="${not empty project.proj_type }">
			<c:choose>
			<c:when test="${project.proj_type eq '1'}">업무</c:when>
			<c:when test="${project.proj_type eq '2'}">동호회</c:when>
			<c:when test="${project.proj_type eq '3'}">정보공유</c:when>
			<c:otherwise>기타</c:otherwise>
			</c:choose>
			</c:if>
			</td>
<!-- 			<td><button class="btn_gray btn_detail" style="margin-right:20px;">수정</button> <button class="btn_red btn_detail">삭제</button><td> -->
		<tr>
	</c:forEach>
	</table>
</div>
</div>

<!--  전체 업무 리스트 -->
<div id="worklist">
<div class="font4">전체 업무</div>
<div>
	<table class="table tabletext">
		<tr class="font2" style="background-color:rgb(242, 184, 75);">
			<td>번호</td>
			<td>상태</td>
			<td>긴급</td>
			<td>업무명</td>
			<td>프로젝트명</td>
			<td>기간</td>
		</tr>
	<c:forEach var="work" items="${work }">
		<tr class="font1">
			<td>${work.work_no }</td>
			<td>
			<c:if test="${not empty work.work_status }">
			<c:choose>
			<c:when test="${work.work_status eq '0'}"><div class="btn_green status">요청</div></c:when>
			<c:when test="${work.work_status eq '1'}"><div class="btn_yellow status">진행</div></c:when>
			<c:when test="${work.work_status eq '2'}"><div class="btn_gray status">완료</div></c:when>
			<c:when test="${work.work_status eq '3'}"><div class="btn_red status">보류</div></c:when>
			</c:choose>
			</c:if>
			</td>
			<td>
			<c:if test="${work.isemergency=='Y'}">
				<img id="alert" src="<%=request.getContextPath() %>/resources/images/alert.png" alt="긴급">
			</c:if>
			</td>
			<td>${work.work_title }</td>
			<td>${work.proj_name }</td>
			<td style="display:flex; justify-content:center;">
				<div style="margin-right:5px;">${work.work_start_date }</div> - <div style="margin-left:5px; color:red;">${work.work_deadline }</div></td>
		<tr>
	</c:forEach>
	</table>
</div>
</div>

</div>

</div>

</body>
</html>