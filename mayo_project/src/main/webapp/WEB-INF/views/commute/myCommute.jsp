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
	
<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet"> 
<link href="<%=request.getContextPath()%>/resources/css/commute.css" rel="stylesheet">
<!-- JSTree -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script> <!-- 돋보기 -->

</head>

<body>

<jsp:include page="/WEB-INF/views/template_header.jsp"/>
<jsp:include page="/WEB-INF/views/template_left.jsp"/>


	<div class="left_bar_exception">
	
		<div class="commute_title font4">나의 근태현황</div>
		
		<div>
			<div>
<!-- 		그래프자리 -->
			<script>
			/* Highcharts.chart('container', {
			    chart: {
			        plotBackgroundColor: null,
			        plotBorderWidth: 0,
			        plotShadow: false
			    },
			    title: {
			        text: 'Browser<br>shares<br>2017',
			        align: 'center',
			        verticalAlign: 'middle',
			        y: 60
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
			            size: '110%'
			        }
			    },
			    series: [{
			        type: 'pie',
			        name: 'Browser share',
			        innerSize: '50%',
			        data: [
			            ['Chrome', 58.9],
			            ['Firefox', 13.29],
			            ['Internet Explorer', 13],
			            ['Edge', 3.78],
			            ['Safari', 3.42],
			            {
			                name: 'Other',
			                y: 7.61,
			                dataLabels: {
			                    enabled: false
			                }
			            }
			        ]
			    }]
			}); */
			</script>
			</div>
			
			<div>
<!-- 		조회날짜 자리 -->
				<template>
					<div class="container">
						선택한 주 : {{ dateRange.start }} ~ {{ dateRange.end }}
						<br />
						<br />
						<date-picker
							inline
							:editable="false"
							valueType="format"
							format="YYYYMMDD"
							:getClasses="getClasses"
							:lang="datepickerLang"
							:value="weekTime"
							:disabled-date="dislabedDate"
							@pick="calendarPick"
						/>
					</div>
				</template>

<script>
// import DatePicker from "vue2-datepicker";
// import "vue2-datepicker/index.css";
// import moment from "moment";

// export default {
// 	components: { DatePicker },
// 	data() {
// 		return {
// 			weekTime: null,
// 			dateRange: {
// 			start: null,
// 			end: null,
// 			},
// 			datepickerLang: {
// 			yearFormat: "YYYY년",
// 			monthFormat: "M월",
// 			monthBeforeYear: false,
// 			},
// 		};
// 	},
// 	methods: {

// 		// 선택한 영역 class set
// 		getClasses(cellDate, currentDates) {
// 			if (currentDates.length === 0) return;
	
// 		//기준 날짜
// 		const cellDateVal = moment(cellDate).format("YYYYMMDD");
// 		// 주 시작일 날짜
// 		const startWeekDay = moment(currentDates[0])
// 			.startOf("week")
// 			.format("YYYYMMDD");
// 		// 주 종료일 날짜
// 		const endWeekDay = moment(currentDates[0])
// 			.endOf("week")
// 			.format("YYYYMMDD");
	
// 		// 주 시작점 & 종료점 class
// 		if (cellDateVal === startWeekDay || cellDateVal === endWeekDay) {
// 			return "active";
// 		}
// 		// 중간영역 class
// 		if (
// 			moment(cellDateVal).isAfter(startWeekDay) &&
// 			moment(cellDateVal).isBefore(endWeekDay)
// 			) {
// 			return "in-range";
// 			}
// 		},
	
// 		// 캘린더 비활성화 영역 - 당일 주를 포함하여 선택 가능
// 		dislabedDate(date) {
// 			return (
// 			moment(date).format("YYYYMMDD") >=
// 			moment()
// 				.add("7", "days")
// 				.startOf("week")
// 				.format("YYYYMMDD")
// 			);
// 		},
// 		calendarPick(item) {
// 		this.weekTime = moment(item).format("YYYYMMDD");
// 		// 선택한 날짜의 주 첫째일과 마지막일 date set - 첫째일을 일요일로 설정
// 		this.dateRange.start = moment(item)
// 			.startOf("week")
// 			.format("YYYYMMDD");
// 			this.dateRange.end = moment(item)
// 				.endOf("week")
// 				.format("YYYYMMDD");
// 		},
// 	},
// };
</script>

			</div>
			<div class="my_info">
				사원번호 : ${commuteMyInfo.emp_no} / 사원명 : ${commuteMyInfo.emp_name } / 직함 : ${commuteMyInfo.job_nm }
				 / 부서명 : ${commuteMyInfo.dept_nm } / 연락처 : ${commuteMyInfo.phone } 
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
				
				</tbody>
			</table>
		
		
		
		
		</div>
	</div>
</body>
</html>