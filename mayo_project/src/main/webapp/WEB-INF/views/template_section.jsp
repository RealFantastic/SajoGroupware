<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<section id="j_section">
	<article id="j_commute">
		<div class="chart_week">
			<div>
<!-- 		그래프자리 -->
				<div class="chart_chart">
					<figure class="highcharts-figure">
						<div id="container"></div>
					</figure>
					
					<div id="chart_nodata" style="display: none;">조회된 데이터가 없습니다.</div>
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
										fontSize:'12px',//그래프에 뜨는 폰트 사이즈
									}
								},
								startAngle: -90,
								endAngle: 90,
								center: ['50%', '70%'],// 그래프사이즈 중요 : 좌측 가려지는%,위에 보여지는%
								size: '110%' // 그래프 크기 조절 
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
						<div class="row week-selector">
							<div class="col-md-8">
								<div class="form-group clearfix">
									<div class="col-sm-8">
										<span class="icon-block ">
											<input type="hidden" class="form-control" id="weekpicker">
											<span class="icon-date"></span>
										</span>
										<input type="hidden" id="start_dt">
										<input type="hidden" id="end_dt">	
									</div>
								</div>
							</div>
						</div>
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
							,url:"<%=request.getContextPath()%>/commute/selectCommuteList"
							,data:{
								start_dt : $("#start_dt").val()
								, end_dt : $("#end_dt").val()
							}
							,dataType:"json"
							,success:function(result){
			 					
								//테이블 초기화
								$('.commute_table > tbody').empty();
// 								result=JSON.parse(result);
								var list = result.commuteList;

								if(list.length > 0){
									var str = ""; 
									list.forEach(function(item){
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
									str += "<td colspan='6' class='commute_table_list_td'>조회된 근태내용이 없습니다.</td>";
									str += "</tr>";
								}
								$('.commute_table > tbody').append(str);
								console.log(list.length);
								if(result.chartData != null && result.chartData != ""){
									$("#chart_nodata").hide();
									var chatData = result.chartData;
									var chart = $('#container').highcharts();
									if(chart){
										chart.destroy();
									}
									createChart(chatData.week_rate, chatData.mod_rate, chatData.week_work, chatData.week_work_mod)
								}else{
									var chart = $('#container').highcharts();
									if(chart){
										chart.destroy();
									}
									
									$("#chart_nodata").show();
								}
								
								
							}
							,error:function(){
								alert("ajax 제대로 동작 못했다. 문제를 찾아라");
							}
						});
					}
				</script>
			</div>
			 
		<div class="table_all"
			 style=" 
/* 			 		display: flex;  */
 					position: relative; 
 	    			bottom: 120px;
					">
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
						<th class="commute_table_th font1" >근무일</th>
						<th class="commute_table_th font1" >출근 시간</th>
						<th class="commute_table_th font1" >퇴근 시간</th>
						<th class="commute_table_th font1" >일 근무 시간</th>
						<th class="commute_table_th font1" >주 누적 근무시간</th>
						<th class="commute_table_th font1" >주 남은 근무시간</th>
					</tr>
				</thead>
	
				<tbody>
					<c:if test="${fn:length(commuteMystatus) == 0}">
						<tr class="no_list">
							<!-- 	보여질 내역이 없을 경우 -->
							<td colspan='6'> 조회된 근태내용이 없습니다.</td>
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
	</article>
	
	<article id="j_elc">
	
		<div class="bodyContent" id="bodyContent">
		<div class="content_top">
			<h1>결재 대기 문서</h1>
		</div>
		<div class="content_page">
			<div id="my_doc_list_container">
				<table class="table draft_list">
				  <thead>
				    <tr>
				      <th scope="col">문서번호</th>
				      <th scope="col">기안일</th>
				      <th scope="col">결재양식</th>
				      <th scope="col">긴급</th>
				      <th scope="col">제목</th>
				      <th scope="col">첨부</th>
				      <th scope="col">기안자</th>
				    </tr>
				  </thead>
				  <tbody class="table-group-divider">
					  <c:choose>
					  	<c:when test="${empty waitList}">
					  		<tr>
					  			<td colspan="7" style="font-weight:bold; color: blue;"> 결재할 문서가 없습니다. </td>
					  		</tr>
					  	</c:when>
					  	<c:otherwise>
					  		<c:forEach var="list" items="${waitList }">
					  			<tr class="waiting_list" data-eano="${list.ea_no }">
							      <th scope="row">${list.ea_no }</th>
							      <td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${list.draft_date }"/></td>
							      <td>${list.form_title }</td>
							      <c:choose>
							      	<c:when test="${list.isemergency eq 'N' }">
										<td><img src="<%=request.getContextPath()%>/resources/images/blackalert.png" style="width:22.2px;"></td>
							      	</c:when>
							      	<c:otherwise>
								      	<td><img src="<%=request.getContextPath()%>/resources/images/alert.png" style="width:22.2px;"></td>
							      	</c:otherwise>
							      </c:choose>
							      <td>${list.ea_title }</td>
							      <c:choose>
							      	<c:when test="${not empty list.approvalFiles }">
							      		<td><i class="fa-solid fa-paperclip"></i></td>
							      	</c:when>
							      	<c:otherwise>
							      		<td>${list.approvalFiles.f_no }</td>
							      	</c:otherwise>
							      </c:choose>
							      <td>${list.drafter_name}</td>
							    </tr>
					  		</c:forEach>
					  	</c:otherwise>
					  </c:choose>
				  </tbody>
				</table>
			</div>
		</div>
	</div>
	
	</article>
</section>
