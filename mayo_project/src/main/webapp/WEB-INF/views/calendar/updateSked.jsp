<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 수정하기</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css' rel='stylesheet'>
<link href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css' rel='stylesheet'>
<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/calendar.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/ef09f998fc.js"></script>
<!-- JSTree -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/mayoJstree.js"></script>
<!-- 카카오 지도 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=349c4c75c4f78f9628da23a777619359&libraries=services"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/template_header.jsp"/>

<div id="body" style="padding-top: 150px;">
	<div id="updateSked">
		<div class="modal-dialog ">
			<div class="modal-content skedModal">
				<div class="modal-header">
					<h5 class="modal-title">일정 수정하기</h5>
				</div>
				<form name="updateSked">
					<div class="modal-body">
						<div style="display: flex;">
							<div>
								<select id="select" name="sked_category" class="form-select" aria-label="Default select example">
									<option value="A" style="color:red;">전사</option>
									<option value="P">개인</option>
									<c:forEach var="project" items="${project }">
										<option value="${project.proj_no }">${project.proj_name }</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="mb-3">
							<label for="recipient-name" class="col-form-label">일정명</label> 
							<input type="text" class="form-control" id="sked_name" name="sked_name" value="${sked.sked_name }" required="required">
							<input type="hidden" name="sked_no" value="${sked.sked_no }">
						</div>
						<div class="date" style="display: flex;">
							<div class="mb-3" style="margin-right: 13px;">
								<label for="recipient-name" class="col-form-label">시작일</label>
								<input type="Date" class="form-control" id="sked_start_date" name="sked_start_date" value="${sked.sked_start_date }" required>
							</div>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label" style="color: red;">종료일</label> 
								<input type="Date" class="form-control" id="sked_end_date" name="sked_end_date" value="${sked.sked_end_date }" required>
							</div>
						</div>
						<div class="mb-3" id="loca">
							위치 ${sked.sked_location }
							<button type="button" id="location" class="btn_yellow">변경</button>
							<div class="selectedLoca"></div>
							<input id="sked_location" name="sked_location" value="${sked.sked_location }"
								type="hidden">
							<div class="map_wrap" style="display: none;">
								<div id="map"
									style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
								<div id="menu_wrap" class="bg_white">
									<div class="option">
										<div style="display: flex;">
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
							<input class="form-control" id="content" name="sked_content" value="${sked.sked_content }" required>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn_gray" id="cancel">취소</button>
						<button id="updateSked_submit" type="button" class="btn_green">수정</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
	<script>
	
	// selected 설정하기
	var category = "${sked.sked_category}";

	$("#select").val(category).prop("selected", true);
	
		//취소 버튼 누르면 뒤로가기
		$("#cancel").click(function() {
			    history.back();
		});
		
		// 일정 수정
		$("#updateSked_submit").click(function(){
			
			var sdate = $("#sked_start_date").val();
			var edate = $("#sked_end_date").val();
			
			if($("#sked_name").val() == ""){
				alert("일정명을 입력해주세요");
				$("#sked_name").focus();
				return false;
			}
			
			if(sdate > edate) {
				alert("종료일은 시작일보다 빠를 수 없습니다");
				$("#sked_end_date").focus();
				return false;
			}
			
			if($("#content").val() == ""){
				alert("내용을 입력해주세요");
				$("#content").focus();
				return false;
			}

			
			var sked = $("form[name='updateSked']").serialize();
			
			$.ajax({
				type: "POST",
				url:"<%=request.getContextPath()%>/schedule/update",
				data: sked,
				success: function(result){
					alert(result);
					history.go(-1);
				}
				
			});
		});

		// 카카오 지도
		// 마커를 담을 배열입니다
		var markers = [];

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 위치 선택 버튼 누르면 지도 나타내기 toggle
		$("#location").click(function() {
			$(".map_wrap").toggle();
			map.relayout(); // 지도 레이아웃 재설정
		});

		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();

		//주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
			zIndex : 1
		});

		// 키워드로 장소를 검색합니다
		// 키워드 검색을 요청하는 함수입니다
		function searchPlaces() {
			var keyword = document.getElementById('keyword').value;

			if (!keyword.replace(/^\s+|\s+$/g, '')) {
				alert('키워드를 입력해주세요!');
				return false;
			}

			// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
			ps.keywordSearch(keyword, placesSearchCB);
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

			var listEl = document.getElementById('placesList'), menuEl = document
					.getElementById('menu_wrap'), fragment = document
					.createDocumentFragment(), bounds = new kakao.maps.LatLngBounds(), listStr = '';

			// 검색 결과 목록에 추가된 항목들을 제거합니다
			removeAllChildNods(listEl);

			// 지도에 표시되고 있는 마커를 제거합니다
			removeMarker();

			for (var i = 0; i < places.length; i++) {

				// 마커를 생성하고 지도에 표시합니다
				var placePosition = new kakao.maps.LatLng(places[i].y,
						places[i].x), marker = addMarker(placePosition, i), itemEl = getListItem(
						i, places[i]); // 검색 결과 항목 Element를 생성합니다

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
				// LatLngBounds 객체에 좌표를 추가합니다
				bounds.extend(placePosition);

				// 마커와 검색결과 항목에 mouseover 했을때
				// 해당 장소에 인포윈도우에 장소명을 표시합니다
				// mouseout 했을 때는 인포윈도우를 닫습니다
				(function(marker, title, ad) {
					kakao.maps.event.addListener(marker, 'mouseover',
							function() { // 마우스 커서 올렸을 때 
								displayInfowindow(marker, title);
							});

					kakao.maps.event.addListener(marker, 'mouseout',
							function() { // 마우스 커서가 마커에서 벗어날을 때
								infowindow.close();
							});

					itemEl.onmouseover = function() {
						displayInfowindow(marker, title);
					};

					itemEl.onmouseout = function() {
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

			var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
					+ (index + 1)
					+ '"></span>'
					+ '<div class="info" onclick="selectInfo(this)">'
					+ '   <h5 class="infoName">' + places.place_name + '</h5>';

			if (places.road_address_name) {
				itemStr += '    <span class="infoRoad">'
						+ places.road_address_name + '</span>'
						+ '   <span class="jibun gray infoAddr">'
						+ places.address_name + '</span>';
			} else {
				itemStr += '    <span class=infoAddr>' + places.address_name
						+ '</span>';
			}

			itemStr += '  <span class="tel">' + places.phone + '</span>'
					+ '</div>';

			el.innerHTML = itemStr;
			el.className = 'item';

			console.log(el);
			return el;
		}

		// 정보 영역 클릭하면 장소 선택되어짐
		function selectInfo(thisEle) {
			console.log(thisEle);
			console.log($(thisEle));

			// 장소명
			var name = $(thisEle).children(".infoName").text();
			// 장소 도로명 주소
			var road = $(thisEle).children(".infoRoad").text();
			// 장소 지번 주소
			var jibun = $(thisEle).children(".infoAddr").text();

			var html = "<div style='font-weight:bold;'>" + name + "</div>";
			html += "<div>" + road + "</div>";
			html += "<div style='color:#8a8a8a;'>" + jibun + "</div>";

			// 주소 보내기
			$(".selectedLoca").append(html);
			if (road == null) {
				$("#sked_location").val(jibun);
			} else {
				$("#sked_location").val(road);
			}

			// 검색창 숨기기
			$("#menu_wrap").hide();

			//주소로 좌표를 검색합니다
			geocoder
					.addressSearch(
							jibun,
							function(result, status) {
								// 정상적으로 검색이 완료됐으면 
								if (status === kakao.maps.services.Status.OK) {

									var coords = new kakao.maps.LatLng(
											result[0].y, result[0].x);
									removeMarker();

									// 결과값으로 받은 위치를 마커로 표시합니다
									var marker = new kakao.maps.Marker({
										map : map,
										position : coords
									});

									// 인포윈도우로 장소에 대한 설명을 표시합니다
									var infowindow = new kakao.maps.InfoWindow(
											{
												content : '<div style="width:150px;text-align:center;padding:6px 0;">'
														+ $(thisEle).children(
																".infoName")
																.text()
														+ '</div>'
											});
									infowindow.open(map, marker);

									// 지도 크기 조정
// 									$("#map").css("height", "300px");

									// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
									map.setCenter(coords);

								}
							});

		}

		// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
		function addMarker(position, idx, title) {
			var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
			imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
			imgOptions = {
				spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
				spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
				offset : new kakao.maps.Point(13, 37)
			// 마커 좌표에 일치시킬 이미지 내에서의 좌표
			}, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
					imgOptions), marker = new kakao.maps.Marker({
				position : position, // 마커의 위치
				image : markerImage
			});

			marker.setMap(map); // 지도 위에 마커를 표출합니다
			markers.push(marker); // 배열에 생성된 마커를 추가합니다

			return marker;
		}

		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
			for (var i = 0; i < markers.length; i++) {
				markers[i].setMap(null);
			}
			markers = [];
		}

		// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
		function displayPagination(pagination) {
			var paginationEl = document.getElementById('pagination'), fragment = document
					.createDocumentFragment(), i;

			// 기존에 추가된 페이지번호를 삭제합니다
			while (paginationEl.hasChildNodes()) {
				paginationEl.removeChild(paginationEl.lastChild);
			}

			for (i = 1; i <= pagination.last; i++) {
				var el = document.createElement('a');
				el.href = "#";
				el.innerHTML = i;

				if (i === pagination.current) {
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
			var content = '<div style="padding:5px;z-index:1;">' + title
					+ '</div>';

			infowindow.setContent(content);
			infowindow.open(map, marker);
		}

		// 검색결과 목록의 자식 Element를 제거하는 함수입니다
		function removeAllChildNods(el) {
			while (el.hasChildNodes()) {
				el.removeChild(el.lastChild);
			}
		}
	</script>
</body>
</html>