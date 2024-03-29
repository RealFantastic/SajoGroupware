<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>업무 수정 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/updateWork.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/ef09f998fc.js"></script>
<!-- JSTree -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/mayoJstree.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/template_header.jsp"/>

	<div id="body" style="padding-top:150px;">
		
<!-- 업무 수정 -->
<div class="modal-lg" id="updateWork">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="font3 ftitle" style="margin-left:40px;">업무 수정하기</h5>
      </div>
        <form name="updateWork">
      <div class="modal-body insidebody">
      <input type="hidden"  id="proj_no" name="work_no" value="${work.work_no }">
      <input type="hidden"	id="proj_no" name="proj_no" value="${work.proj_no }">
      <input type="hidden"  id="work_mgr" name="work_mgr" value="${work.work_mgr }">
        <div style="display:flex;">
        <div style="margin-right: 15px;">
        	<select id="select" name="work_status" class="form-select" aria-label="Default select example" required="required">
			  <option value="0">요청</option>
			  <option value="1">진행</option>
			  <option value="2">완료</option>
			  <option value="3">보류</option>
			</select>
        </div>
           <div>
			 <input class="isemergency" name="isemergency" value="N" type="hidden">
            <button type="button" id="isemergency">
	            <c:choose>
	            	<c:when test="${work.isemergency == 'Y' }">
	            		<img id="eimg" src="<%=request.getContextPath() %>/resources/images/alert.png" alt="긴급">
	            	</c:when>
	            	<c:otherwise>
	            		<img id="eimg" src="<%=request.getContextPath() %>/resources/images/blackalert.png" alt="긴급">
	            	</c:otherwise>
	            </c:choose>
            </button>
        </div>
          </div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label font2">제목</label>
            <input type="text" class="form-control" id="title" name="work_title" value="${work.work_title }" required="required">
          </div>
          <div class="date" style="display:flex;">
          	<div class="mb-3" style="margin-right:13px;">
            	<label for="recipient-name" class="col-form-label">시작일</label>
            	<input type="Date" class="form-control" id="work_start_date" name="work_start_date" value="${work.work_start_date}">
          	</div>
          	<div class="mb-3">
            	<label for="recipient-name" class="col-form-label" style="color:red;">마감일</label>
            	<input type="Date" class="form-control" id="work_deadline" name="work_deadline" value="${work.work_deadline}">
          	</div>
          </div>
	    <div class="mb-3">
        	<label for="work_progress" class="col-form-label">진행률</label>
			<input type="range" id="progress" value="${work.work_progress }" min="0" max="100" step="10">
			<input type="text" id="percentage" name="work_progress" readonly>%
		</div>
          <div class="mb-3">
            <label for="message-text" class="col-form-label font2">내용</label>
            <textarea class="form-control" id="content" name="work_content" required style="height:200px;">${work.work_content }</textarea>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn_gray" id="cancel" style="margin-right:10px;">뒤로가기</button>
        <button id="submit" type="button" class="btn_green">수정</button>
      </div>
        </form>
    </div>
  </div>
</div>

</div>

<script>

$('#anyModal').on('hidden.bs.modal', function () {
	  // something
	});
	
	var emp = ${loginSsInfo.emp_no};
	var workMgr = ${work.work_mgr};
	console.log("로그인"+emp);
	console.log("작성자"+workMgr);
	
	if(emp != workMgr){ // 작성자가 아니면 상태만 변경 가능
		$('input[name=work_title]').attr('readonly' , true);
		$('input[name=work_start_date]').attr('readonly' , true);
		$('input[name=work_deadline]').attr('readonly' , true);
		$('textarea[name=work_content]').attr('readonly' , true);
		$('#isemergency').attr('disabled', true); // 버튼 비활성화 안 됨
	};

	// 취소 버튼 누르면 뒤로가기
	$("#cancel").click(function(){
		history.go(-1);
	});

//긴급 버튼
$("#eimg").click(function(){
	
	if(emp != workMgr){
		return;
	};
	
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

// selected 설정하기
var status = "${work.work_status}";

$("#select").val(status).prop("selected", true);

	// 업무 글 수정하기
	$("#submit").click(function(){
	
		var sdate = $("#work_start_date").val();
		var edate = $("#work_deadline").val();
		
		if($("#title").val() == ""){
			alert("업무명을 입력해주세요");
			$("#work_title").focus();
			return false;
		}
		
		if(sdate > edate) {
			alert("마감일은 시작일보다 빠를 수 없습니다");
			$("#work_deadline").focus();
			return false;
		}
		
		if($("#content").val() == ""){
			alert("내용을 입력해주세요");
			$("#content").focus();
			return false;
		}
		
		var work = $("form[name=updateWork]").serialize();
		
			// ajax로 컨트롤러 이동 
			$.ajax({
				type: "POST",
				url: "<%=request.getContextPath()%>/work/update",
				data: work,
				success: function(result){
					alert(result);
					history.go(-1);
				}
			});
	});
	

// 프로그래스 바 값 가져오기
var slider = document.getElementById("progress");
var output = document.getElementById("percentage");
output.value = slider.value;

slider.oninput = function() {
  document.getElementById("percentage").value = this.value;
}

</script>

</body>
</html>