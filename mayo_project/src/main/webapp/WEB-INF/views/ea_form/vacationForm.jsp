<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div class="toolBar_container">
		<div class="toolBar">
			<button type="button" class="btn_tool draft btn_green">결재 요청</button>
			<button type="button" class="btn_tool cancel btn_red">취소</button>
			<button type="button" class="btn_tool cancel btn_yellow">결재선 지정</button>
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
										<input type="radio" name="startHalf" id="start_am" value="오전" disabled><label for="am">오전</label>
										<input type="radio" name="startHalf" id="start_pm" value="오후" disabled><label for="pm">오후</label>
										)
										<label for="end_am">종료일</label>
										(
										<input type="radio" name="endHalf" id="end_am" value="오전" disabled><label for="am">오전</label>
										<input type="radio" name="endHalf" id="end_pm" value="오후" disabled><label for="pm">오후</label>
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
			<script>
				$(function(){
						
					
						$('#end_date').change(function(){
							/* 사용자 입력값 변수 생성 */
							var start = $('#start_date').val().split('-');
							var end = $('#end_date').val().split('-');
// 							console.log("start = " + start);
// 							console.log("startType = " + typeof start);
// 							console.log("end = " + end);
// 							console.log("endType = " + typeof end);
							/* 입력값(String) => Date로 변경 */
							var hd_start = new Date(start[0],start[1],start[2]);
							var hd_end = new Date(end[0],end[1],end[2]);
// 							console.log(hd_start);
// 							console.log(hd_end);
							/* 두 날짜 차이 계산 */
							let hd_countDate = hd_end - hd_start;
							let currDay = 24*60*60*1000; //시 * 분 * 초 * 밀리세컨
							
							/* 날짜 차이 일수로 변경 */
							hd_count = parseInt(hd_countDate/currDay);
// 							if(hd_count ==0){
// 								hd_count = 1;	
// 							}
// 							console.log("두 날짜 일수 차이 : " + hd_count);
							if(hd_count > $('#left_count').val()){
								$('.overAlert').text("사용일수 초과");
							}
							$('#hd_count').val(hd_count); //사용 일수 표시
							$('#used_count').val(hd_count); //신청 연차 표시
							
						});
						/* TODO : 반차체크된 경우 신청 연차가 0이면 0.5씩 계산,
						체크가 해제되면 다시 1씩 계산되어 값이 바뀌도록 해야함 */
						$("#is_half").click(function(){
							if($(this).prop("checked")){
								if($('#start_date').val() =="" || $('#end_date').val()==""){
									alert('날짜를 먼저 설정하세요');
									$(this).prop("checked",false);
									return;
								}
								console.log("체크상태");
								if(hd_count == 0){
									$('input[name=startHalf]').removeAttr("disabled");
								}else{
									$('input[name=startHalf]').removeAttr("disabled");
									$('input[name=endHalf]').removeAttr("disabled");
								}
							}else{
								console.log("언체크상태");
								$('input[name=startHalf]').attr("disabled","disabled");
								$('input[name=endHalf]').attr("disabled","disabled");
								$('#hd_count').val(hd_count); //사용 일수 표시
								$('#used_count').val(hd_count); //신청 연차 표시
							}
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
					
				});
				
				
			</script>
		</section>
	</div>
