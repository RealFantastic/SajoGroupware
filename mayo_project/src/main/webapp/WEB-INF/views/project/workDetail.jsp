<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<c:choose>
<c:when test="${not empty work }">
	<c:forEach var="work" items="${work}">
		<div class="reloadBody">
			<div class='modal-lg workBody'>
				<div class='modal-dialog'>
					<div class='modal-content'>
						<div class='modal-header'>
							<div style="display: block;">
								<div> 업무번호 ${work.work_no }</div>
								<h5 class='modal-title font3 work_title'
									style='font-weight: bold;'>${work.work_title }</h5>
							</div>
								<div style="display:flex;">
									<form action="<%=request.getContextPath() %>/work/toUpdate" method="POST">
										<input type="hidden" name="work_no" value="${work.work_no }">
										<button type='submit' class='btn_gray btn-modify wUpdate'>수정</button>
									</form>
									<button type='button' class='btn_red btn-delete deleteW'>삭제</button>
								</div>
						</div>
						<div class="modal-body">
							<input type="hidden" class="form-control" name="proj_no" value="${project.proj_no }">
							<div class="writer" style="display: flex;">
								<div class="mgr" style="margin-right: 10px;">${work.emp_name }</div>
								<div class="date" style="color:gray;">
									<fmt:formatDate pattern="yyyy-MM-dd" value="${work.work_date }" />
								</div>
							</div>
							<div style="display: flex; margin:13px 0 13px 0;">
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
									<img class="dimg"
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
								<label for="work_progress" class="col-form-label">진행률 <input type="text" class="dpercentage dper" name="work_progress" placeholder="${work.work_progress }" readonly/>%</label> 
								<div class="progress" style="height: 15px;">
								  <div class="progress-bar bg-warning" role="progressbar" style="width: ${work.work_progress }%;" aria-valuenow="${work.work_progress }" aria-valuemin="0" aria-valuemax="100"></div>
								</div>
							</div>
						</div>
					<div class="mb-3">
						<i class="fa-solid fa-paperclip"></i> 
						<c:if test="${!empty work.projfilelist}">
 						<c:forEach var="file" items="${work.projfilelist }">                                             
							<div>${file.proj_original_filename}</div>                                
						</c:forEach>
 						</c:if>
					</div>
					<div class="mb-3">
						<textarea class="form-control readContent" readonly>${work.work_content }</textarea>
					</div>
					<button type="button" class="btn_comment">댓글</button>
					<div class="mb-3 commentArea">
						<div class="insertArea">
							<form name="newComment" class="newComment">
								<input type="hidden" name="work_no" value="${work.work_no }">
								<textarea rows="1" class="form-control comment" name="c_content"></textarea>
								<button type="button" class="btn_yellow insertComment">등록</button>
							</form>
						</div>
						<div class="viewComment"></div>
					</div>
				  </div>
				</div>
			</div>
		</div>
	</c:forEach>
</c:when>
	<c:otherwise>
		<div class="nothing font2">
		작성된 업무가 없습니다.
		</div>
	</c:otherwise>
</c:choose>

<script>
	// 댓글 버튼 누르면 영역 보이기
	$(".btn_comment").click(function(){
		$(this).next(".commentArea").toggle();
	});


 		// 업무 글 삭제하기
			$(".deleteW").click(function(event){ 
				
			console.log($(event.target).prev().children('input').val());
				
			//삭제 여부 확인하기
			var check = confirm("업무를 삭제하시겠습니까?");
			var work_no = $(event.target).prev().children('input').val();

			
			if(check){
				// ajax로 컨트롤러 이동 - delete
				$.ajax({
					type:"POST",
					url: "<%=request.getContextPath()%>/work/delete",
					data : {
							work_no: work_no,
							},
				 // 업무 번호 들고가기
				success : function(result) {
					alert(result);
					location.reload();
				}
			});
			} else {
			return false;
			}
		});
 		
	 		// 댓글 작성하기
			$(".insertComment").click(function(event){ 
				
			var comment = $("form[name=newComment]").serialize();
			
			console.log($(event.target).prev('input').val());
				
				// ajax로 컨트롤러 이동 - insert
				$.ajax({
					type:"POST",
					url: "<%=request.getContextPath()%>/comment/insert",
					data : comment,
				 // 업무 번호 들고가기
				success : function(result) {
					alert(result);
					location.reload();
				}
			});

		});

// 	// 진행률 변경하기
// 	$(".dprogress").click(function() {
// 		console.log($(this).val());
// 		var slider = $(this).val();
// 		var outputOrigin = $(this).next().val();
// 		var outputChange = slider;

// 		// 			output.value = slider.value;
// 		console.log(slider);
// 		console.log(outputOrigin);
// 		console.log(outputChange);

// 		// 			// 프로그래스 바 값 가져오기
// 		// 			slider.oninput = function() {
// 		// 			document.getElementsByClassName("dpercentage").value = this.value;
// 		// 			}

// // 		var result = confirm("진행률을 변경하겠습니까?");
// // 		if (!result) {
// // 			$(this).next().val(outputOrigin);
// // 			slider = outputOrigin;
// // 		} else {
// 			$(this).next().val(outputChange);
// 			confirm("진행률이 변경되었습니다.");
// // 		}

// 	});

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
