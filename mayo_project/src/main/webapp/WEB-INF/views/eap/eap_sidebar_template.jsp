<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<aside id="side_bar_container">
    <div class="new_button">
        <button type="button" id="new_approval" class="btn_green" data-bs-toggle="modal" data-bs-target="#select_ea_form">
        새 결재 진행</button>
    </div>
    <hr id="contour">
    <div id="menulist">
        <ul>
            <li>
                <div class="top_menu" >
                    <a  class="top_menu_title" id="first_menu_title"><i class="fa-solid fa-caret-right" id="motion1"></i>결제하기</a>
                    <div class="sub_menu" id="first_sub">
                        <ul>
                            <li><a data-url="/eap/list/waitApprove">결재 대기 문서</a></li>
                            <li><a data-url="/eap/list/receptApprove">결재 수신 문서</a></li>
                        </ul>
                    </div>
                </div>
            </li>
            <li>
                <div class="top_menu" >
                    <a  class="top_menu_title" id="second_menu_title"><i class="fa-solid fa-caret-right" id="motion2"></i>개인 문서함</a>
                    <div class="sub_menu" id="second_sub">
                        <ul>
                            <li><a data-url="/eap/list/mylist">기안 문서함</a></li>
                            <li><a data-url="/">결재 문서함</a></li>
                            <li><a data-url="/">반려 문서함</a></li>
                        </ul>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</aside>
<!-- Modal -->
<div class="modal fade" id="select_ea_form" tabindex="-1" aria-labelledby="form_modal_itle" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="form_modal_itle">양식 선택</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <select class="form-select" aria-label="Default select example" name="formCategory" id="formCategory">
		  <option selected>양식 선택</option>
		  <!-- TODO 양식 테이블에서 데이터 받아서 넣어두기 -->
		  <c:if test="${not empty formlist }">
	  	 	<c:forEach items="${formlist }" var="list">
	  			<option value="${list.form_code}">${list.form_title}</option>
		  	</c:forEach>
		  </c:if>
		</select>
		<div class="form_sample"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary chooseForm">선택</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
<script>
 	  	$(".chooseForm").click(function(){
 	  		$('#select_ea_form').modal('hide');
// 			$('#home_my_draftedlist').hide();
			let selectForm = $('#formCategory').val();
			console.log(selectForm);
			switch(selectForm){
				case "AR":
					$('.content_page').children().hide();
					$('#vacationForm').show();
					$('.content_top').children('h1').text("휴가신청서");
					break;
				case "BP":
					$('.content_page').children().hide();
					$('#bpForm').show();
					$('.content_top').children('h1').text("업무기안");
					break;
				case "SR":
					$('.content_page').children().hide();
					$('#srForm').show();
					$('.content_top').children('h1').text("지출결의서");
					break;
			}
 	  	});

        $(".sub_menu").hide();
        $(".top_menu_title").click(function(){
            console.log($(this).attr('id'));
            if($(this).attr('id') == $("#first_menu_title").attr('id')){
                console.log("첫번째");
                $("#motion1").toggleClass('drop_motion');
                $("#first_sub").slideToggle(200);
            }else if($(this).attr('id') == $("#second_menu_title").attr('id')){
                $("#motion2").toggleClass('drop_motion');
                $("#second_sub").slideToggle(200);
            }
        });
        //각 메뉴 클릭시 POST로 페이지 이동
        $(".sub_menu>ul li a").click(function(e){
        	var url=$(e.target).data('url');
        	console.log(url);
        	let form = document.createElement('form');
        	form.setAttribute('method','POST');
        	form.setAttribute('action','<%=request.getContextPath()%>'+url);
        	document.body.appendChild(form);
        	form.submit();
        });
        
        
        
        
    </script>