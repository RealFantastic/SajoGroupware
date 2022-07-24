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
<script src="<%=request.getContextPath()%>/resources/js/mayoJstree.js"></script>
<!-- fullcalendar -->
<!-- moment lib -->
<script src='https://cdn.jsdelivr.net/npm/moment@2.27.0/min/moment.min.js'></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.css">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/locales-all.min.js"></script>
<!-- moment lib -->
<script src='https://cdn.jsdelivr.net/npm/moment@2.27.0/min/moment.min.js'></script>
<!-- 카카오 지도 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=349c4c75c4f78f9628da23a777619359&libraries=services"></script>
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

          // DB에서 data 끌어오기
          events: [ // 달력에 data 띄우기
        	  <c:forEach var="work" items="${work}"> // 업무
	    		{
			      title: '${work.work_title}',
			      start: '${work.work_start_date}', 
			      end: '${work.work_deadline}',
			      color: 'rgb(196, 223, 170)', // 줄 색상 / text-color - 글자 색상
			      extendedProps: {
			    	  work_no: '${work.work_no}',
			    	  proj: '${work.proj_name}',
			    	  content: '${work.work_content}',
			    	  status: '${work.work_status}',
			    	  emergency: '${work.isemergency}'
			      }
			    },
		     </c:forEach>
			 <c:forEach var="sked" items="${schedule}"> // 일정 - 전사/개인/프로젝트별 색상 바꿀 예정
			  {
				  title:'${sked.sked_name}',
				  start:'${sked.sked_start_date}',
				  end: '${sked.sked_end_date}',
				  color: 'rgb(170, 205, 190)',
			      extendedProps: {
			    	  sked_no: '${sked.sked_no}',
			    	  category: '${sked.sked_category}',
			    	  location: '${sked.sked_location}',
			    	  content: '${sked.sked_content}'
			      }
			  },
			 </c:forEach>
		  ],
		  
		  // data 클릭 event
		  eventClick: function(info) {
			  	
			  
			 	// 일정일 때, 띄우는 모달
			 	if(info.event.extendedProps.emergency == null){
				    $("#sked").modal("show");
				    $("#sked input[name='sked_no']").val(info.event.sked_no);
				    $("#sked .skedTitle").text(info.event.title);
				    $("#sked .skedCate").text(info.event.extendedProps.category);
				    $("#sked .skedStart").text(moment(info.event.start).format('YYYY-MM-DD')); // format 바꾸기
					$("#sked .skedEnd").text(moment(info.event.end).format('YYYY-MM-DD'));
				    $("#sked .skedLoca").text(info.event.extendedProps.location);
				    $("#sked .skedContent").text(info.event.extendedProps.content);
			 	} else {
			 		$("#work").modal("show");
			 	}
			    
		  }
		  
        });// 함수 끝
        calendar.render();
      });

    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/template_header.jsp"/>

<div class="content">

	<div id="cal" style="display:flex;">
		<!-- 일정 추가 버튼 -->
		<div id='calendar'></div> <button type="button" class="btn_yellow newSked" data-bs-toggle="modal" data-bs-target="#newSked">일정 추가</button>
	</div>

</div>

	<!-- 일정 상세보기 -->
<div class="modal fade" id="sked" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog ">
    <div class="modal-content skedModal">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel1">일정 상세보기</h5> 
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<div class="skedCate"></div>
          <div class="mb-3">
            <div class="col-form-label skedTitle font2"></div>
          </div>
           <div class="date" style="display:flex;">
          	<div class="mb-3" style="margin-right:13px;">
            	<div class="col-form-label skedStart"></div>
          	</div>
          	<div class="mb-3">
            	<div class="col-form-label skedEnd" style="color:red;"></div>
          	</div>
          </div>
          <div class="mb-3" style="display:flex;">
          	<i class="fa-solid fa-location-dot"></i><div class="skedLoca"  style="margin-left:5px;"></div>
			 </div>
          <div class="mb-3">
            <div class="col-form-label skedContent"></div>
          </div>
      </div>
      </div>
	</div>
	</div>
	

<!-- 일정 추가 모달창 -->
<div class="modal fade" id="newSked" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog ">
    <div class="modal-content skedModal">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">일정 추가</h5> 
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form name="newSked">
      <div class="modal-body">
      	<div style="display: flex;">
	   		<div>
	        	<select name="sked_category" class="form-select" aria-label="Default select example">
				  <option selected>종류</option>
				  <option value="A">전사</option>
				  <option value="P">개인</option>
				  <c:forEach var="project" items="${project }">
				  <option value="${project.proj_no }">${project.proj_name }</option>
				  </c:forEach>
				</select>
	        </div>
      	</div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">일정명</label>
            <input type="text" class="form-control" id="sked_name" name="sked_name" required="required">
          </div>
           <div class="date" style="display:flex;">
          	<div class="mb-3" style="margin-right:13px;">
            	<label for="recipient-name" class="col-form-label">시작일</label>
            	<input type="Date" class="form-control" id="sked_start_date" name="sked_start_date">
          	</div>
          	<div class="mb-3">
            	<label for="recipient-name" class="col-form-label" style="color:red;">종료일</label>
            	<input type="Date" class="form-control" id="sked_end_date" name="sked_end_date">
          	</div>
          </div>
          <div class="mb-3" id="loca">
          	위치
			<button type="button" id="location" class="btn_yellow">추가</button>
          	<div class="selectedLoca"></div>
          	<input id="sked_location" name="sked_location" value="" type="hidden">
			        <div class="map_wrap" style="display:none;">
					    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
					    <div id="menu_wrap" class="bg_white">
					        <div class="option">
					            <div style="display:flex;">
					                <input type="text" class="form-control" value="" id="keyword" size="15"> 
					                <button type="submit" class="btn_green" onclick="searchPlaces(); return false;">검색하기</button> 
					            </div>
					        </div>
					        <hr>
					        <ul id="placesList"></ul>
					        <div id="pagination"></div>
					    </div>
					</div>
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
<!-- SKED_NAME       NOT NULL VARCHAR2(50)    -->
<!-- SKED_DATE       NOT NULL TIMESTAMP(6)    -->
<!-- SKED_CONTENT             VARCHAR2(1500)  -->
<!-- SKED_START_DATE          DATE            -->
<!-- SKED_END_DATE            DATE            -->
<!-- SKED_LOCATION            VARCHAR2(500)   -->
<!-- SKED_CATEGORY            VARCHAR2(50)    -->
<!-- SKED_EMP_ID              VARCHAR2(50)    -->

// 일정 추가하기 
	$("#submitS").click(function(){
		
		var sked = $("form[name=newSked]").serialize();
		
		$.ajax({
			type: "POST",
			url:"<%=request.getContextPath()%>/schedule/insert",
			data: sked,
			success: function(result){
				alert(result);
			}
			
		});
	});


// 카카오 지도
// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  
    
// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 위치 선택 버튼 누르면 지도 나타내기 toggle
$("#location").click(function(){
	$(".map_wrap").toggle();
	map.relayout(); // 지도 레이아웃 재설정
});	

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다
// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {
    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data); 

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title, ad) {
            kakao.maps.event.addListener(marker, 'mouseover', function() { // 마우스 커서 올렸을 때 
                displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() { // 마우스 커서가 마커에서 벗어날을 때
                infowindow.close();
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info" onclick="selectInfo(this)">' +
                '   <h5 class="infoName">' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span class="infoRoad">' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray infoAddr">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span class=infoAddr>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';
	
    console.log(el);
    return el;
}

// 정보 영역 클릭하면 장소 선택되어짐
function selectInfo(thisEle){	
	console.log(thisEle);
	console.log($(thisEle));
	
	// 장소명
	var name = $(thisEle).children(".infoName").text();
	// 장소 도로명 주소
	var road = $(thisEle).children(".infoRoad").text();
	// 장소 지번 주소
	var jibun = $(thisEle).children(".infoAddr").text();
	
	var html = "<div style='font-weight:bold;'>"+name+"</div>";
	html += "<div>"+road+"</div>";
	html += "<div style='color:#8a8a8a;'>"+jibun+"</div>";
	
	// 주소 보내기
	$(".selectedLoca").append(html);
	if(road==null){
		$("#sked_location").val(jibun);		
	} else {
		$("#sked_location").val(road);
	}
	
	// 검색창 숨기기
	$("#menu_wrap").hide();
	
//주소로 좌표를 검색합니다
geocoder.addressSearch(jibun, function(result, status) {
    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
        removeMarker();
        
        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+$(thisEle).children(".infoName").text()+'</div>'
        });
        infowindow.open(map, marker);

        // 지도 크기 조정
        $("#map").css("height","300px");
        
        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
        
    } 
});    

}



// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}


</script>
</body>
</html>