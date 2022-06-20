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
			<button class="btn_yellow" data-bs-toggle="modal" data-bs-target="#projInfo">프로젝트 정보</button>
			<button id="insertWork" class="btn_green" data-bs-toggle="modal" data-bs-target="#newWork">업무 추가</button>
			<button id="insertSch" class="btn_yellow">일정 추가</button>
		</div>
	</aside>

	<div id="body">
	
	<!-- 프로젝트 정보 모달창 -->
<div class="modal fade" id="projInfo" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">프로젝트</h5> 
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
        <form name="mProject" action="<%=request.getContextPath()%>/project/modify" method="POST">
      <div class="modal-body">
      	<div style="display: flex;">
      		<div>
	      		<c:if test="${not empty project.proj_type }">
				<c:choose>
				<c:when test="${project.proj_type eq '1'}">업무</c:when>
				<c:when test="${project.proj_type eq '2'}">동호회</c:when>
				<c:when test="${project.proj_type eq '3'}">정보공유</c:when>
				<c:otherwise>기타</c:otherwise>
				</c:choose>
				</c:if> 
      		</div>
				<div style="margin-left:10px;">${project.proj_no }</div>
      	</div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">프로젝트명</label>
            <input type="text" class="form-control" id="title" name="proj_name" value="${project.proj_name }" required="required">
          </div>
          <div class="mb-3">
            <label for="message-text" class="col-form-label">설명</label>
            <textarea class="form-control" id="content" name="proj_content" required> ${project.proj_content } </textarea>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" id="deleteProj" class="btn_red">삭제</button>
        <button id="submitM" type="submit" class="btn_green">수정</button>
        </div>
        </form>
      </div>
    </div>
  </div>
</div>
		<!-- 프로젝트 정보 -->
		<div class="font4 proj">
			<div>${project.proj_name } </div>
<!-- 			<div>  수정 삭제 버튼--> 
<!-- 				<button class="btn_gray btn_detail">수정</button> -->
<!-- 				<button class="btn_red btn_detail">삭제</button> -->
<!-- 			</div> -->
		</div>
		
		<!-- 프로젝트 업무들 -->		
        <div id="worklist">
		</div>
		<!--  새 업무 추가 모달창 -->
<div class="modal fade modal-lg" id="newWork" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title font3" id="exampleModalLabel" style="font-weight:bold;">새 업무</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
        <form name="newWork" action="<%=request.getContextPath()%>/work/insert" method="POST">
      <div class="modal-body">
      <input type="hidden" class="form-control" id="proj_no" name="proj_no" value="${project.proj_no }">
        <div style="display:flex;">
        <div style="margin-right: 15px;">
        	<select name="work_status" class="form-select" aria-label="Default select example" required="required">
			  <option selected>상태</option>
			  <option value="0">요청</option>
			  <option value="1">진행</option>
			  <option value="2">완료</option>
			  <option value="3">반려</option>
			</select>
        </div>
          <div>
			 <input class="isemergency" name="isemergency" type="hidden">
            <button type="button" id="isemergency"><img id="eimg" src="<%=request.getContextPath() %>/resources/images/blackalert.png" alt="긴급"></button>
        </div>
          </div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label font2">제목</label>
            <input type="text" class="form-control" id="title" name="work_title" required="required">
          </div>
          <div class="date" style="display:flex;">
          	<div class="mb-3" style="margin-right:13px;">
            	<label for="recipient-name" class="col-form-label">시작일</label>
            	<input type="Date" class="form-control" id="work_start_date" name="work_start_date">
          	</div>
          	<div class="mb-3">
            	<label for="recipient-name" class="col-form-label" style="color:red;">마감일</label>
            	<input type="Date" class="form-control" id="work_deadline" name="work_deadline">
          	</div>
          </div>
	    <div>
	    	<div class="mb-3">
        	<label for="work_progress" class="col-form-label">진행률</label>
<!--         	<select name="work_progress" class="form-select" aria-label="Default select example"> -->
<!-- 			  <option selected>0</option> -->
<!-- 			  <option value="100">100</option> -->
<!-- 			  <option value="10">10</option> -->
<!-- 			  <option value="20">20</option> -->
<!-- 			  <option value="30">30</option> -->
<!-- 			</select> -->
					<!-- 전체 영역 -->
				<div style="display:flex;">
				<div class="progress">
				  <!-- 프로그래스 바 -->
				  <div class="state"></div>
				</div>
				  <input id="work_progress" name="work_progress" value="" readonly>%
			</div>
				</div>
        </div>
        <div class="mb-3">
        	<label for="work_file" class="col-form-label">첨부파일</label>
        	<input type="file" name="uploadfile" multiple="multiple">
        </div>
          <div class="mb-3">
            <label for="message-text" class="col-form-label font2">내용</label>
            <textarea class="form-control" id="content" name="work_content" placeholder="내용을 입력해주세요" required="required" style="height:300px;"></textarea>
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
// 프로젝트 수정 ajax
$("#submitM").click(function(){
		
	var proj = $("form[name=mProject]").serialize();
	
	$.ajax({
 		type: "POST",
		url: "<%=request.getContextPath()%>/project/update",
		data: { 
 				proj: proj;
 				},
 		success: function(result){
			alert(result);
		}
		
 	});
});

$("#deleteProj").click(function(){
	var proj_no = "${project.proj_no}";
	
	$.ajax({
 		type: "POST",
		url: "<%=request.getContextPath()%>/project/delete",
		data: { 
 				proj_no: proj_no;
 				},
 		success: function(result){
 			console.log("삭제");
			alert(result);
		}
		
 	});
});


// progress bar 
$(document).ready(function(){
	  //프로그래스 바를 클릭
	  $('.progress').click(function(e){
	      // 변수 x는 .progress의 left값에서 클릭한 위치의 X값을 뺀다.
	        // e.pageX는 화면에서 클릭한 X의 위치를 가져온다. 
	        var x = e.pageX - $('.progress').offset().left;
	        //변수 clickPercentage는 변수 x / .progress.너비
	        clickPercentage = x / $('.progress').width();
	        //.state의 너비는 (.progress의 너비에서 변수 clickPercentage를 곱한 값);
	        $('.state').width($('.progress').width() * clickPercentage);

	        var percentage = clickPercentage * 10;
	    	// 10 단위로 나타내기
	        $('#work_progress').val(Math.round(percentage)*10);
	    });
	});
	
// 아이콘 클릭하면 긴급 선택되게 하기
/* $("#isemergency").click(function() {
    var isemergency = $("#isemergency").data('value');    
	    $("#isemergency").closest('input').find(".isemergency").val(isemergency);
}); */

// 버튼 변경 방법 좀 더 찾아보기
$("#eimg").click(function(){
	var eimg = $("#eimg").attr("src");
	
	if(eimg=="<%=request.getContextPath() %>/resources/images/blackalert.png"){
		$("#eimg").attr("src", "<%=request.getContextPath() %>/resources/images/alert.png");	
		$("input[name=isemergency]").val('Y');
		console.log($("input[name=isemergency]").val());
	} else {
		$("#eimg").attr("src", "<%=request.getContextPath() %>/resources/images/blackalert.png");
		$("input[name=isemergency]").val('N');
	}
});

    
// 페이지 load 될 때 업무 가져오기 - 틀 수정 예정
$(function(){
	
	$.ajax({
		type:"GET",
		url: "<%=request.getContextPath()%>/work/select",
		data: {proj_no : '${project.proj_no}'},
 		dataType: 'json',
 		success: function(result){
 			console.log(result);
//  			var html = "";
 			for(var i = 0; i < result.length; i++){
				$("#worklist").load("<%=request.getContextPath()=%>/workDetail.jsp");
  			}
//   			$("#worklist").append(html); 
		}
	});
});


</script>
		
		
		
</body>
</html>