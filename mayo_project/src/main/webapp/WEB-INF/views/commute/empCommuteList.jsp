<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 직원 근태내역 리스트</title>

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
	<link href="<%=request.getContextPath()%>/resources/css/commute_list.css" rel="stylesheet">

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
	
		<div class="commute_list font4">
			전체 직원별 근태내역 리스트
		</div>
		
		<!-- 	검색 -->
		<div class="search_bar">
			<form name="search_form" autocomplete="on">
				<div class="input-group mb-3">
					<select name="search_type" id="search_option" class="btn btn-outline-secondary dropdown-toggle font1" aria-haspopup="true" aria-expanded="false">
						<option value="search_no" selected="selected">사원번호</option>
						<option value="search_name" >사원명</option>
						<option value="search_dept" >부서명</option>
					</select>
					<input type="search" name="search_keyword" value="" class="form-control font1" aria-label="Text input with dropdown button" placeholder="검색내용 입력" list="datalistOptions" id="exampleDataList">
					<button type="button" onclick="commuteEmpSearch()" class="btn btn-secondary btn_gray" id="searching">검색</button>
				</div>
			</form>
		</div>
		<script type="text/javascript">
			function commuteEmpSearch() {
				$.ajax({
					type:"post"
					,url:"<%=request.getContextPath()%>/commute/empCommuteSearch"
					,data:$("form[name=search_form]").serialize()
					,success:function(result){
					//debugger
						//테이블 초기화
						$('.commute_list_table > tbody').empty();
						result=JSON.parse(result);
						if(result.length>=1){
							result.forEach(function(item){
								str="<tr>"
								str += "<td class='commute_table_list_td'>"+item.emp_no+"</td>";
								str += "<td class='commute_table_list_td'>"+item.emp_name+"</td>";
								str += "<td class='commute_table_list_td'>"+item.job_nm+"</td>";
								str += "<td class='commute_table_list_td'>"+item.dept_nm+"</td>";
								str += "<td class='commute_table_list_td'>"+item.phone+"</td>";
								//str += "<td class='commute_table_list_td'><button class='btn_yellow modify_btn'>수정하기</button></td>";
								str += "<td class='commute_table_list_td'>";
								str += '<form action="<%= request.getContextPath()%>/commute/empCommuteSelect" method="POST">';
								str += '<input type="hidden" name="empNo" value="'+item.emp_no+'">';
								str += '<button class="btn_yellow modify_btn" type="submit">수정하기</button></td>';
								str += '</form>';
								str += "</tr>";
								$('.commute_list_table').append(str);
							})
							
						}else{j
							str="<tr>"
							str += "<td colspan='6' class='commute_table_list_td'>조회된 데이터가 없습니다.</td>";
							str += "</tr>";
							$('.commute_list_table').append(str);
						}
						console.log(result.length);
					}
					
					,error:function(){
						alert("ajax 제대로 동작 못했다. 문제를 찾아라");
					}
				});
				
			}
		</script>



		<div>
			<table class="commute_list_table">
				<colgroup>
					<col width="25%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="25%">
					<col width="20%">
				</colgroup>
				<thead>
					<tr>
						<th class="commute_table_list_th font2">사원번호</th>
						<th class="commute_table_list_th font2">사원명</th>
						<th class="commute_table_list_th font2">직함</th>
						<th class="commute_table_list_th font2">부서명</th>
						<th class="commute_table_list_th font2">연락처</th>
						<th class="commute_table_list_th font2">근태내역수정</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${fn:length(empCommuteList) == 0 }">
						<tr Class="no_list">
							<!-- 보여질 공지사항이 없을 경우 -->
							<td colspan="6"> 조회된 내용이 없습니다. </td>
						</tr>
					</c:if>
					<c:forEach var="emp" items="${empCommuteList}">
						<tr>
							<td class="commute_table_list_td">${emp.emp_no}</td>
							<td class="commute_table_list_td">${emp.emp_name }</td>
							<td class="commute_table_list_td">${emp.job_nm }</td>
							<td class="commute_table_list_td">${emp.dept_nm }</td>
							<td class="commute_table_list_td">${emp.phone }</td>
							<td class="commute_table_list_td">
								<form action="<%= request.getContextPath()%>/commute/empCommuteSelect" method="POST">
									<input type="hidden" name="empNo" value="${emp.emp_no}">
									<button class="btn_yellow modify_btn" type="submit">
										수정하기
									</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>