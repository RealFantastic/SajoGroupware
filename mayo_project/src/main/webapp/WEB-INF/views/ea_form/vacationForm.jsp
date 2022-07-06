<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div class="toolBar_container">
		<div class="toolBar">
			<button type="button" class="btn_tool draft btn_green">결재 요청</button>
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
									<td colspan="2">연차신청서</td>
								</tr>
								<tr>
									<td>
										<table class="approver_info">
											<tr>
												<td class="td_color_gray">기안자</td>
												<td>박정환</td>
											</tr>
											<tr>
												<td class="td_color_gray">기안부서</td>
												<td>인사팀</td>
											</tr>
											<tr>
												<td class="td_color_gray">기안일</td>
												<td>2022-06-22</td>
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
														<span class="rank">사원</span>
													</span>
													<span class="sign_wrapper">
														<span class="sign_name">박정환</span>
													</span>
													<span class="sign_date_wrapper">
														<span class="sign_date"></span>
													</span>
												</span>
											</span>
											<span class="sign_member_wrapper">
												<span class="sign_member">
													<span class="sign_rank">
														<span class="rank">사원</span>
													</span>
													<span class="sign_wrapper">
														<span class="sign_name">박정환</span>
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
									<input type="date" id="start_date" name="hd_start"> ~ <input type="date" id="end_date" name="hd_end">
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
									<span id="select_time_radio">
										<label for="start_am">시작일</label>
										(
										<input type="radio" name="startHalf" id="start_am" value="오전" disabled><span for="am">오전</span>
										<input type="radio" name="startHalf" id="start_pm" value="오후" disabled><span for="pm">오후</span>
										)
										<label for="end_am">종료일</label>
										(
										<input type="radio" name="endHalf" id="end_am" value="오전" disabled><span for="am">오전</span>
										<input type="radio" name="endHalf" id="end_pm" value="오후" disabled><span for="pm">오후</span>
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
								<td><textarea id="summernote" name="summernote" class="summernote"></textarea></td>
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
	<div class="modal fade" id="approval_list_modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="org_title">조직도</h5>
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
							<table class="table table-striped">
								<tr>
									<th scope="col">결재순서</th>
									<th scope="col">결재자</th>
									<th scope="col">부서</th>
									<th scope="col">직위</th>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					
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
				$("#is_half").click(function(){
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
						]
				});
							
				orgChart($('#jstree_org_chart'));
				$('#org_chart_search').keyup(function(event){
				    var target = $(event.target);
				    searchJstree(target);
				});
		});
	</script>