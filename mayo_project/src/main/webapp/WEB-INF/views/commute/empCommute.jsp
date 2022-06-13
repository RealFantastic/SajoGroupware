<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원근태내역 수정</title>
<link href="<%=request.getContextPath()%>/resources/css/commute.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">

<jsp:include page="/WEB-INF/views/template_header.jsp"/>
</head>
<body>
	<script type="text/javascript">
	//현재시간  https://stickode.tistory.com/124 
		function setClock(){
		    var dateInfo = new Date(); 
		    var hour = modifyNumber(dateInfo.getHours());
		    var min = modifyNumber(dateInfo.getMinutes());
		    var sec = modifyNumber(dateInfo.getSeconds());
		    var year = dateInfo.getFullYear();
		    var month = dateInfo.getMonth()+1; //monthIndex를 반환해주기 때문에 1을 더해준다.
		    var date = dateInfo.getDate();
		    document.getElementById("time").innerHTML = hour + ":" + min  + ":" + sec;
		    document.getElementById("date").innerHTML = year + "년 " + month + "월 " + date + "일";
		}
		function modifyNumber(time) {
			if(parseInt(time)<10){
				return "0"+time;
			}else{
				return time;
			}
		}
		window.onload=function(){
			setClock();
			setInterval(setClock,1000); //1초마다 setClock 함수실행
		}
	</script>

	<div class="left_bar">
		<div class="left_bar_img">
			<img alt="" src="">
			이미지 자리<br>
			이미지 자리<br>
			이미지 자리<br>
			이미지 자리<br>
			이미지 자리<br>
			이미지 자리<br>
		</div>
		<div>
			<div id="date" class="left_bar_date font3"></div>
			<div id="time" class="left_bar_time font6"></div>
		</div>
		<div class="left_bar_btn">
			<button class="btn_green btn_attendance">출근</button>
			<button class="btn_green btn_leave">퇴근</button>
			<button class="btn_green btn_off">근무 외 시간</button>
		</div>
		<div>
		달력 자리<br>
		달력 자리<br> 
		달력 자리<br>
		달력 자리<br>
		달력 자리<br>  
		<!-- 혜리니자리 -->
		</div>
	</div>
	




	<div class="left_bar_exception">
		<div>
			그래프 자리
		</div>
		<div>
			조회날짜 자리
		</div>
		<div>
			사원번호 :, 사원명 : , 직함 : ,부서명, 연락처 : 
		</div>
	</div>

	<div>
		<table class="commute_table" border="1">
			<colgroup>
				<col width="10%">
				<col width="13%">
				<col width="13%">
				<col width="18%">
				<col width="23%">
				<col width="23%">
			</colgroup>
			<thead>
				<tr class="commute_table_tr">
					<th scope="col">근무일</td>
					<th scope="col">출근 시간</td>
					<th scope="col">퇴근 시간</td>
					<th scope="col">일 근무 시간</td>
					<th scope="col">주 누적 근무시간</td>
					<th scope="col">주 남은 근무시간</td>
				</tr>
			</thead>
		<%-- 	<c:forEach items=""> --%>
		<!-- 		<tr> -->
		<!-- 			<td>근무일</td> -->
		<%-- 			<td>${START_TIME }</td> --%>
		<%-- 			<td>${END_TIME }</td> --%>
		<!-- 			<td>일 근무 시간</td> -->
		<!-- 			<td>주 누적 근무시간</td> -->
		<!-- 			<td>주 남은 근무시간</td> -->
		<!-- 		</tr> -->
		<%-- 	</c:forEach>	 --%>
		</table>
	
	<div class="commute_bottom_btn">
		<button class="btn_gray btn_commute_list">직원별 근태목록</button>
		<button class="btn_gray btn_commute_change">수정완료</button>
	</div>
	
	
	</div>
</body>
</html>