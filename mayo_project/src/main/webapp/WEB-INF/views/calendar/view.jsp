<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캘린더</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"> -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css' rel='stylesheet'>
<link href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css' rel='stylesheet'>
<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/calendar.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
<!-- JSTree -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<!-- fullcalendar -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.css">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/locales-all.min.js"></script>
<!-- 네이버 지도 -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=YOUR_CLIENT_ID&callback=CALLBACK_FUNCTION"></script>    
    <script>
      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth',
          // 한글 달력 설정
          locale: 'ko',
          // 월요일 시작 달력
          firstDay: 1,
          // Bootstrap 5 사용
          themeSystem: 'bootstrap5',
          
        });
        calendar.render();
      });

    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/template_header.jsp"/>

<div class="content">

	<div id="cal" style="display:flex;">
		<div id='calendar'></div> <div class="btn_yellow newSked" data-bs-toggle="modal" data-bs-target="#newSked">일정 추가</div>
	</div>

</div>

<!-- 일정 추가 모달창 -->
<div class="modal fade" id="newSked" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">일정 추가</h5> 
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
        <form name="Schedule">
      <div class="modal-body">
      	<div style="display: flex;">
	   		<div>
	        	<select name="proj_category" class="form-select" aria-label="Default select example">
				  <option selected>종류</option>
				  <option value="전사">전사</option>
				  <option value="개인">개인</option>
				  <c:forEach var="project" items="${project }">
				  <option value="${project.proj_name }">${project.proj_name }</option>
				  </c:forEach>
				</select>
	        </div>
      	</div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">일정명</label>
            <input type="text" class="form-control" id="title" name="sked_name" required="required">
          </div>
          <div class="mb-3">
         	 <div id="map" style="width:100%;height:400px;"></div>
          </div>
          <div class="mb-3">
            <label for="message-text" class="col-form-label">설명</label>
            <textarea class="form-control" id="content" name="sked_content" required></textarea>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn_gray" data-bs-dismiss="modal">취소</button>
        <button id="submitS" type="submit" class="btn_green">등록</button>
        </div>
        </form>
      </div>
    </div>
  </div>
<script>
// 네이버 지도
var mapOptions = {
	    center: new naver.maps.LatLng(37.3595704, 127.105399),
	    zoom: 10
	}

var map = null;

function initMap() {
    map = new naver.maps.Map('map', {
        center: new naver.maps.LatLng(37.3595704, 127.105399),
        zoom: 10
    });
}

var map = new naver.maps.Map('map', {
    center: new naver.maps.LatLng(37.3595704, 127.105399),
    zoom: 10
});
// 일정 추가
// $(".newSked").click(fucntion(){

	
// });
</script>
</body>
</html>