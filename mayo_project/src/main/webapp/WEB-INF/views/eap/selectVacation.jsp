<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 기안 문서함 상세보기</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>

<link href="<%=request.getContextPath() %>/resources/css/all_form.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/elec_approval_main.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/eap_sidebar.css" rel="stylesheet">
<!-- JSTree -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/mayoJstree.js"></script>
<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

</head>
<body>
	<jsp:include page="/WEB-INF/views/template_header.jsp"/>
	<jsp:include page="/WEB-INF/views/eap/eap_sidebar_template.jsp"/>
	<div class="bodyContent">
		<div class="content_top">
			<c:if test="${not empty detail }">
				<h1>${detail.form_title }</h1>
			</c:if>
		</div>
		<div class="content_page">
			<div class="toolBar_container">
				<div class="toolBar">
				<!-- 결재결과가 0(접수) 상태이고, 기안자가 로그인유저일때 결재 회수 -->
					<c:if test="${detail.result_code eq 0 and detail.drafter_id eq loginSsInfo.emp_no}">
					<form action="#" method="POST" id="btn_category">
						<input type="hidden" name="ea_no" value="${detail.ea_no }">					
						<input type="hidden" name="form_code" value="${detail.form_code }">
						<input type="hidden" name="status_code" value="${detail.status_code }">
						<input type="hidden" name="result_code" value="${detail.result_code }">
						<input type="hidden" name="first_approver" value="${detail.first_approver }">
						<input type="hidden" name="second_approver" value="${detail.second_approver }">
						<input type="hidden" name="third_approver" value="${detail.third_approver }">
						<input type="hidden" name="final_approver" value="${detail.final_approver }">
						<button type="button" class="btn_tool btn_recall btn_gray">결재 회수</button>
						<button type="button" class="btn_tool btn_reDraft btn_yellow">재기안</button>
					</form>
							<button type="button" class="btn_tool btn_appr btn_green">승인</button>
							<button type="button" class="btn_tool btn_reject btn_red" data-bs-toggle="modal" data-bs-target="#exampleModal">반려</button>
					</c:if>
					<!-- 결과코드가 2(진행중)이면서 기안자가 로그인 유저가 아닐 때  -->
					<c:if test="${detail.result_code eq 2 and detail.drafter_id ne loginSsInfo.emp_no}">
					<form action="#" method="POST" id="btn_category">
						<input type="hidden" name="ea_no" value="${detail.ea_no }">					
						<input type="hidden" name="form_code" value="${detail.form_code }">
						<input type="hidden" name="status_code" value="${detail.status_code }">
						<input type="hidden" name="result_code" value="${detail.result_code }">
						<input type="hidden" name="first_approver" value="${detail.first_approver }">
						<input type="hidden" name="second_approver" value="${detail.second_approver }">
						<input type="hidden" name="third_approver" value="${detail.third_approver }">
						<input type="hidden" name="final_approver" value="${detail.final_approver }">
					</form>
						<button type="button" class="btn_tool btn_appr btn_green">승인</button>
						<button type="button" class="btn_tool btn_reject btn_red" data-bs-toggle="modal" data-bs-target="#exampleModal">반려</button>		
					</c:if>
					<button type="button" class="btn_tool app_line btn_yellow" 
					data-bs-toggle="modal" data-bs-target="#approval_list_modal">결재 정보</button>
				</div>
			</div>
			<div class="form_container">
				<section class="form_wrapper">
					<div class="approval_form">
						<div class="approval_import">
							<form id="doc_content">
								<table class="ar_table">
									<tbody>
										<tr>
											<c:if test="${not empty detail }">
												<td colspan="2">${detail.form_title }</td>
											</c:if>
										</tr>
										<tr>
											<td>
												<table class="approver_info">
													<tr>
														<td class="td_color_gray">기안자</td>
														<c:if test="${not empty detail }">
															<td>${detail.first_name }</td>	
														</c:if>
													</tr>
													<tr>
														<td class="td_color_gray">기안부서</td>
														<c:if test="${not empty detail }">
															<td>${detail.dept_name }</td>	
														</c:if>
													</tr>
													<tr>
														<td class="td_color_gray">기안일</td>
														<c:if test="${not empty detail }">
															<td><fmt:formatDate value="${detail.draft_date }" pattern="yyyy-MM-dd"/></td>	
														</c:if>
														
													</tr>
													<tr>
														<td class="td_color_gray">문서번호</td>
														<c:if test="${not empty detail }">
															<td>${detail.ea_no }</td>	
														</c:if>
													</tr>
												</table>
											</td>
											<td style="text-align: right">
												<span class="inline_table" data-group-name="승인" >
													<span class="sign_title_wrapper">
														<span class="sign_title">
															<strong>승인</strong>
														</span>
													</span>
													<c:choose>
														<c:when test="${not empty detail }">
															<c:if test="${not empty detail.first_approver }">
																<span class="sign_member_wrapper">
																	<span class="sign_member">
																		<span class="sign_rank">
																			<span class="rank">${detail.first_job_name }</span>
																		</span>
																		<c:choose>
																		<%--결과코드가 4(완료)거나 2(진행)이면 승인 --%>
																			<c:when test="${detail.result_code eq 4 or detail.result_code eq 2 }">
																				<span class="sign_wrapper">
																					<span class="sign_img">승인</span>
																				</span>
																				<span class="sign_date_wrapper">
																					<span class="sign_name">${detail.first_name }</span>
																				</span>
																			</c:when>
																			<c:when test="${detail.result_code eq 1 }">
																				<span class="sign_wrapper">
																					<span class="sign_img">회수</span>
																				</span>
																				<span class="sign_date_wrapper">
																					<span class="sign_name">${detail.first_name }</span>
																				</span>
																			</c:when>
																			<%--결과코드가 3이면서 상태코드 짝수면 승인 --%>
																			<c:when test="${(detail.result_code eq 3) and (detail.status_code mod 2 eq 0)}">
																				<span class="sign_wrapper">
																					<span class="sign_img">승인</span>
																				</span>
																				<span class="sign_date_wrapper">
																					<span class="sign_name">${detail.first_name }</span>
																				</span>
																			</c:when>
																			<%--결과가 3이면서 상태코드 나머지 1이면 1차 반려 --%>
																			<c:when test="${(detail.result_code eq 3) and (detail.status_code mod 2  eq 1)}">
																				<span class="sign_wrapper">
																					<span class="sign_img">반려</span>
																				</span>
																				<span class="sign_date_wrapper">
																					<span class="sign_name">${detail.first_name }</span>
																				</span>
																			</c:when>
																			<%--결과코드 0이면 결재 접수 상태이므로 1차 결재 필요--%>
																			<c:when test="${detail.result_code eq 0 }">
																				<span class="sign_wrapper">
																					<span class="sign_name">${detail.first_name }</span>
																				</span>
																				<span class="sign_date_wrapper">
																					<span class="sign_date"></span>
																				</span>
																			</c:when>
																		</c:choose>
																	</span>
																</span>
															</c:if>
															<c:if test="${not empty detail.second_approver }">
																<span class="sign_member_wrapper">
																	<span class="sign_member">
																		<span class="sign_rank">
																			<span class="rank">${detail.second_job_name }</span>
																		</span>
																		<c:choose>
																		<%--결과코드 4면 승인--%>
																			<c:when test="${detail.result_code eq 4}">
																				<span class="sign_wrapper">
																					<span class="sign_img">승인</span>
																				</span>
																				<span class="sign_date_wrapper">
																					<span class="sign_name">${detail.second_name }</span>
																				</span>
																			</c:when>
																			<%--상태코드 4,12면 승인--%>
																			<c:when test="${ detail.status_code eq 4 or detail.status_code eq 12 or detail.status_code eq 8}">
																				<span class="sign_wrapper">
																					<span class="sign_img">승인</span>
																				</span>
																				<span class="sign_date_wrapper">
																					<span class="sign_name">${detail.second_name }</span>
																				</span>
																			</c:when>
																			<%--상태코드 2,6,14일때--%>
																			<c:when test="${detail.status_code eq 2 or detail.status_code eq 6 or detail.status_code eq 14}">
																				<%--결과코드 3이면 반려--%>
																				<c:if test="${detail.result_code eq 3}">
																					<span class="sign_wrapper">
																						<span class="sign_img">반려</span>
																					</span>
																					<span class="sign_date_wrapper">
																						<span class="sign_name">${detail.second_name }</span>
																					</span>
																				</c:if>
																				<%--결과코드 2이면 결재필요--%>
																				<c:if test="${detail.result_code eq 2 }">
																					<span class="sign_wrapper">
																						<span class="sign_name">${detail.second_name }</span>
																					</span>
																					<span class="sign_date_wrapper">
																						<span class="sign_date"></span>
																					</span>																		
																				</c:if>
																			</c:when>
																			<c:when test="${detail.result_code eq 0 }">
																				<span class="sign_wrapper">
																					<span class="sign_name">${detail.second_name }</span>
																				</span>
																				<span class="sign_date_wrapper">
																					<span class="sign_date"></span>
																				</span>	
																			</c:when>
																		</c:choose>
																	</span>
																</span>
															</c:if>
															<c:if test="${not empty detail.third_approver }">
																<span class="sign_member_wrapper">
																	<span class="sign_member">
																		<span class="sign_rank">
																			<span class="rank">${detail.third_job_name }</span>
																		</span>
																		<c:choose>
																		<%--결과코드 4 또는 상태코드 8이면 승인--%>
																			<c:when test="${detail.result_code eq 4 or detail.status_code eq 8 }">
																				<span class="sign_wrapper">
																					<span class="sign_img">승인</span>
																				</span>
																				<span class="sign_date_wrapper">
																					<span class="sign_name">${detail.third_name }</span>
																				</span>
																			</c:when>
																			<%--상태코드 4 또는 12일 때--%>
																			<c:when test="${detail.status_code eq 4 or detail.status_code eq 12}">
																				<%--결과코드 3이면 반려--%>
																				<c:if test="${detail.result_code eq 3 }">
																					<span class="sign_wrapper">
																						<span class="sign_img">반려</span>
																					</span>
																					<span class="sign_date_wrapper">
																						<span class="sign_name">${detail.third_name }</span>
																					</span>
																				</c:if>
																				<%--결과코드 2이면 결재필요--%>
																				<c:if test="${detail.result_code eq 2 }">
																					<span class="sign_wrapper">
																						<span class="sign_name">${detail.third_name }</span>
																					</span>
																					<span class="sign_date_wrapper">
																						<span class="sign_date"></span>
																					</span>
																				</c:if>
																			</c:when>
																			<c:when test="${detail.result_code eq 0 }">
																				<span class="sign_wrapper">
																					<span class="sign_name">${detail.third_name }</span>
																				</span>
																				<span class="sign_date_wrapper">
																					<span class="sign_date"></span>
																				</span>	
																			</c:when>
																			<c:when test="${detail.status_code eq 2 or detail.status_code eq 6 or detail.status_code eq 14}">
																				<span class="sign_wrapper">
																					<span class="sign_name">${detail.third_name }</span>
																				</span>
																				<span class="sign_date_wrapper">
																					<span class="sign_date"></span>
																				</span>	
																			</c:when>
																			<c:when test="${detail.result_code eq 0 }">
																				<span class="sign_wrapper">
																					<span class="sign_name">${detail.third_name }</span>
																				</span>
																				<span class="sign_date_wrapper">
																					<span class="sign_date"></span>
																				</span>	
																			</c:when>
																		</c:choose>
																	</span>
																</span>
															</c:if>
															<c:if test="${not empty detail.final_approver }">
																<span class="sign_member_wrapper">
																	<span class="sign_member">
																		<span class="sign_rank">
																			<span class="rank">${detail.final_job_name }</span>
																		</span>
																		<c:choose>
																		<%--결과코드 4이면 승인--%>
																			<c:when test="${detail.result_code eq 4 }">
																				<span class="sign_wrapper">
																					<span class="sign_img">승인</span>
																				</span>
																				<span class="sign_date_wrapper">
																					<span class="sign_name">${detail.final_name }</span>
																				</span>
																			</c:when>
																			<%--상태코드 8이면서--%>
																			<c:when test="${detail.status_code eq 8 }">
																				<%--결과코드 3이면 반려--%>
																				<c:if test="${detail.result_code eq 3 }">
																					<span class="sign_wrapper">
																						<span class="sign_img">반려</span>
																					</span>
																					<span class="sign_date_wrapper">
																						<span class="sign_name">${detail.final_name }</span>
																					</span>
																				</c:if>
																				<%--결과코드 2이면 결재필요--%>
																				<c:if test="${detail.result_code eq 2}">
																					<span class="sign_wrapper">
																						<span class="sign_name">${detail.final_name }</span>
																					</span>
																					<span class="sign_date_wrapper">
																						<span class="sign_date"></span>
																					</span>
																				</c:if>
																			</c:when>
																			<c:when test="${detail.result_code eq 0 }">
																				<span class="sign_wrapper">
																					<span class="sign_name">${detail.final_name }</span>
																				</span>
																				<span class="sign_date_wrapper">
																					<span class="sign_date"></span>
																				</span>
																			</c:when>
																		</c:choose>
																	</span>
																</span>
															</c:if>
														</c:when>
													</c:choose>
												</span>
											</td>
										</tr>
									</tbody>
								</table>
								<br>
								<table class="ar_table2">
									<tr>
										<td class="td_color_gray">휴가종류</td>
										<td style="border-bottom:1px solid black;">
											<c:choose>
												<c:when test="${selectHoliday.hd_code eq 'F'}">
													연차
												</c:when>
												<c:when test="${selectHoliday.hd_code eq 'H'}">
													반차
												</c:when>
											</c:choose>
										</td>
									</tr>
									<tr>
										<td class="td_color_gray">기간 및 일시</td>
										<td style="border-bottom:1px solid black;">
											<fmt:formatDate value="${selectHoliday.hd_start }" pattern="yyyy-MM-dd(E)"/> ~ <fmt:formatDate value="${selectHoliday.hd_end }" pattern="yyyy-MM-dd(E)"/>
											<label for="hd_count">사용 일수 : </label>
											<input type="text" readonly name="hd_count" id="hd_count" value="${selectHoliday.hd_count }">
										</td>
									</tr>
									<tr>
										<td class="td_color_gray">반차 여부</td>
										<td style="border-bottom:1px solid black;">
											<c:if test="${selectHoliday.hd_code eq 'H' }">
												<input type="checkbox" id="is_half" name="is_half" checked disabled>					
											</c:if>
											<c:if test="${selectHoliday.hd_code eq 'F' }">
												<input type="checkbox" id="is_half" name="is_half" disabled>
											</c:if>
											<label for="is_half">반차사용</label>
										</td>
									</tr>
									<tr>
										<td class="td_color_gray"> 연차 사용 일수 </td>
										<td style="border-bottom:1px solid black;">
											<label for="left_count">잔여 연차 : </label>
											<input type="text" id="left_count" name="left_count" readonly value="${selectHoliday.left_count }">
											<label for="used_count">신청 연차 : </label>
											<input type="text" id="used_count" name="used_count" readonly value="${selectHoliday.hd_count }">
										</td>
									</tr>
									<tr>
										<td class="td_color_gray">휴가 사유</td>
										<td><textarea id="summernote" name="ea_content" required class="summernote"></textarea></td>
									</tr>
								</table>
							</form>
						</div>
					</div>
				</section>
			</div>
			<!-- Modal -->
			<div class="modal fade approval_list" id="approval_list_modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="org_title">결재 정보</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body" id="org_chart_container">
							<div id="approval_line_container">
								<div id="approval_line">
									<table class="table table-striped list_approval">
									<!-- TODO : 결재선 ID로 결재자 정보(사원명, 직급) 불러오기 -->
										<tr>
											<th scope="col">결재순서</th>
											<th scope="col">사번</th>									
											<th scope="col">결재자</th>
											<th scope="col">직위</th>
										</tr>
										<c:choose>
											<c:when test="${not empty detail}">
												<c:if test="${not empty detail.first_approver }">
													<tr>
														<td class="app_order">1</td>
														<td class="emp_no">${detail.first_approver}</td>
														<td class="approver">${detail.first_name }</td>
														<td class="job_name">${detail.first_job_name }</td>
													</tr>
												</c:if>
												<c:if test="${not empty detail.second_approver }">
													<tr>
														<td class="app_order">2</td>
														<td class="emp_no">${detail.second_approver}</td>
														<td class="approver">${detail.second_name }</td>
														<td class="job_name">${detail.second_job_name }</td>
													</tr>
												</c:if>
												<c:if test="${not empty detail.third_approver }">
													<tr>
														<td class="app_order">3</td>
														<td class="emp_no">${detail.third_approver}</td>
														<td class="approver">${detail.third_name }</td>
														<td class="job_name">${detail.third_job_name }</td>
													</tr>
												</c:if>
												<c:if test="${not empty detail.final_approver }">
													<tr>
														<td class="app_order">4</td>
														<td class="emp_no">${detail.final_approver}</td>
														<td class="approver">${detail.final_name }</td>
														<td class="job_name">${detail.final_job_name }</td>
													</tr>
												</c:if>
											</c:when>
										</c:choose>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="reject_reson_modal" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="reject_reson_modal">반려 사유</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        <form id="reject">
			          <div class="mb-3">
			            <label for="message-text" class="col-form-label">반려 사유를 적어주세요:</label>
			            <textarea class="form-control" name="return_reson" id="return_reson" required="required"></textarea>
			            <input type="hidden" name="ea_no" value="${detail.ea_no }">
			            <input type="hidden" name="form_code" value="${detail.form_code }">
			            <input type="hidden" name="result_code" value="${detail.result_code }">
			            <input type="hidden" name="status_code" value="${detail.status_code }">
			          </div>
			        </form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn_gray" data-bs-dismiss="modal">취소</button>
			        <button type="button" class="btn btn_red reject_submit">반려</button>
			      </div>
			    </div>
			  </div>
			</div>
		</div>
	</div>
	<script>
		$(function(){
				/* SummerNote Library */
				$('.summernote').val("${detail.ea_content}");				
				$('.summernote').summernote({
						toolbar: [
							['style',['bold','italic','underline','clear']],
							['font',['strikethrough','superscript','subscript']],
							['fontsize',['fontsize']],
							['color',['color']],
							['para',['ul','ol','paragraph']],
							['height',['height']]
						],
						height: 300,
						minHeight: 300,
						codeviewFilter: false,
						codeviewIframeFilter:true,
						
				});
				
				orgChart($('#jstree_org_chart'));
				$('#org_chart_search').keyup(function(event){
				    var target = $(event.target);
				    searchJstree(target);
				});
				$('.btn_tool').click(function(){
					console.log($(this));
					var form = $('#btn_category');
					if($(this).hasClass('btn_recall')){
						//회수 버튼 클릭인 경우
						form.attr('action','<%=request.getContextPath()%>/eap/update/recall');
						form.attr('method','post');
						form.submit();
					}else if($(this).hasClass('btn_reDraft')){
						//재기안 버튼 클릭인 경우
						alert("서비스 준비중...");
<%-- 						form.attr('action','<%=request.getContextPath()%>/eap/update/redraft'); --%>
// 						form.attr('method','post');
// 						form.submit();
					}else if($(this).hasClass('btn_appr')){
						//승인 버튼 클릭인 경우
						var answer = window.confirm("승인하시겠습니까?");
						if(answer){
							var url = '<%=request.getContextPath()%>/eap/update/appr';
							var type = 'POST';
							var thisInfo = $('#btn_category').serialize();
							console.log(thisInfo);
							$.ajax({
								type:type,
								url:url,
								data:thisInfo,
								success:function(result){
									console.log(result);
									if(result == "complete"){
										alert("승인하였습니다.");
									}else{
										alert("승인 중 실패했습니다. 다시 시도하세요");
									}
									location.href="<%=request.getContextPath()%>/eap/main";
								},
								error:function(error){
									alert("서버연결에 실패했습니다. " + error);
								}
							});
						}else{
							alert("승인을 취소합니다");
							return;
						}
					}else{
						return;
					}
				});
				
				$('.reject_submit').click(function(){
					var rejectInfo = $('#reject').serialize();
					console.log(rejectInfo);
					if(return_reson == "" || return_reson == null){
						alert("반려사유를 반드시 입력해주세요.");
						return;
					}else{
						$.ajax({
							type:'POST',
							url: '<%=request.getContextPath()%>/eap/update/reject',
							data:rejectInfo,
							success:function(result){
								console.log(result);
								if(result == "fail"){
									alert("실패했습니다.");
								}else{
									alert("반려했습니다.");
									location.href='<%=request.getContextPath()%>/eap/main';
								}
							},
							error:function(error){
								alert("서버 연결에 실패했습니다. 사유 : " + error);
							}
						});
					}
				});
				
		});
	</script>
</body>
</html>