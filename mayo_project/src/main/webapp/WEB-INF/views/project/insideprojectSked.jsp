<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/resources/css/insideproj.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/resources/css/workDetail.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/calendar.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
<!-- JSTree -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/mayoJstree.js"></script>
<!-- 카카오 지도 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=349c4c75c4f78f9628da23a777619359&libraries=services"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/template_header.jsp"/>

	<aside id="side">
		<div id="side-content">
			<button class="btn_yellow sidebtn" data-bs-toggle="modal" data-bs-target="#projInfo">프로젝트 정보</button>
			<div style="display:flex;">
				<button id="insertWork" class="btn_green sidebtn" data-bs-toggle="modal" data-bs-target="#newWork">새 업무</button>
			</div>
			  <div style="display:flex;">
				<button id="insertSch" class="btn_green sidebtn" data-bs-toggle="modal" data-bs-target="#newSked">새 일정</button>
			  </div>
				<button id="insertPic" data-bs-toggle="modal" data-bs-target="#add"><i class="fa-solid fa-user-plus fa-lg"></i></button>
		 </div>
	</aside>

	<div id="body">
	
		<!-- 직원 추가 Modal -->
		<div class="modal fade" id="add" tabindex="-1" aria-labelledby="exampleModalLabel3" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel3">담당자 추가</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body" style="display: flex;">
						<div id="empJstree"></div>
						<div id="selectedEmp_container">
							<div id="selectedEmp">
								<form id="select_add">
								<table id="selected_list">
									<thead>
										<tr>
											<td>사번</td>
											<td>사원명</td>
											<td>부서명</td>
											<td>직급명</td>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<input type="hidden" name="proj_no" value="${project.proj_no }">
								</form>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn_gray" data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn_green" id="insertEmp">추가</button>
					</div>
				</div>
			</div>
		</div>

	<!-- 프로젝트 정보 모달창 -->
<div class="modal fade" id="projInfo" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">프로젝트</h5> 
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
        <form name="mProject">
      <div class="modal-body">
      	<div style="display: flex;">
      		<div>
	      		<c:if test="${not empty project.proj_type }">
				<c:choose>
				<c:when test="${project.proj_type eq '1'}">업무</c:when>
				<c:when test="${project.proj_type eq '2'}">동호회</c:when>
				<c:when test="${project.proj_type eq '3'}">정보공유</c:when>
				<c:otherwise>기타</c:otherwise>
				</c:choose>
				</c:if> 
      		</div>
				<div style="margin-left:10px;">${project.proj_no }</div>
				<input type="hidden" name="proj_no" value="${project.proj_no }">
      	</div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">프로젝트명</label>
            <input type="text" class="form-control" id="title" name="proj_name" value="${project.proj_name }" required="required">
          </div>
          <div class="mb-3">
            <label for="message-text" class="col-form-label">설명</label>
            <textarea class="form-control" id="content" name="proj_content" required>${project.proj_content }</textarea>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" id="deleteProj" class="btn_red">삭제</button>
        <button id="submitM" type="submit" class="btn_green">수정</button>
        </div>
        </form>
      </div>
    </div>
  </div>
		<!-- 프로젝트 정보 -->
		<div class="font4 proj">
			<div>${project.proj_name } </div>
		</div>
		
		<!-- 프로젝트 업무, 일정들 load 통해서 불러올 것-->	
		<div style="display:flex;">
			<form action="<%=request.getContextPath()%>/project/select" method="GET">
				<input type="hidden" name="proj_no" value="${project.proj_no }">
				<button id="workList" type="submit" class="font3 list">업무</button>
			</form>
			<form action="<%=request.getContextPath()%>/schedule/toSked" method="POST">
				<input type="hidden" name="proj_no" value="${project.proj_no }">
				<button id="skedList" type="submit" class="font3 list">일정</button>
			</form>
		</div>
        <div id="skedlist"></div>
		
		<!--  새 업무 추가 모달창 -->
<div class="modal fade modal-lg" id="newWork" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title font3" id="exampleModalLabel1" style="font-weight:bold;">새 업무</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
        <form name="newWork" action="<%=request.getContextPath()%>/work/insert" method="POST" enctype="multipart/form-data">
      <div class="modal-body insidebody">
      <input type="hidden" class="form-control" id="proj_no" name="proj_no" value="${project.proj_no }">
        <div style="display:flex; margin-bottom:10px;">
        <div style="margin-right: 15px;">
        	<select name="work_status" class="form-select" aria-label="Default select example" required="required">
			  <option selected>상태</option>
			  <option value="0">요청</option>
			  <option value="1">진행</option>
			  <option value="2">완료</option>
			  <option value="3">보류</option>
			</select>
        </div>
          <div>
			 <input class="isemergency" name="isemergency" value="N" type="hidden">
            <button type="button" id="isemergency"><img id="eimg" src="<%=request.getContextPath() %>/resources/images/blackalert.png" alt="긴급"></button>
        </div>
          </div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label font2">제목</label>
            <input type="text" class="form-control" id="title" name="work_title" placeholder="제목을 입력해주세요" required="required">
          </div>
          <div class="date" style="display:flex;">
          	<div class="mb-3" style="margin-right:13px;">
            	<label for="recipient-name" class="col-form-label">시작일</label>
            	<input type="Date" class="form-control" id="work_start_date" name="work_start_date">
          	</div>
          	<div class="mb-3">
            	<label for="recipient-name" class="col-form-label" style="color:red;">마감일</label>
            	<input type="Date" class="form-control" id="work_deadline" name="work_deadline">
          	</div>
          </div>
	    <div class="mb-3">
        	<label for="work_progress" class="col-form-label">진행률</label>
			<input type="range" id="progress" min="0" max="100" step="10">
			<input type="text" id="percentage" name="work_progress" value="" readonly>%
		</div>
          <div class="mb-3">
            <label for="message-text" class="col-form-label font2">내용</label>
            <textarea class="form-control" id="content" name="work_content" rows="7" placeholder="내용을 입력해주세요" required="required" style="height:200px;"></textarea>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn_gray" data-bs-dismiss="modal">취소</button>
        <button id="submitP" type="submit" class="btn_green">등록</button>
      </div>
        </form>
    </div>
  </div>
</div>

<!-- 새 일정 추가 모달창 -->
<div class="modal fade" id="newSked" tabindex="-1" aria-labelledby="exampleModalLabel2" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog ">
    <div class="modal-content skedModal">
      <div class="modal-header">
        <h5 class="modal-title font3" id="exampleModalLabel2" style="font-weight:bold;">새 일정</h5> 
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form name="newSked">
      <div class="modal-body">
      	<div style="display: flex;">
	   		<div>
	        	<input name="sked_category" value="${project.proj_no }" type="hidden">
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
</div>

<script>
// 페이지 load 될 때 업무/일정 가져오기 - 틀 수정 예정
$(function(){
		var proj_no = ${project.proj_no};
		$("#skedlist").load("<%=request.getContextPath()%>/work/detailS",{proj_no:proj_no});
		
		orgChart($("#empJstree"));
		
		$("#empJstree").bind("select_node.jstree",function(event,data){
			var emp_no = data.instance.get_node(data.selected).id;
			if(emp_no.length<=2){
				return;
			}
			
			$.ajax({
				url:"<%=request.getContextPath()%>/member/detail",
				type:"POST",
				data: {emp_no:emp_no},
				dataType: 'json',
				success: function(result){
					console.log(result);
					var html ="";
					html +=  "<tr>";
   					html += "<td class='emp_no'>"+result.emp_no+"<input type='hidden' name='emp_no' value='"+result.emp_no +"'></td>";
   					html += "<td>"+result.emp_name+"</td>";
   					html += "<td>"+result.dept_name+"</td>";
   					html += "<td>"+result.job_name+"</td>";       				
   					html += "</tr>";
   					
   					$("#selected_list tbody").append(html);
				},
				error: function(){}
			});
			
		});
		
 		// 프로젝트 담당자 추가
		$("#insertEmp").click(function(){

			console.log($("#select_add").serialize());

			$.ajax({
				type: "POST",
				url: "<%=request.getContextPath()%>/project/insertPic",
				data: $("#select_add").serialize(),
				success: function(result){
					alert(result);
				}
				
			});
		
		});
});

	//휴지통 누르면 파일 삭제하기
	$("#files").on('click','[class=deleteFile]',function(e){
		$(this).parent('.fileDiv').remove();
	})


// 프로젝트 수정 ajax
$("#submitM").click(function(){
	// form data 전부 넘기기	
	var proj = $("form[name=mProject]").serialize();
	
	$.ajax({
 		type: "POST",
		url: "<%=request.getContextPath()%>/project/update",
		data: proj, 
 		success: function(result){
			alert(result);
			location.reload();
		}
		
 	});
});


// 프로젝트 삭제 ajax
$("#deleteProj").click(function(){
	var proj_no = ${project.proj_no};
	var check = confirm("프로젝트를 삭제하시겠습니까?");
	// 프로젝트 삭제 여부 확인하기	
	if(check){
		
		$.ajax({
	 		type: "POST",
			url: "<%=request.getContextPath()%>/project/delete",
			data: { 
	 				proj_no: proj_no
	 				},
	 		success: function(result){
	 			console.log("삭제");
				alert(result);
				location.href="<%=request.getContextPath()%>/project/list";
			}
 		});
	} else {
		return false;
	}
});


// 긴급 버튼
$("#eimg").click(function(){
	var eimg = $("#eimg").attr("src");
	
	if(eimg=="<%=request.getContextPath() %>/resources/images/blackalert.png"){
		$("#eimg").attr("src", "<%=request.getContextPath() %>/resources/images/alert.png");	
		$("input[name=isemergency]").val('Y');
		console.log($("input[name=isemergency]").val());
	} else {
		$("#eimg").attr("src", "<%=request.getContextPath() %>/resources/images/blackalert.png");
		$("input[name=isemergency]").val('N');
	}
});

    

// 프로그래스 바 값 가져오기
var slider = document.getElementById("progress");
var output = document.getElementById("percentage");
output.value = slider.value;

slider.oninput = function() {
  document.getElementById("percentage").value = this.value;
}


</script>

<script>
// 일정 추가하기 
	$("#submitS").click(function(){
		
		var sked = $("form[name=newSked]").serialize();
		
		$.ajax({
			type: "POST",
			url:"<%=request.getContextPath()%>/schedule/insertS",
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