<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원연차내역 보기</title>

	<!-- 부트스트랩 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
	<script 
		src="https://code.jquery.com/jquery-3.5.1.slim.min.js" 
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" 
		crossorigin="anonymous"></script>
	
	<!-- J쿼리 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>

	<!-- CSS적용 -->
	<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/commute.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/holiday.css" rel="stylesheet">

	<!-- JSTree -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script> <!-- 돋보기 -->
	<script src="<%=request.getContextPath()%>/resources/js/mayoJstree.js"></script>  <!-- 정환 조직도js -->

</head>
<body>

<jsp:include page="/WEB-INF/views/template_header.jsp"/>
<jsp:include page="/WEB-INF/views/template_left.jsp"/>

	<div class="left_bar_exception">
	
		<div class="holiday_list font4">나의 연차현황</div>
		
		<div class="my_pe">
			<div class="my_info font1">
				　<br>
					<div class="font2">　 ＜나의 인적사항＞　<br><br></div>
					
					　　사원번호 : ${commuteMyInfo.emp_no}　　<br><br>
					　　사원명 : ${commuteMyInfo.emp_name }　　<br><br>
					　　직함 : ${commuteMyInfo.job_nm }　　<br><br>
					　　부서명 : ${commuteMyInfo.dept_nm }　　<br><br>
					　　☎ : ${commuteMyInfo.phone }<br>
					　
			</div>
		</div>
	
		<div class="year_select">
			<div class="year_title font3">
				연차 연도날짜 조회
			</div>
			<div>
				<select class="select_box form-control form-control-lg" name="birth-year">
					<option value="">년도를 선택해주세요.▼</option>
					<option value="2020y">2020년도 연차내역 </option>
					<option value="2021y">2021년도 연차내역 </option>
					<option value="2022y" selected >2022년도 연차내역 </option>
					<option value="2023y">2023년도 연차내역 </option>
					<option value="2024y">2024년도 연차내역 </option>
					<option value="2025y">2025년도 연차내역 </option>
					<option value="2026y">2026년도 연차내역 </option>
					<option value="2027y">2027년도 연차내역 </option>
					<option value="2028y">2028년도 연차내역 </option>
					<option value="2029y">2029년도 연차내역 </option>
					<option value="2030y">2030년도 연차내역 </option>
				</select>
			</div>


<script type="text/javascript">
	function selectHolidayList(){
		$.ajax({
			type:"post"
			,url:"<%=request.getContextPath()%>/holiday/selectHolidayList"
			,data:{
// 				select option value
			}
			,dataType:"json"
			,success:funtion(result){
				//데이블 초기화
				$('.holiday_table > tbody').empty();
				var list = result.holidayList;
			
				if(list.length > 0){
					var str = "";
					list.forEach(function(item){
						str +="<tr>"
						str +="<td class='holiday_table_list_td'>"+${holiday.REQ_DATE }+"</td>";
						str +="<td class='holiday_table_list_td'>"+${holiday.HD_START }+"</td>";
						str +="<td class='holiday_table_list_td'>"+${holiday.HD_END }+"</td>";
						str +="<td class='holiday_table_list_td'>"+${holiday.HD_COUNT }+"</td>";
						str +="<td class='holiday_table_list_td'>"+${holiday.HD_mod }+"</td>";
						str +="<td class='holiday_table_list_td'>"+${holiday.HD_RESON }+"</td>";
						str +="</tr>";
					})
				}else{
					str +="<tr>"
					str += "<td colspan='6' class='holiday_table_list_td'>조회된 연차내용이 없습니다.</td>";
					str +="</tr>";
				}
			}
			,error:function(){
				alert("연차ajax 제대로 동작했슈 ........ㅠㅠ");
			}
		});
	}
</script>





			<div class="occur_title alert alert-success font2" role="alert">
				해당연도 발생연차 :　 0 일 
<!-- 				일단 0일 기준  -->
			</div>
		</div>




<!-- 인사팀만 보여지는 버튼 -->
				<c:if test="${sessionScope.loginSsInfo.dept_no eq 10}">
					<div class="personnel_button">
						<button type="button" onclick="location.href='<%= request.getContextPath()%>/holiday/empHolidayList'" class="btn btn-secondary btn_red" id="personnel">
							직원별 연차 리스트 보기
						</button>
					</div>
				</c:if><br>


		
		<div class="table_all">
			<table class="holiday_table">
				<colgroup>
					<col width="20%">
					<col width="20%">
					<col width="20%">
					<col width="10%">
					<col width="10%">
					<col width="20%">
				</colgroup>
				<thead>
					<tr>
						<th class="holiday_table_list_th font2">연차 신청일</th>
						<th class="holiday_table_list_th font2">연차 시작일</th>
						<th class="holiday_table_list_th font2">연차 종료일</th>
						<th class="holiday_table_list_th font2">사용 연차</th>
						<th class="holiday_table_list_th font2">잔여 연차</th>
						<th class="holiday_table_list_th font2">비고</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${fn:length(holidayMyList) == 0}">
						<tr class="no_list">
							<!-- 	보여질 내역이 없을 경우 -->
							<td colspan='6'> 조회된 연차내용이 없습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="holiday" items="${holidayMyList}">
						<tr>
							<td class="holiday_table_list_td">${holiday.REQ_DATE }</td>
							<td class="holiday_table_list_td">${holiday.HD_START }</td>
							<td class="holiday_table_list_td">${holiday.HD_END }</td>
							<td class="holiday_table_list_td">${holiday.HD_COUNT }</td>
							<td class="holiday_table_list_td">${holiday.HD_mod }</td>
							<td class="holiday_table_list_td">${holiday.HD_RESON }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>


</body>
</html>