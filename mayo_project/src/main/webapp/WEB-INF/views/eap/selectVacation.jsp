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
			<c:if test="${not empty myDraft }">
				<h1>${myDraft.form_title }</h1>
			</c:if>
			<c:if test="${not empty detail }">
				<h1>${detail.form_title }</h1>
			</c:if>
		</div>
		<div class="content_page">
			<div class="toolBar_container">
				<div class="toolBar">
					<c:choose>
						<c:when test="${not empty myDraft }">
							<c:if test="${myDraft.result_code eq 0}">
								<form action="<%= request.getContextPath()%>/eap/delete" method="POST">
									<input type="hidden" name="ea_no" value="${myDraft.ea_no }">					
									<input type="hidden" name="form_code" value="${myDraft.form_code }">					
									<button type="submit" class="btn_tool btn_recall btn_gray">결재 회수</button>
								</form>
							</c:if>
						</c:when>
						<c:when test="${not empty detail }">
							<form action="<%= request.getContextPath()%>/eap/delete" method="POST">
								<input type="hidden" name="ea_no" value="${detail.ea_no }">					
								<input type="hidden" name="form_code" value="${detail.form_code }">					
								<button type="submit" class="btn_tool btn_appr btn_gray">승인</button>
							</form>
						</c:when>
					</c:choose>
					<c:if test="${not empty myDraft }">
						<button type="button" class="btn_tool btn_reDraft btn_green">재기안</button>					
					</c:if>
					<c:if test="${not empty detail }">
						<button type="button" class="btn_tool btn_reject btn_green">반려</button>					
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
									<c:if test="${not empty myDraft }">
										<td colspan="2">${myDraft.ea_title }</td>									
									</c:if>
									<c:if test="${not empty detail }">
										<td colspan="2">${detail.ea_title }</td>
									</c:if>
								</tr>
								<tr>
									<td>
										<table class="approver_info">
											<tr>
												<td class="td_color_gray">기안자</td>
												<c:if test="${not empty myDraft }">
													<td>${myDraft.first_name }</td>									
												</c:if>
												<c:if test="${not empty detail }">
													<td>${detail.first_name }</td>	
												</c:if>
											</tr>
											<tr>
												<td class="td_color_gray">기안부서</td>
												<c:if test="${not empty myDraft }">
													<td>${myDraft.dept_name }</td>
												</c:if>
												<c:if test="${not empty detail }">
													<td>${detail.dept_name }</td>	
												</c:if>
											</tr>
											<tr>
												<td class="td_color_gray">기안일</td>
												<c:if test="${not empty myDraft }">
													<td><fmt:formatDate value="${myDraft.draft_date }" pattern="yyyy-MM-dd"/></td>
												</c:if>
												<c:if test="${not empty detail }">
													<td><fmt:formatDate value="${detail.draft_date }" pattern="yyyy-MM-dd"/></td>	
												</c:if>
												
											</tr>
											<tr>
												<td class="td_color_gray">문서번호</td>
												<c:if test="${not empty myDraft }">
													<td>${myDraft.ea_no }</td>
												</c:if>
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
												<c:when test="${not empty myDraft }">
													<c:if test="${not empty myDraft.first_approver }">
														<span class="sign_member_wrapper">
															<span class="sign_member">
																<span class="sign_rank">
																	<span class="rank">${myDraft.first_job_name }</span>
																</span>
																<span class="sign_wrapper">
																	<span class="sign_name">${myDraft.first_name }</span>
																</span>
																<span class="sign_date_wrapper">
																	<span class="sign_date"></span>
																</span>
															</span>
														</span>
													</c:if>
													<c:if test="${not empty myDraft.second_approver }">
														<span class="sign_member_wrapper">
															<span class="sign_member">
																<span class="sign_rank">
																	<span class="rank">${myDraft.second_job_name }</span>
																</span>
																<span class="sign_wrapper">
																	<span class="sign_name">${myDraft.second_name }</span>
																</span>
																<span class="sign_date_wrapper">
																	<span class="sign_date"></span>
																</span>
															</span>
														</span>
													</c:if>
													<c:if test="${not empty myDraft.third_approver }">
														<span class="sign_member_wrapper">
															<span class="sign_member">
																<span class="sign_rank">
																	<span class="rank">${myDraft.third_job_name }</span>
																</span>
																<span class="sign_wrapper">
																	<span class="sign_name">${myDraft.third_name }</span>
																</span>
																<span class="sign_date_wrapper">
																	<span class="sign_date"></span>
																</span>
															</span>
														</span>
													</c:if>
													<c:if test="${not empty myDraft.final_approver }">
														<span class="sign_member_wrapper">
															<span class="sign_member">
																<span class="sign_rank">
																	<span class="rank">${myDraft.final_job_name }</span>
																</span>
																<span class="sign_wrapper">
																	<span class="sign_name">${myDraft.final_name }</span>
																</span>
																<span class="sign_date_wrapper">
																	<span class="sign_date"></span>
																</span>
															</span>
														</span>
													</c:if>
												</c:when>
												<c:when test="${not empty detail }">
													<c:if test="${not empty detail.first_approver }">
														<span class="sign_member_wrapper">
															<span class="sign_member">
																<span class="sign_rank">
																	<span class="rank">${detail.first_job_name }</span>
																</span>
																<span class="sign_wrapper">
																	<span class="sign_name">${detail.first_name }</span>
																</span>
																<span class="sign_date_wrapper">
																	<span class="sign_date"></span>
																</span>
															</span>
														</span>
													</c:if>
													<c:if test="${not empty detail.second_approver }">
														<span class="sign_member_wrapper">
															<span class="sign_member">
																<span class="sign_rank">
																	<span class="rank">${detail.second_job_name }</span>
																</span>
																<span class="sign_wrapper">
																	<span class="sign_name">${detail.second_name }</span>
																</span>
																<span class="sign_date_wrapper">
																	<span class="sign_date"></span>
																</span>
															</span>
														</span>
													</c:if>
													<c:if test="${not empty detail.third_approver }">
														<span class="sign_member_wrapper">
															<span class="sign_member">
																<span class="sign_rank">
																	<span class="rank">${detail.third_job_name }</span>
																</span>
																<span class="sign_wrapper">
																	<span class="sign_name">${detail.third_name }</span>
																</span>
																<span class="sign_date_wrapper">
																	<span class="sign_date"></span>
																</span>
															</span>
														</span>
													</c:if>
													<c:if test="${not empty detail.final_approver }">
														<span class="sign_member_wrapper">
															<span class="sign_member">
																<span class="sign_rank">
																	<span class="rank">${detail.final_job_name }</span>
																</span>
																<span class="sign_wrapper">
																	<span class="sign_name">${detail.final_name }</span>
																</span>
																<span class="sign_date_wrapper">
																	<span class="sign_date"></span>
																</span>
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
									<input type="text" id="left_count" name="left_count" readonly value="0">
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
	<div class="modal fade approval_list" id="approval_list_modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
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
									<c:when test="${not empty myDraft}">
										<c:if test="${not empty myDraft.first_approver }">
											<tr>
												<td class="app_order">1</td>
												<td class="emp_no">${myDraft.first_approver}</td>
												<td class="approver">${myDraft.first_name }</td>
												<td class="job_name">${myDraft.first_job_name }</td>
											</tr>
										</c:if>
										<c:if test="${not empty myDraft.second_approver }">
											<tr>
												<td class="app_order">2</td>
												<td class="emp_no">${myDraft.second_approver}</td>
												<td class="approver">${myDraft.second_name }</td>
												<td class="job_name">${myDraft.second_job_name }</td>
											</tr>
										</c:if>
										<c:if test="${not empty myDraft.third_approver }">
											<tr>
												<td class="app_order">3</td>
												<td class="emp_no">${myDraft.third_approver}</td>
												<td class="approver">${myDraft.third_name }</td>
												<td class="job_name">${myDraft.third_job_name }</td>
											</tr>
										</c:if>
										<c:if test="${not empty myDraft.final_approver }">
											<tr>
												<td class="app_order">4</td>
												<td class="emp_no">${myDraft.final_approver}</td>
												<td class="approver">${myDraft.final_name }</td>
												<td class="job_name">${myDraft.final_job_name }</td>
											</tr>
										</c:if>
									</c:when>
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
	<script>
		$(function(){
				/* SummerNote Library */
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
						codeviewIframeFilter:true
				});
				
				orgChart($('#jstree_org_chart'));
				$('#org_chart_search').keyup(function(event){
				    var target = $(event.target);
				    searchJstree(target);
				});
				$('.summernote').summernote('code','${myDraft.ea_content}');
				
		});
	</script>
			
		</div>
	</div>
</body>
</html>