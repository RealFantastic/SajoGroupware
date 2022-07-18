<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원근태내역 수정</title>

<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>

<!-- J쿼리 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script><!-- 돋보기 -->

<!-- 주달력 -->
<script	src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/js/bootstrap-datepicker.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<!-- 	날짜 보기 편한 CDN : moment -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css">

<!-- 하이차트 -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<!-- CSS적용 -->
<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/commute.css" rel="stylesheet">

<!-- JSTree -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/mayoJstree.js"></script><!-- 정환 조직도js -->

</head>
<body>

	<jsp:include page="/WEB-INF/views/template_header.jsp" />
	<jsp:include page="/WEB-INF/views/template_left.jsp" />


	<div class="left_bar_exception">

		<div class="commute_title font4">직원근태내역 수정</div>

		<div class="my_pe">
			<div class="my_info font1">
				　<br>
					<div class="font2">　 ＜직원 인적사항＞　<br><br></div>

				　　사원번호 : ${commuteStaffInfo.emp_no}　　<br><br>
				　　사원명 : ${commuteStaffInfo.emp_name }　　<br><br>
				　　직함 : ${commuteStaffInfo.job_nm }　　<br><br> 
				　　부서명 : ${commuteStaffInfo.dept_nm }　　<br><br> 
				　　☎ : ${commuteStaffInfo.phone }<br><br>
			</div>
		</div>


		<div class="chart_week">
			<div>
				<!-- 		그래프자리 -->
				<div class="chart_chart">
					<figure class="highcharts-figure">
						<div id="container"></div>
					</figure>

					<div id="chart_nodata" style="display: none;">조회된 데이터가 없습니다.　　　　　　　</div>
				</div>
				<script>
				
				function createChart(week_rate, mod_rate, week_time, mod_time){
					Highcharts.chart('container', {
						chart: {
							type: 'pie',
							renderTo: 'halfPie',
// 							plotBackgroundColor: null,
// 							plotBorderWidth: 0,// 백그라운드 선
// 							plotShadow: false,
// 							width:10%, 
// 							margin: 0,
					
						},
						credits: {
							//하단URL삭제
							enabled: false
						},
						title: {
							text: '주간 그래프',
							align: 'center',
							verticalAlign: 'middle',
							x: 0,// 가로 
							y: 70// 세로 
						},
						tooltip: {
							pointFormat: '<b>{point.custom.extraInformation}</b>'
						},
						accessibility: {
							point: {
								valueSuffix: '%'
							}
						},
						plotOptions: {
							pie: {
								dataLabels: {
									enabled: true,
									distance: -50,
									style: {
										fontWeight: 'bold',
										color: 'white',
										fontSize:'15px',
									}
								},
								startAngle: -90,
								endAngle: 90,
								center: ['50%', '70%'],// 그래프사이즈 중요 : 좌측 가려지는%,위에 보여지는%
								size: '130%'
							}
						},
						 series: [{
							type: 'pie',
							innerSize: '30%',
							data: [
							{	y: Number(week_rate) ,
								custom: {
									extraInformation: week_time
								},
								name : '▶주 누적 근무시간',
								color : '#f2b84b'
							},
							{	y: Number(mod_rate) ,
								custom: {
									extraInformation: mod_time
								},
								name : '▶주 남은 근무시간',
								color :'#6bbf98'
							},
							],
						}]
					});
				}
				</script>
			</div>

			<div class="week_box">
				<!-- 주간달력자리 -->
				<div class="container">
					<!-- 					<div class="jumbotron"> -->
					<div class="row week-selector">
						<div class="col-md-8">
							<div class="form-group clearfix">
								<div class="week_title font3">
									<label class="control-label pull-left" for="weekpicker">
										근태 주간날짜 조회 </label>
								</div>
								<div class="col-sm-8">
									<span class="icon-block ">
										<input type="text" class="form-control" id="weekpicker"> 
									</span>	
									<span class="icon-date">
										<input type="hidden" id="start_dt">
										<input type="hidden" id="end_dt">
										<input type="hidden" id="empNo" value="${empNo}">
									</span>
									<div class="week-controls">
										<button id="prevWeek" class="prev-week btn_gray">이전 주</button>
										<button id="nextWeek" class="next-week btn_gray">다음 주</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 					</div> -->
				</div>
				<script type="text/javascript">
					var startDate;
					var endDate;
					
					$('#weekpicker').datepicker({
						autoclose: true,
						format :'mm/dd/yyyy',
						forceParse :false,
						
						
					}).on("changeDate", function(e) {
						//console.log(e.date);
						var date = e.date;
						startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay());
						endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay()+6);
						//$('#weekpicker').datepicker("setDate", startDate);
						$('#weekpicker').datepicker('update', startDate);
						$('#weekpicker').val(moment(startDate).format('YYYY/MM/DD') +' - ' + moment(endDate).format('YYYY/MM/DD'));// moment로 변경함
						
						$("#start_dt").val(moment(startDate).format('YYYYMMDD') );
						$("#end_dt").val(moment(endDate).format('YYYYMMDD') );

						// list 조회 함수 호출 
						selectCommuteList();
					});
					
					//new
					$('#prevWeek').click(function(e){
						var date = $('#weekpicker').datepicker('getDate');
						//dateFormat = "mm/dd/yy"; //$.datepicker._defaults.dateFormat;
						startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay()- 7);
						endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() - 1);
						$('#weekpicker').datepicker("setDate", new Date(startDate));
						$('#weekpicker').val(moment(startDate).format('YYYY/MM/DD') +' - ' + moment(endDate).format('YYYY/MM/DD'));// moment로 변경함
						
						$("#start_dt").val(moment(startDate).format('YYYYMMDD') );
						$("#end_dt").val(moment(endDate).format('YYYYMMDD') );
						
						return false;
					});
					
					$('#nextWeek').click(function(){
						var date = $('#weekpicker').datepicker('getDate');
						//dateFormat = "mm/dd/yy"; // $.datepicker._defaults.dateFormat;
						startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay()+ 7);
						endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + 13);
						$('#weekpicker').datepicker("setDate", new Date(startDate));
						$('#weekpicker').val(moment(startDate).format('YYYY/MM/DD') +' - ' + moment(endDate).format('YYYY/MM/DD'));// moment로 변경함
						
						$("#start_dt").val(moment(startDate).format('YYYYMMDD') );
						$("#end_dt").val(moment(endDate).format('YYYYMMDD') );
						
						return false;
					});
					
					
					var date =new Date();
					startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay());
					endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay()+6);
					$('#weekpicker').datepicker("setDate", new Date(startDate));
					$('#weekpicker').val(moment(startDate).format('YYYY/MM/DD') +' - ' + moment(endDate).format('YYYY/MM/DD'));// moment로 변경함
					$("#start_dt").val(moment(startDate).format('YYYYMMDD') );
					$("#end_dt").val(moment(endDate).format('YYYYMMDD') );
					selectCommuteList();
					
					// list 조회
					function selectCommuteList() {
						$.ajax({
							type:"post"
							,url:"<%=request.getContextPath()%>/commute/selectEmpCommuteList",
									data : {
										start_dt : $("#start_dt").val(),
										end_dt : $("#end_dt").val(),
										empNo : $("#empNo").val()
									},
									dataType : "json",
									success : function(result) {

										//테이블 초기화
										$('.commute_table > tbody').empty();
										// 								result=JSON.parse(result);
										var list = result.commuteList;

										if (list.length > 0) {
											var str = "";
											list
													.forEach(function(item) {
														str += "<tr class='commute_table_tr' onclick=\"showModal(\'"+item.wokr_day+"\',\'"+item.start_time+"\',\'"+item.end_time+"\')\">"
														str += "<td class='commute_table_list_td'>"
																+ item.wokr_day
																+ "</td>";
														str += "<td class='commute_table_list_td'>"
																+ item.start_time
																+ "</td>";
														str += "<td class='commute_table_list_td'>"
																+ item.end_time
																+ "</td>";
														str += "<td class='commute_table_list_td'>"
																+ item.oneday_work
																+ "</td>";
														str += "<td class='commute_table_list_td'>"
																+ item.week_work
																+ "</td>";
														str += "<td class='commute_table_list_td'>"
																+ item.week_work_mod
																+ "</td>";
														str += "</tr>";

													})

										} else {
											str += "<tr>"
											str += "<td colspan='6' class='commute_table_list_td'>조회된 근태내용이 없습니다.</td>";
											str += "</tr>";
										}
										$('.commute_table > tbody').append(str);
										console.log(list.length);
										if (result.chartData != null
												&& result.chartData != "") {
											$("#chart_nodata").hide();
											var chatData = result.chartData;
											var chart = $('#container')
													.highcharts();
											if (chart) {
												chart.destroy();
											}
											createChart(chatData.week_rate,
													chatData.mod_rate,
													chatData.week_work,
													chatData.week_work_mod)
										} else {
											var chart = $('#container')
													.highcharts();
											if (chart) {
												chart.destroy();
											}

											$("#chart_nodata").show();
										}

									},
									error : function() {
										alert("ajax 제대로 동작 못했다. 문제를 찾아라");
									}
								});
					}
		
		
		
					// 	근태리스트 클릭시 모달창 보여짐
					function showModal(day, start, end){
						//	클릭한 리스트 내용(일자, 출,퇴근시간) 보여짐
						$('#modal_day').val(day)
						$('#modal_start_time').val(start.replaceAll(" ", "").substr(0, 5))
						$('#modal_end_time').val(end.replaceAll(" ", "").substr(0, 5))
						
						$('#Modal').modal('show');
						
						
						// 	모달 취소버튼 클릭 시 
						$(".modalclose").on("click", function() {
							$('#Modal').modal('hide');
						});
						
					}
					
					$(function(){
						// 모달 수정버튼 클릭 시
						$("#changemodal").on("click", function(){
							$.ajax({
								type:"post"
								,url:"<%=request.getContextPath()%>/commute/change"
								,data:{
									empNo:$('#empNo').val(),
									modal_day:$('#modal_day').val(),
									modal_start_time:$('#modal_start_time').val(),
									modal_end_time:$('#modal_end_time').val()
								}
								,dataType:"text"
								,success : function(result) {
									if (result == 'success'){
										alert ("수정되었습니다.");
										$('#Modal').modal('hide');
										//리로드
										location.reload();
									}else{
										alert("수정실패했습니다.")
									}
								}
							})
	
						});
					})
				</script>
			</div>
		</div>


<!-- 인사팀만 보여지는 버튼 -->
				<c:if test="${sessionScope.loginSsInfo.dept_no eq 10}">
					<div class="personnel_button">
						<button type="button"
							onclick="location.href='<%=request.getContextPath()%>/commute/empCommuteList'"
							class="btn btn-secondary btn_red" id="personnel">직원별 근태
							리스트 보기</button>
					</div>
				</c:if>


		<div class="table_all">
			<table class="commute_table">
				<colgroup>
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="20%">
					<col width="20%">
				</colgroup>
				<thead>
					<tr class="commute_table_tr">
						<th class="commute_table_th font2">근무일</th>
						<th class="commute_table_th font2">출근 시간</th>
						<th class="commute_table_th font2">퇴근 시간</th>
						<th class="commute_table_th font2">일 근무 시간</th>
						<th class="commute_table_th font2">주 누적 근무시간</th>
						<th class="commute_table_th font2">주 남은 근무시간</th>
					</tr>
				</thead>

				<tbody>
					<c:if test="${fn:length(commuteMystatus) == 0}">
						<tr class="no_list">
							<!-- 	보여질 내역이 없을 경우 -->
							<td colspan='6'>조회된 근태내용이 없습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="commute" items="${commuteMystatus}">
						<tr class="commute_table_tr">
							<td class="commute_table_list_td">${commute.wokr_day }</td>
							<td class="commute_table_list_td">${commute.start_time }</td>
							<td class="commute_table_list_td">${commute.end_time }</td>
							<td class="commute_table_list_td">${commute.oneday_work }</td>
							<td class="commute_table_list_td">${commute.week_work }</td>
							<td class="commute_table_list_td">${commute.week_work_mod }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>


			<!-- 모달창 -->
			<div class="modal fade" id="Modal" tabindex="-1" role="dialog"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">직원 근태 수정하기 </h5>
						</div>
						<form >
							<div class="modal-body">
								<div class="form-group">
									<label for="taskId" class="col-form-label">선택한 근무일자</label>
									<input type="text" class="form-control" id="modal_day" name="modal_day" readonly>
									
									<label for="taskId" class="col-form-label">출근 시간</label>
									<input type="time" class="form-control" id="modal_start_time" name="modal_start_time">
									
									<label for="taskId" class="col-form-label">퇴근 시간</label>
									<input type="time" class="form-control" id="modal_end_time" name="modal_end_time">
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-warning btn_yellow" id="changemodal">수정하기</button>
								<button type="button" class="btn btn-secondary btn_gray modalclose" data-dismiss="modal" id="sprintSettingModalClose">취소하기</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>