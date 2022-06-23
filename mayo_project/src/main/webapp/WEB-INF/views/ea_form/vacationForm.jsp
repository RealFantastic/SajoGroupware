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
									<div id="select_time_radio">
										<input type="radio" name="selectTime" id="am" value="오전"><label for="am">오전</label>
										<input type="radio" name="selectTime" id="pm" value="오후"><label for="pm">오후</label>
									</div>
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
					
						
						console.log('${selectForm}');
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
