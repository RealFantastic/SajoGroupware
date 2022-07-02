<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원근태내역 수정</title>
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

		<div class="commute_title font4">직원 근태내역 수정</div>
		
		<div >
			<div> 그래프자리
<!-- 				Highcharts.chart('container', { -->
<!--     chart: { -->
<!--         plotBackgroundColor: null, -->
<!--         plotBorderWidth: 0, -->
<!--         plotShadow: false -->
<!--     }, -->
<!--     title: { -->
<!--         text: 'Browser<br>shares<br>2017', -->
<!--         align: 'center', -->
<!--         verticalAlign: 'middle', -->
<!--         y: 60 -->
<!--     }, -->
<!--     tooltip: { -->
<!--         pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>' -->
<!--     }, -->
<!--     accessibility: { -->
<!--         point: { -->
<!--             valueSuffix: '%' -->
<!--         } -->
<!--     }, -->
<!--     plotOptions: { -->
<!--         pie: { -->
<!--             dataLabels: { -->
<!--                 enabled: true, -->
<!--                 distance: -50, -->
<!--                 style: { -->
<!--                     fontWeight: 'bold', -->
<!--                     color: 'white' -->
<!--                 } -->
<!--             }, -->
<!--             startAngle: -90, -->
<!--             endAngle: 90, -->
<!--             center: ['50%', '75%'], -->
<!--             size: '110%' -->
<!--         } -->
<!--     }, -->
<!--     series: [{ -->
<!--         type: 'pie', -->
<!--         name: 'Browser share', -->
<!--         innerSize: '50%', -->
<!--         data: [ -->
<!--             ['Chrome', 58.9], -->
<!--             ['Firefox', 13.29], -->
<!--             ['Internet Explorer', 13], -->
<!--             ['Edge', 3.78], -->
<!--             ['Safari', 3.42], -->
<!--             { -->
<!--                 name: 'Other', -->
<!--                 y: 7.61, -->
<!--                 dataLabels: { -->
<!--                     enabled: false -->
<!--                 } -->
<!--             } -->
<!--         ] -->
<!--     }] -->
<!-- }); -->
        
			</div>
			<div>
				조회날짜 자리
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
		
		
<!-- 		인사팀전용 -->
		<div class="commute_bottom_btn">
			<a href="<%=request.getContextPath() %>/commute/empCommuteList">
			<button class="btn_green btn_commute_list">직원별 근태목록</button>
			</a>
<!-- 			<button class="btn_yellow btn_commute_change">수정완료</button> -->
		</div>
		
	</div>
		
</body>
</html>