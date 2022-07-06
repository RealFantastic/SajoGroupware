<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자결재</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>

<link href="<%=request.getContextPath() %>/resources/css/all_form.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/elec_approval_main.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet">
<!-- JSTree -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/mayoJstree.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/template_header.jsp"/>
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
                                <li><a href="#">결재 대기 문서</a></li>
                                <li><a href="#">결재 수신 문서</a></li>
                                <li><a href="#">결재 예정 문서</a></li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="top_menu" >
                        <a  class="top_menu_title" id="second_menu_title"><i class="fa-solid fa-caret-right" id="motion2"></i>개인 문서함</a>
                        <div class="sub_menu" id="second_sub">
                            <ul>
                                <li><a href="#">기안 문서함</a></li>
                                <li><a href="#">결재 문서함</a></li>
                                <li><a href="#">참조 문서함</a></li>
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
    <div id="bodyContent">
    	<div class="content_top">
			<h1> 전자결재 홈 </h1>
		</div>
		<div class="content_page">
			<div id="home_my_draftedlist">
				<h1>기안 진행중</h1>
				<div id="drafted_doc_table_container">
					<div>
						<table id="list_app">
							<thead>
								<tr>
									<th>기안일</th>
									<th>결재양식</th>
									<th>긴급</th>
									<th>제목</th>
									<th>첨부</th>
									<th>결재상태</th>
								</tr>
							</thead>
							<tbody>
								<!-- TODO : 결재 작성 후 리스트 뿌릴 예정 -->
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div id="vacationForm">
				<jsp:include page="/WEB-INF/views/ea_form/vacationForm.jsp"></jsp:include>
			</div>
			<div id="bpForm">
				<jsp:include page="/WEB-INF/views/ea_form/bpForm.jsp"></jsp:include>
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
    </script>
</body>
</html>