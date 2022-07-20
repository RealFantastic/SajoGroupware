<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="now" value="<%= new java.util.Date() %>"/>
<c:set var="today"><fmt:formatDate value="${now }" pattern="yyyy-MM-dd"/></c:set>
<c:set var="year"><fmt:formatDate value="${now }" pattern="yyyy"/></c:set>
	<div class="toolBar_container">
		<div class="toolBar">
			<button type="button" class="btn_tool draftAR btn_green">결재 요청</button>
			<button type="button" class="btn_tool cancel btn_red">취소</button>
			<button type="button" class="btn_tool app_line btn_yellow" 
			data-bs-toggle="modal" data-bs-target="#approval_list_modal">결재선 지정</button>
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
									<td colspan="2">
										<input type="hidden" value="연차신청서" name="ea_title">
										연차신청서
										<input type="hidden" value="AR" name="form_code">
									</td>
								</tr>
								<tr>
									<td>
										<table class="approver_info">
											<tr>
												<td class="td_color_gray">기안자</td>
												<td>${loginSsInfo.emp_name }<input type="hidden" name="emp_no" value="${loginSsInfo.emp_no }"></td>
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
												<td>-------</td>
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
								<td class="td_color_gray">휴가종류</td>
								<td style="border-bottom:1px solid black;">
									<select name="holiday_type">
										<option value="F">연차</option>
										<option value="H">반차</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="td_color_gray">기간 및 일시</td>
								<td style="border-bottom:1px solid black;">
									<input type="date" required id="start_date" name="hd_start"> ~ <input type="date" required id="end_date" name="hd_end">
									<label for="hd_count">사용 일자 : </label>
									<input type="text" readonly name="hd_count" id="hd_count">
									<span class="overAlert">사용일수 초과</span>
								</td>
							</tr>
							<tr>
								<td class="td_color_gray">반차 여부</td>
								<td style="border-bottom:1px solid black;">
									<input type="checkbox" id="is_half" name="is_half">
									<label for="is_half">반차사용</label>
									<input type="hidden" name="hd_code" value="F">
									<span id="select_time_radio">
										<label for="start_am">시작일</label>
										(
										<input type="radio" name="startHalf" id="start_am" value="오전" disabled><span>오전</span>
										<input type="radio" name="startHalf" id="start_pm" value="오후" disabled><span>오후</span>
										)
										<label for="end_am">종료일</label>
										(
										<input type="radio" name="endHalf" id="end_am" value="오전" disabled><span>오전</span>
										<input type="radio" name="endHalf" id="end_pm" value="오후" disabled><span>오후</span>
										)
									</span>
								</td>
							</tr>
							<tr>
								<td class="td_color_gray"> 연차 사용 일수 </td>
								<td style="border-bottom:1px solid black;">
									<label for="left_count">잔여 연차 : </label>
									<input type="text" id="left_count" name="left_count" readonly>
									<label for="used_count">신청 연차 : </label>
									<input type="text" id="used_count" name="used_count" readonly>
								</td>
							</tr>
							<tr>
								<td class="td_color_gray">휴가 사유</td>
								<td><textarea id="summernote" name="ea_content" required class="summernote"></textarea></td>
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
	<div class="modal fade approval_list" id="approval_list_modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="org_title">결재선 지정</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body" id="org_chart_container">
					<div id="org_chart">
						<input type="text" id="org_chart_search">
						<div id="jstree_org_chart">
						</div>
					</div>
					<div id="approval_line_container">
						<div id="approval_line">
							<table class="table table-striped list_approval">
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
				$('input[type=date]').change(function(e){
					console.log(e.target.value);
					/* 오늘 날짜 */
					var today = new Date();
					/* 선택한 날짜 */
					var targetVal = e.target.value;
					var target = new Date(targetVal);
					/* 선택 날짜의 시간과 현재 시간 동일하게 변경 (정확한 비교를 위해서) */
					target.setHours(today.getHours());
					target.setMinutes(today.getMinutes());
					target.setSeconds(today.getSeconds());
					target.setMilliseconds(today.getMilliseconds());
					
					console.log(today);
					console.log(target);
					
					if(target < today){
						/* 선택된 날짜가 오늘 이전인 경우 선택 X */
						alert("오늘 이후부터 선택 가능합니다");
						e.target.value = null;
						return;
					}else if(target.getDay() == 0 || target.getDay() == 6){
						/* 선택된 날짜가 주말일 경우 선택 X */
						alert("주말은 휴가가 불가합니다.");
						e.target.value = null;
						return;
					}
					
					/* 사용자 입력값 변수 생성 */
					var startValue = $('#start_date').val();
					var endValue = $('#end_date').val();
					/* 휴가일수 초기값=0 */
					var holiday = 0;
					
					if(startValue != "" && endValue !=""){
						console.log('둘다 값 들어있더라');
						 holiday = calcHoliday();
					}
					
					$('#hd_count').val(holiday); //사용 일수 표시
					$('#used_count').val(holiday); //신청 연차 표시
					
				});
				
				function calcHoliday(){
					var start = $('#start_date').val().split('-');
					var end = $('#end_date').val().split('-');
					/* 사용자 선택 날짜 Date 타입 변수 생성 */
					hd_start = new Date(start[0],start[1]-1,start[2]);
					hd_end = new Date(end[0],end[1]-1,end[2]);
					
					console.log(hd_start);
					console.log(hd_end);
					
					/* 휴가일수 초기값 */
					var count = 0;
					
					while(true){
						var tmp_date = hd_start;
						var diffDate = hd_end.getTime() - tmp_date.getTime();
						if(tmp_date.getTime() > hd_end.getTime()){ //루프 종료 조건 2
							console.log("count : " + count);
							return count;									
						}else{
							var tmp = tmp_date.getDay();
							if(tmp == 0 || tmp == 6){
								/* 0:일요일, 6:토요일 일경우 주말이므로 카운트 X */
								console.log("주말");
							}else{
								/* 나머지 평일 */
								console.log("평일");
								count++;
							}
							/* tmp_date를 1씩 올려가면서 반복 */
							tmp_date.setDate(hd_start.getDate() + 1);
						}
					}
				}
				/* 반차사용 클릭  */
				$("#is_half").click(function(){
					$('input[name=hd_code]').val('H');
					/* 신청된 연차 개수 변수 생성 */
					var hd_count = $("#hd_count").val();
					
					if($(this).prop("checked")){
						if($('#start_date').val() =="" || $('#end_date').val()==""){
							alert('날짜를 먼저 설정하세요');
							$(this).prop("checked",false);
							return;
						}
						console.log("체크상태");
						
						if(hd_count == 1){
							$('input[name=startHalf]').removeAttr("disabled");
						}else if(hd_count > 1){
							$('input[name=startHalf]').eq(1).removeAttr("disabled");
							$('input[name=endHalf]').eq(0).removeAttr("disabled");
						}
					}else{
						console.log("언체크상태");
						$('input[name=hd_code]').val('F');
						var holiday = calcHoliday();
						$('input[name=startHalf]').prop('checked',false);
						$('input[name=endHalf]').prop('checked',false);
						$('input[name=startHalf]').attr("disabled","disabled");
						$('input[name=endHalf]').attr("disabled","disabled");
						$('#hd_count').val(holiday); //사용 일수 표시
						$('#used_count').val(holiday); //신청 연차 표시
					}
				});
				$('input[type=radio]').click(function(event){
					event.stopPropagation();
					console.log(event.target);
					console.log(event);
					const checkCount = $('input[type=radio]:checked').length;
					const eventCntStart = 0;
					const eventCntEnd = 0;
					var holidayCount = $("#hd_count").val();
					
					
					holidayCount = holidayCount - 0.5;
					//TODO 한번 클릭한 name에는 두번 발동하지 않게 수정.
					
					
					$('#hd_count').val(holidayCount); //사용 일수 표시
					$('#used_count').val(holidayCount); //신청 연차 표시
				});
				
				/* SummerNote Library */
				$('#summernote').summernote({
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
				
				$('#jstree_org_chart').bind('select_node.jstree',function(event,data){
					var emp_no = data.instance.get_node(data.selected).id;
					console.log(emp_no);
					var currOrder = $('.list_approval tr:last-child').find('td:eq(0)').text();
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
									return ;
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
							$('.list_approval tbody').append(html);
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
					let line_no = $('.list_approval tr:first-child').nextAll().length;
					
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
				$('.draftAR').click(function(){
					if($(".summernote").summernote('isEmpty')){
						alert('휴가 사유를 입력해야 합니다.');
						return;
					}else if($('#start_date').val()=="" || $('#end_date').val()==""){
						alert('날짜를 입력해야 합니다.');
						return;
					}
					let formData = $('#doc_content').serialize();
					formData = decodeURIComponent(formData);
					console.log(formData);
					$.ajax({
						type:'POST',
						url:'<%=request.getContextPath()%>/eap/insert/ar',
						data:formData,
						success:function(result){
							if(result ="complete"){
								alert("상신했습니다.");
							}else{
								alert("상신에 실패했습니다.");
							}
							location.replace="<%=request.getContextPath()%>/eap/main";
							
						},
						error:function(xhr,status,error){
							alert("에러났다");
						}
						
					});
				});
		});
		
	</script>