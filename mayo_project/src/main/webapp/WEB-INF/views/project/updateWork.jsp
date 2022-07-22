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
<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
<!-- JSTree -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/mayoJstree.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/template_header.jsp"/>

	<div id="body">
		
<!-- 업무 수정 -->
<div class="modal-lg" id="updateWork">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="font3 ftitle" style="margin-left:40px;">업무 수정하기</h5>
      </div>
        <form name="updateWork" enctype="multipart/form-data">
      <div class="modal-body insidebody">
      <input type="hidden" class="form-control" id="proj_no" name="proj_no" value="${work.proj_no }">
      <input type="hidden" class="form-control" id="work_mgr" name="work_mgr" value="${work.work_mgr }">
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
            <button type="button" id="isemergency"><img id="eimg" src="<%=request.getContextPath() %>/resources/images/blackalert.png" alt="긴급"></button>
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
        	<label for="work_file" class="col-form-label">첨부파일</label><button type="button" id="addFile" class="btn_yellow">추가</button>
        	<div style="display:flex;">
        		<input type="file" name="uploadfile" class="file"><i class="fa-solid fa-trash-can"></i>
        	</div>
        	<div id="files"></div>
        </div>
          <div class="mb-3">
            <label for="message-text" class="col-form-label font2">내용</label>
            <textarea class="form-control" id="content" name="work_content" required="required" style="height:200px;">${work.work_content }</textarea>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn_gray" id="cancel">취소</button>
        <button id="submit" type="submit" class="btn_green">수정</button>
      </div>
        </form>
    </div>
  </div>
</div>

</div>

<script>
// 취소 버튼 누르면 뒤로가기
$("#cancel").click(function(){
	window.history.back();
});

// selected 설정하기
var status = "${work.work_status}";

$("#select").val(status).prop("selected", true);

	// 업무 글 수정하기
	$("#submit").click(function(){
	
		var work = $("form[name=updateWork]").serialize();
		
			// ajax로 컨트롤러 이동 
			$.ajax({
				type: "POST",
				url: "<%=request.getContextPath()%>/work/update",
				data: work,
				success: function(result){
					alert(result);
					location.reload();
				}
			});
	});
	
	
//다중 파일 업로드 예제
	var fileCnt = 1;
	$("#addFile").click(function(){
		fileCnt++;
		var html= "<div style='display:flex;'><input type='file' name='uploadfile'><i class='fa-solid fa-trash-can'></i><div>";
		$("#files").append(html);
	});

// 긴급 버튼
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


// 프로그래스 바 값 가져오기
var slider = document.getElementById("progress");
var output = document.getElementById("percentage");
output.value = slider.value;

slider.oninput = function() {
  document.getElementById("percentage").value = this.value;
}

//progress bar 색상 채우기
$('input[type="range"]').on("change mousemove", function () {
    var val = ($(this).val() - $(this).attr('min')) / ($(this).attr('max') - $(this).attr('min'));

    $(this).css('background-image',
                '-webkit-gradient(linear, left top, right top, '
                + 'color-stop(' + val + ', rgb(107, 191, 152)), '
                + 'color-stop(' + val + ', #d3d3db)'
                + ')'
                );
});
</script>

</body>
</html>