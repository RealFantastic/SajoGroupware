<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
   <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
   	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
   	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
   	
 	<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/findId.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/findId_modal.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet">
	
	<!-- JSTree -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
</head>
<body id="j_body">
<jsp:include page="/WEB-INF/views/template_header.jsp"/>
<%-- <jsp:include page="/WEB-INF/views/modal/findId_modal.jsp"/> --%>
<form action="findId" method="post" name="findId">
	<div id="j_container" class="w3-content w3-container w3-margin-top" >
		<div  id="j_container1" class="w3-container w3-card-4">
				
				<div id="j_container2"  >
					<div id="j_logo_green">
						<img id="logo_green" 
						alt="mayo로고_초록색" 
						src="https://cdn.discordapp.com/attachments/976717450655694879/988136708518346832/unknown.png">
					</div>
					<div id="j_container3">
					<div id="j_emp_name" class="j_div">
						<label for="emp_name" class="font3">이름 : </label>
						<input class="w3-input" type="text" id="emp_name" name="emp_name" placeholder="성함을 입력해주세요." required>
					</div>
					
					<div id="j_rrn" class="j_div">
						<label for="rrn" class="font3">주민번호:</label>
						<input class="w3-input" type="text" id="rrn" name="rrn" placeholder="주민번호를 입력해주세요." required>
					</div>
					</div>
					
					<div id="j_btn" >
						<div class="j_div">
							<button type="button" id='find_id_btn' onclick="findId_click()" 
							class="btn_green">ID찾기</button>
						</div>
						<div class="j_div">
						<button id="j_back_btn" type="button" onclick="history.go(-1);" 
						class="btn_gray">뒤로가기</button>
						</div>
					</div>
					
					<div id="j_logo_black">
						<img 
						id="logo_black"
						alt="마요로고_검정" 
						src="https://cdn.discordapp.com/attachments/976717450655694879/996260321780047914/unknown.png">
					</div>
				</div>
				<footer>
					<p class="mb-1" id="j_footer">&copy; 2022 참치 마요 주식회사 - 대표자 참지 않아 박정환</p>
				</footer>
				
		</div>
	</div>
	</form>
	
	<!--모달창 -->
	<div id="modal" class="modal-overlay">
        <div class="modal-window">
            <div class="title">
                <h2>아이디 조회 결과</h2>
            </div>
            <div class="close-area">X</div>
            <div class="content" id="id_value"></div>
        </div>
    </div>
	
	<script>
		/* 아이디 찾기 */ 
		//아이디 & 스토어 값 저장하기 위한 변수
			// 아이디 값 받고 출력하는 ajax
			function findId_click(){
				var emp_name = $('#emp_name').val();
				var rrn =$('#rrn').val();
				
				$.ajax({
					url:"<%=request.getContextPath()%>/member/findId",
					type:"POST",
					data:{"emp_name":emp_name, "rrn":rrn} ,
					success:function(data){
						if(data == "fail"){
							$('#id_value').text("회원 정보를 확인해주세요!");
							$('#emp_name').val('');
							$('#rrn').val('');
						} else {
							console.log(data);
							$('#id_value').text(data);
							$('#emp_name').val('');
							$('#rrn').val('');
							
						}
					},
					 error:function(){
			                alert("에러입니다");
			            }
				});
 			};
		
		const modal = document.getElementById("modal")
		const btnModal = document.getElementById("find_id_btn")
		
		btnModal.addEventListener("click", e => {
		    modal.style.display = "flex"
		})
		
		    
		const closeBtn = modal.querySelector(".close-area")
		closeBtn.addEventListener("click", e => {
		    modal.style.display = "none"
		})
		
		modal.addEventListener("click", e => {
		    const evTarget = e.target
		    if(evTarget.classList.contains("modal-overlay")) {
		        modal.style.display = "none"
		    }
		})
		
		
	</script>
</body>
</html>