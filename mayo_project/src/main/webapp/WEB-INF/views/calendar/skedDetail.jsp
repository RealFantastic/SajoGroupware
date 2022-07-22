<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<c:choose>
<c:when test="${not empty sked }">
	<c:forEach var="sked" items="${sked}">
<div id="sked" class="modal-lg workBody">
  <div class="modal-dialog ">
    <div class="modal-content skedModal">
      <div class="modal-header">
      <div style="display: block;">
       <div>${sked.sked_no }</div>
        <h5 class="modal-title font3" style='font-weight: bold;'>${sked.sked_name }</h5>
		</div>		
		 <div>
			<form action="<%=request.getContextPath()%>/schedule/toUpdate" method="POST">
				<input type="hidden" name="sked_no" value="${sked.sked_no }">
				<button type='submit' class='btn_gray btn-modify sUpdate'>수정</button>
			</form>
				<button type='button' class='btn_red btn-delete deleteS'>삭제</button>
			</div>
		 </div>
      <div class="modal-body">
           <div class="date" style="display:flex;">
          	<div class="mb-3" style="margin-right:13px;">
            	<div class="col-form-label skedStart"><i class="fa-regular fa-calendar"></i> ${sked.sked_start_date } ~</div>
          	</div>
          	<div class="mb-3">
            	<div class="col-form-label skedEnd" style="color:red;"> ${sked.sked_end_date }</div>
          	</div>
          </div>
          <c:if test="${not empty sked.sked_location}">
         	 <div class="mb-3">
          		<i class="fa-solid fa-location-dot"></i> ${sked.sked_location }
          	<div id="maps" style="width:70%;height:350px;"></div>
			 </div>
			</c:if>
          <div class="mb-3">
            <div class="col-form-label skedContent">${sked.sked_content }</div>
          </div>
      </div>
      </div>
	</div>
	</div>
  </c:forEach>
</c:when>
	<c:otherwise>
		<div class="nothing font2">
		작성된 일정이 없습니다.
		</div>
	</c:otherwise>
</c:choose>	

<script>
// 일정 글 삭제하기
$(".deleteS").click(function(event){ 
	
console.log($(event.target).prev().children('input').val());
	
//삭제 여부 확인하기
var check = confirm("일정을 삭제하시겠습니까?");
var sked_no = $(event.target).prev().children('input').val();

	if(check){
		// ajax로 컨트롤러 이동 - delete
		$.ajax({
			type:"POST",
			url: "<%=request.getContextPath()%>/schedule/delete",
			data : {sked_no: sked_no},
		 // 일정 번호 들고가기
		success : function(result) {
			alert(result);
			location.reload();
			}
		});
	} else {
		return false;
	}
});

var container = document.getElementById('maps'), // 지도를 표시할 div 
	optionsS = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
	};
var mapS = new kakao.maps.Map(container, optionsS);
console.log(loca);

geocoder.addressSearch('제주특별자치도 제주시 첨단로 242', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
</script>
