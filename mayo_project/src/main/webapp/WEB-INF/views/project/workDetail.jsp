<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<c:choose>
<c:when test="${not empty work }">
	<c:forEach var="work" items="${work}">
		<div id="reloadBody">
			<div id="workBody" class='modal-lg'>
				<div class='modal-dialog'>
					<div class='modal-content'>
						<div class='modal-header'>
							<div style="display: block;">
								<div>${work.work_no }</div>
								<h5 class='modal-title font3 work_title'
									style='font-weight: bold;'>${work.work_title }</h5>
							</div>
								<div>
									<form action="<%=request.getContextPath() %>/work/toUpdate" method="POST">
										<input id="work_no" type="hidden" value="${work.work_no }">
										<button type='submit' id="wUpdate" class='btn_gray btn-modify'>수정</button>
									</form>
									<button type='button' id="wDelete" class='btn_red btn-delete'>삭제</button>
								</div>
						</div>
						<div class="modal-body">
							<input type="hidden" class="form-control" id="proj_no"
								name="proj_no" value="${project.proj_no }">
							<div class="writer" style="display: flex;">
								<div class="mgr" style="margin-right: 10px;">${work.emp_name }</div>
								<div class="date">
									<fmt:formatDate pattern="yyyy-MM-dd" value="${work.work_date }" />
								</div>
							</div>
							<div style="display: flex;">
								<div>
									<c:if test="${not empty work.work_status }">
										<c:choose>
											<c:when test="${work.work_status eq '0'}">
												<div class="btn_green statusD">요청</div>
											</c:when>
											<c:when test="${work.work_status eq '1'}">
												<div class="btn_yellow statusD">진행</div>
											</c:when>
											<c:when test="${work.work_status eq '2'}">
												<div class="btn_gray statusD">완료</div>
											</c:when>
											<c:when test="${work.work_status eq '3'}">
												<div class="btn_red statusD">보류</div>
											</c:when>
										</c:choose>
									</c:if>
								</div>
								<c:if test="${work.isemergency == 'Y'}">
									<img id="dimg"
										src="<%=request.getContextPath()%>/resources/images/alert.png"
										alt="긴급">
								</c:if>
							</div>
						</div>
						<div class="date" style="display: flex;">
							<div class="startDate"><i class="fa-regular fa-calendar"></i> ${work.work_start_date }</div>
							<div style="margin: 0 5px 0 5px;">~</div>
							<div class="Deadline" style="color: red;">${work.work_deadline }</div>
						</div>
						<div>
							<div class="mb-3">
								<label for="work_progress" class="col-form-label">진행률</label> <input
									type="range" id="dprogress" class="dprogress"
									value="${work.work_progress }" min="0" max="100" step="10">
								<input type="text" id="dpercentage" class="dpercentage"
									name="work_progress" placeholder="${work.work_progress }"
									readonly />%
							</div>
						</div>
					</div>
					<div class="mb-3">
						<label for="work_file" class="col-form-label"><img
							id="clip"
							src="<%=request.getContextPath()%>/resources/images/clip.png"
							alt="첨부파일"></label>  
<%--  						<c:forEach var="file" items="${work.projfilelist }">                                              --%>
<%-- 							<li>${file.original_filename}<a href="#" class="filedown" sfolder="${file.saveFolder}" sfile="${file.saveFile}" ofile="${file.original_filename}">[다운로드]</a> <img src="${root}/resources/upload/${file.saveFolder}/${file.saveFile}">                                         --%>
<%-- 					</c:forEach> --%>
					</div>
					<div class="mb-3">
						<textarea class="form-control" id="content"
							placeholder="${work.work_content }" readonly></textarea>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
</c:when>
	<c:otherwise>
		<div class="nothing font2">
		작성된 업무 또는 일정이 없습니다.
		</div>
	</c:otherwise>
</c:choose>

<script>

   //file download    
$('.filedown').click(function() {        
	alert("원본 :  " + $(this).attr('ofile') + "      실제 :  " + $(this).attr('sfile'));        
	$(document).find('[name="sfolder"]').val($(this).attr('sfolder'));        
	$(document).find('[name="ofile"]').val($(this).attr('ofile'));        
	$(document).find('[name="sfile"]').val($(this).attr('sfile'));        
	$('#downform').attr('action', '${root}/article/download').attr('method', 'get').submit();    });

// progress bar 색상 채우기
	$('input[type="range"]').on("change mousemove", function () {
	    var val = ($(this).val() - $(this).attr('min')) / ($(this).attr('max') - $(this).attr('min'));

	    $(this).css('background-image',
	                '-webkit-gradient(linear, left top, right top, '
	                + 'color-stop(' + val + ', rgb(107, 191, 152)), '
	                + 'color-stop(' + val + ', #d3d3db)'
	                + ')'
	                );
	});

		
 		// 업무 글 삭제하기
		$("#wDelete").click(function(){
			
			//삭제 여부 확인하기
			var check = confirm("업무를 삭제하시겠습니까?");
			
			if(check){
				// ajax로 컨트롤러 이동 - delete
				$.ajax({
					type:"POST",
					url: "<%=request.getContextPath()%>/work/delete",
				data : {
					work_no : $("#work_no").val()
				}, // 업무 번호 들고가기
				success : function(result) {
					alert(result);
// 					$("#reloadBody").load(location.href + " #reloadBody"); // 영역 reload
					location.reload();
				}
			});
		} else {
			return false;
		}
	});

	// 진행률 변경하기
	$(".dprogress").click(function() {
		console.log($(this).val());
		var slider = $(this).val();
		var outputOrigin = $(this).next().val();
		var outputChange = slider;

		// 			output.value = slider.value;
		console.log(slider);
		console.log(outputOrigin);
		console.log(outputChange);

		// 			// 프로그래스 바 값 가져오기
		// 			slider.oninput = function() {
		// 			document.getElementsByClassName("dpercentage").value = this.value;
		// 			}

		var result = confirm("진행률을 변경하겠습니까?");
		if (!result) {
			$(this).next().val(outputOrigin);
			slider = outputOrigin;
		} else {
			$(this).next().val(outputChange);
		}

	});

	var sliderd = document.getElementsByClassName('dprogress');
	console.log(sliderd);
	for (var i = 0; i < sliderd.length; i++) {
		sliderd[i].oninput = function() {
			console.log(this);
			var current = this;
			/* TODO : this의 아래 형제 찾아서 값 변경 되도록 해야함*/
		}

	}
</script>
