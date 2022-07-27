<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="now" value="<%= new java.util.Date() %>"/>
<c:set var="today"><fmt:formatDate value="${now }" pattern="yyyy-MM-dd"/></c:set>
<c:set var="year"><fmt:formatDate value="${now }" pattern="yyyy"/></c:set>
	<div class="toolBar_container">
		<div class="toolBar">
			<button type="button" class="btn_tool draftBP btn_green">결재 요청</button>
			<button type="button" class="btn_tool cancel btn_red">취소</button>
			<button type="button" class="btn_tool app_line btn_yellow" data-bs-toggle="modal" data-bs-target="#approval_list_modal2">결재선 지정</button>
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
									<td colspan="2" class="bpTitle">업무기안</td>
								</tr>
								<tr>
									<td>
										<table class="approver_info">
											<tr>
												<td class="td_color_gray">기안자</td>
												<td>${loginSsInfo.emp_name }</td>
											</tr>
											<tr>
												<td class="td_color_gray">기안부서</td>
												<td>${loginSsInfo.dept_name }</td>
											</tr>
											<tr>
												<td class="td_color_gray">기안일</td>
												<td><c:out value="${today }"/></td>
											</tr>
											<tr>
												<td class="td_color_gray">문서번호</td>
												<td>---------</td>
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
											<span class="sign_member_wrapper">
												<span class="sign_member">
													<span class="sign_rank">
														<span class="rank">${loginSsInfo.job_name }</span>
													</span>
													<span class="sign_wrapper">
														<span class="sign_name">${loginSsInfo.emp_name }</span>
													</span>
													<span class="sign_date_wrapper">
														<span class="sign_date"></span>
													</span>
												</span>
											</span>
										</span>
									</td>
								</tr>
							</tbody>
						</table>
						<br>
						<table class="ar_table2">
							<tr>
								<td class="td_color_gray">시행일자</td>
								<td style="border-bottom:1px solid black;">
									<input type="date" name="start_date">
								</td>
							</tr>
							<tr>
								<td class="td_color_gray">내용</td>
								<td><textarea id="summernote2" name="summernote" class="summernote"></textarea></td>
							</tr>
						</table>
					</form>
				</div>
				<div class="add_file">
					
				</div>
			</div>
		</section>
	</div>
	<!-- Modal -->
	<div class="modal fade approval_list" id="approval_list_modal2" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="org_title">결재선 지정</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body" id="org_chart_container">
					<div id="org_chart">
						<input type="text" id="org_chart_search_bp">
						<div id="jstree_org_chart_bp">
						</div>
					</div>
					<div id="approval_line_container">
						<div id="approval_line">
							<table class="table table-striped list_approval_bp">
								<tr>
									<th scope="col">결재순서</th>
									<th scope="col">사번</th>									
									<th scope="col">결재자</th>
									<th scope="col">부서</th>
									<th scope="col">직위</th>
									<th scope="col"><span class="btn_delete_act_all"><i class="fa-solid fa-trash-can"></i></span></th>
								</tr>
								<tr>
									<td class="app_order">1</td>
									<td class="emp_no">${loginSsInfo.emp_no }</td>
									<td class="approver">${loginSsInfo.emp_name }</td>
									<td class="dept_name">${loginSsInfo.dept_name }</td>
									<td class="job_name">${loginSsInfo.job_name }</td>
									<td><input type="hidden" name="emp_no"/></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary add_appr">적용</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(function(){		
			/* SummerNote Library */
			 $('#summernote2').summernote({
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
			 orgChart($('#jstree_org_chart_bp'));
				$('#org_chart_search_bp').keyup(function(event){
				    var target = $(event.target);
				    searchJstree(target);
				});
				$('#jstree_org_chart_bp').bind('select_node.jstree',function(event,data){
					var emp_no = data.instance.get_node(data.selected).id; //클릭한 사원의 아이디를 가져옴.
					console.log(emp_no);
					var currOrder = $('.list_approval_bp tr:last-child').find('td:eq(0)').text();
					console.log(currOrder);
					if(emp_no.length<=2){
						return;
					}else if(currOrder >= 4){
						alert("결재선 최대 초과");
						return;
					}
					$.ajax({
						url:'<%=request.getContextPath()%>/member/detail',
						type:'post',
						data:{emp_no : emp_no},
						dataType:'json',
						success:function(data){
							var html ='';
							let empNo = null;
							for(var i = 0; i < $('.emp_no').length;i++){
								empNo = $('.emp_no').eq(i).text();
								if(emp_no === empNo){ 
									alert("이미 등록된 결재자입니다.");
									return;
								}
							}
							html += '<tr class="tmp">';
							html +='<td class="app_order">' + (parseInt(currOrder) + 1) + '</td>';
							html +='<td class="emp_no">' + data.emp_no + '</td>';
							html +='<td class="approver">' + data.emp_name + '</td>';
							html +='<td class="dept_name">' + data.dept_name + '</td>';
							html +='<td class="job_name">' + data.job_name + '</td>';
							html += '<td><span class="btn_delete_act"><i class="fa-solid fa-trash-can"></i></span></td>';
							html +='</tr>';
							$('.list_approval_bp tbody').append(html);
						}
					});
				});
				
				$('.btn_delete_act_all').click(function(event){
					console.log($(event.target));
					var target = $(event.target);
					/* 삭제버튼 누르면 1차 결재자 제외 모든 노드 삭제 */
					target.parents('tr').next().nextAll().remove();
					
				});
				$('.list_approval').on('click','[class=btn_delete_act]',function(event){
					console.log($(event.target));
					var target = $(event.target);
						target.parents('tr').remove();
					var downNode = $(target.parents('tr').nextAll());
					console.log(downNode);
					for(var i = 0; i < downNode.length; i++){
						console.log(i + "번째 순서값 = " + downNode.eq(i).children().eq(0).text());
						console.log(parseInt(downNode.eq(i).children().eq(0).text())-1);
						
					}
				});
				
				$('.add_appr').on('click',function(){
					let line_no = $('.list_approval_bp tr:first-child').nextAll().length;
					
					var _html = '';
					for(var i = 1; i<line_no; i++){
						_html += "<span class='sign_member_wrapper'>";
						_html += "	<span class='sign_member'>";	
						_html += "		<span class='sign_rank'>";		
						_html += "			<span class='rank'>"+$('.job_name').eq(i).text()+"</span>";		
						_html += "			<input type='hidden' name='apprvoer_job_name' value='"+ $('.job_name').eq(i).text() +"'/>";		
						_html += "		</span>";
						_html += "		<span class='sign_wrapper'>";
						_html += "			<span class='sign_name'>" + $('.approver').eq(i).text() + "</span>";
						_html += "			<input type='hidden' name='approver_emp_no' value='"+ $('.emp_no').eq(i).text() +"'/>";
						_html += "		</span>";		
						_html += "		<span class='sign_date_wrapper'>";
						_html += "			<span class='sign_date'></span>";
						_html += "		</span>";
						_html += "	</span>";
						_html += "</span>";
					}                   
					$('.sign_member_wrapper').nextAll().remove();
					$('.sign_member_wrapper').after(_html);
					$('.approval_list').modal('hide');
				});
		});
	</script>