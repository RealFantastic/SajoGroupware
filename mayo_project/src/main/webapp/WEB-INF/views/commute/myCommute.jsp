<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 근태현황</title>
	<!-- 부트스트랩 -->
	<link 
		rel="stylesheet" 
		href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" 
		integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" 
		crossorigin="anonymous">
	<script 
		src="https://code.jquery.com/jquery-3.5.1.slim.min.js" 
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" 
		crossorigin="anonymous"></script>
	<script 
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" 
		crossorigin="anonymous"></script>
	<!-- J쿼리 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>
	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script> <!-- 돋보기 -->
	<!-- 주달력 -->
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/js/bootstrap-datepicker.min.js"></script>
<!-- 	<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"></script> -->
<!-- 	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/css/bootstrap-datepicker3.css"></script> -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script> <!-- 	날짜 보기 편한 CDN : moment -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css">
	
	<!-- 하이차트 -->
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/accessibility.js"></script>
	
	
<link href="<%=request.getContextPath()%>/resources/css/commute.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet"> 

<!-- JSTree -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/mayoJstree.js"></script>  <!-- 정환조직도js -->


<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">

</head>

<body>

<jsp:include page="/WEB-INF/views/template_header.jsp"/>
<jsp:include page="/WEB-INF/views/template_left.jsp"/>


	<div class="left_bar_exception">
	
		<div class="commute_title font4">나의 근태현황</div>
		
		<div class="chart_week">
			<div>
<!-- 		그래프자리 -->
				<div class="chart_chart">
					<figure class="highcharts-figure">
						<div id="container"></div>
					</figure>
				</div>
				<script>
				Highcharts.chart('container', {
					chart: {
						plotBackgroundColor: null,
						plotBorderWidth: 0,// 백그라운드 선
						plotShadow: false,
// 						width:500 
						margin: 0,
				
					},
					credits: {
						//하단URL삭제
						enabled: false
					},
					title: {
						text: '주간<br>그래프<br>',
						align: 'center',
						verticalAlign: 'middle',
						y: 70
					},
					tooltip: {
						pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
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
									color: 'white'
								}
							},
							startAngle: -90,
							endAngle: 90,
							center: ['50%', '75%'],
							size: '80%'
						}
					},
					series: [{
						type: 'pie',
						name: 'Browser share',
						innerSize: '40%',
						data: [
							['▶ 주 누적 근무시간', 10],
							['▶ 주 남은 근무시간', 85],
							{
								name: 'Other',
								y: 0,
								dataLabels: {
									enabled: false
								}
							}
						]
					}]
				});
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
											근태 주간날짜 조회
										</label>
									</div>
									<div class="col-sm-8">
										<span class="icon-block ">
											<input type="text" class="form-control" id="weekpicker">
											<span class="icon-date"></span>
										</span>
										<input type="hidden" id="start_dt">
										<input type="hidden" id="end_dt">	
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
						// list 조회 함수 호출 
						
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
						// list 조회 함수 호
						return false;
					});
					
					
					var date =new Date();
					startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay());
					endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay()+6);
					$('#weekpicker').val(moment(startDate).format('YYYY/MM/DD') +' - ' + moment(endDate).format('YYYY/MM/DD'));// moment로 변경함
					$("#start_dt").val(moment(startDate).format('YYYYMMDD') );
					$("#end_dt").val(moment(endDate).format('YYYYMMDD') );
					selectCommuteList();
					
					// list 조회
					function selectCommuteList() {
						
						debugger
						$.ajax({
							type:"post"
							,url:"<%=request.getContextPath()%>/commute/selectCommuteList"
							,data:{
								start_dt : $("#start_dt").val()
								, end_dt : $("#end_dt").val()
							}
							,dataType:"json"
							,success:function(result){
//			 					debugger
								//테이블 초기화
								$('.commute_table > tbody').empty();
// 								result=JSON.parse(result);
								if(result.length>=1){
									var str = ""; 
									result.forEach(function(item){
										str +="<tr>"
										str += "<td class='commute_table_list_td'>"+item.wokr_day+"</td>";
										str += "<td class='commute_table_list_td'>"+item.start_time+"</td>";
										str += "<td class='commute_table_list_td'>"+item.end_time+"</td>";
										str += "<td class='commute_table_list_td'>"+item.oneday_work+"</td>";
										str += "<td class='commute_table_list_td'>"+item.week_work+"</td>";
										str += "<td class='commute_table_list_td'>"+item.week_work_mod+"</td>";
										str += "</tr>";
										
									})
								}else{
									str +="<tr>"
									str += "<td colspan='6' class='commute_table_list_td'>조회된 데이터가 없습니다.</td>";
									str += "</tr>";
								}
								$('.commute_table > tbody').append(str);
								console.log(result.length);
							}
							,error:function(){
								alert("ajax 제대로 동작 못했다. 문제를 찾아라");
							}
						});
					}
				</script>
			</div>
		</div>
		
		<div class="my_pe">
			<div class="my_info">
				사원번호 : ${commuteMyInfo.emp_no} / 사원명 : ${commuteMyInfo.emp_name } / 직함 : ${commuteMyInfo.job_nm }
				 / 부서명 : ${commuteMyInfo.dept_nm } / 연락처 : ${commuteMyInfo.phone } 
			</div>
	
			<div class="personnel_button">
			<!-- 인사팀만 보여지는 버튼 -->
				<button type="button" onclick="" class="btn btn-secondary btn_red" id="personnel">직원근태 리스트</button>
			</div>
		</div>	


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
						<th class="commute_table_th font2" >근무일</th>
						<th class="commute_table_th font2" >출근 시간</th>
						<th class="commute_table_th font2" >퇴근 시간</th>
						<th class="commute_table_th font2" >일 근무 시간</th>
						<th class="commute_table_th font2" >주 누적 근무시간</th>
						<th class="commute_table_th font2" >주 남은 근무시간</th>
					</tr>
				</thead>
	
				<tbody>
					<c:if test="${fn:length(commuteMystatus) == 0}">
						<tr class="no_list">
							<!-- 	보여질 내역이 없을 경우 -->
							<td colspan='6'> 조회된 내용이 없습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="commute" items="${commuteMystatus}">
						<tr>
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
		
		</div>
	</div>
</body>
</html>