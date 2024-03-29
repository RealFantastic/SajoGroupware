<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>

   <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
   	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
   	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
   	
 	<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
 	<link href="<%=request.getContextPath()%>/resources/css/findPwd.css" rel="stylesheet">
 	<link href="<%=request.getContextPath()%>/resources/css/findId_modal.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet">
	
	<!-- JSTree -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
</head>
<body id="j_body">
<c:if test="${not empty msg }">
	<script>
		alert('${msg}');
	</script>
</c:if>
<jsp:include page="/WEB-INF/views/template_header.jsp"/>
	<form action="findPwd" method="post" name="findPwd">
		<div id="j_container">
			<div id="j_container1">
				<div id="j_container2" >
					<img id="j_logo_green"
					alt="mayo로고-초록색" 
					src="https://cdn.discordapp.com/attachments/976717450655694879/988136708518346832/unknown.png">
				</div>
				<div id="j_container3" class="j_div"> 
					<div id="j_emp_name" class="j_div">
						<label for="emp_name" class="font3">이름 : </label>
						<input type="text" id="emp_name" name="emp_name" placeholder="이름을 입력해주세요." required>
					</div>
					<div id="j_emp_no" class="j_div">
						<label for="emp_no" class="font3">사원번호 : </label>
						<input type="text" id="emp_no" name="emp_no" placeholder="아이디를 입력해주세요." maxlength="9" required> 
					</div>
					<div id="j_rrn" class="j_div">
						<label for="rrn" class="font3">주민번호 : </label>
						<input type="text" id="rrn" name="rrn" placeholder="주민번호를 입력해주세요." maxlength="14" required>
					</div>
				</div>
				<div id="j_btn" >
						<div class="j_div">
							<button type="button" id='find_pwd_btn' class="btn_yellow"
							onclick="findPwd_click()" >PW 찾기</button>
						</div>
						<div class="j_div">
						<button id="j_back_btn" type="button" 
						class="btn_gray">뒤로가기</button>
						</div>
				</div>
				<div id="j_logo_black">
					<img id="logo_black"
						alt="마요로고_검정" 
						src="https://cdn.discordapp.com/attachments/976717450655694879/996260321780047914/unknown.png">
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
                <h2>비밀번호 찾기</h2>
            </div>
            <div class="close-area">X</div>
            <div class="content" id="pwd_value">

             </div>
        </div>
    </div>
	<!-- 뒤로 가기 버튼 -->
	<script>
	   //뒤로 가기
	   $("#j_back_btn").click(function() {
	        var result = confirm('이전페이지로 이동하시겠습니까?'); 
	        if(result) { 
	            location.href="history.go(-1);";
	            } else { 
	            //no 
            	 location.href="history.go(0);";
	            }
	    });
	</script>
	    <!--주민번호 하이픈 정규식 DOM  -->
    <script>
	    $("#rrn").on("input",
	            function() {
	                var target = document.getElementById("rrn");
	                target.value = target.value.replace(/[^0-9]/g,'').replace(/^(\d{0,6})(\d{0,7})$/g, "$1-$2").replace(/(-{1,2})$/g,"");
	    }); 
	    

    </script>
	<script>
		/* 비밀번호 찾기 */ 
			// 비밀번호 값 받고 출력하는 ajax
			
			function findPwd_click(){
				var emp_name = $('#emp_name').val();
				var emp_no = $('#emp_no').val();
				var rrn =$('#rrn').val();
				
			    if(emp_name == "") {
					alert("이름을 입력해주십시오");
					$("#emp_name").focus();

					return false;
				}
				var replaceName = /^[가-힣a-zA-Z\s]+$/
					if(!replaceName.test(emp_name)){
						alert("성함은 한글, 영문만 입력 가능합니다.");
						$("#emp_name").val('');
						$("#emp_name").focus();
						return false;
					} 
			    if(emp_no == "") {
					alert("아이디를 입력해주십시오");
					$("#emp_no").focus();

					return false;
				}
		    	var regExpEmpNo = /^[0-9]{8,9}$/; //숫자9
		    	if(!regExpEmpNo.test(emp_no)){
		    		alert("유효하지 않는 아이디 입니다.");
		    		$("#emp_no").val('');
		    		$("#emp_no").focus();
		    		return false;
		    	}
			    if(rrn == "") {
					alert("주민번호를 입력해주십시오");
					$("#rrn").focus();
					return false;
				}
		    	//주민번호 형식 체크 
		    	var rrn = $("#rrn").val().trim();
		    	var regExpRrn = /^[0-9]{6}-[0-9]{7}$/; //숫자6-숫자7
		    	if(!regExpRrn.test(rrn)){
		    		alert("주민번호를 다시 확인해주세요.");
		    		$("#rrn").val('');
		    		$("#rrn").focus();
		    		return false;
		    	}
				
				$.ajax({
					url:"<%=request.getContextPath()%>/member/findPwd",
					type:"POST",
					data:{"emp_name":emp_name,"emp_no":emp_no ,"rrn":rrn} ,
					success:function(data){
						if(data == "fail"){
							$('.content').empty();
							var html = "";
							html += "<p style='color:red; font-weight:bold; '>회원정보를 다시 확인해주세요.</p>";
							$('.content').append(html);
							$('#emp_name').val('');
							$('#emp_no').val('');
							$('#rrn').val('');
							$('#emp_name').focus();
						} else {
							$('.content').empty();
							var html = "";
							html += "<p> 본인인증 후 비밀번호를 재설정해주세요.</p>";
			          		html += "<form action='<%=request.getContextPath()%>/member/chkFindPwd' method='get'>";
 			                //html += "<input type='email' class='form-control form-control-user'id='memberEmail' aria-describedby='emailHelp' name='email' placeholder='Enter Email Address...'>"    
	                        html += "<button type='submit' class='btn_yellow' id='emailChk_send_btn' name='emailChk_send_btn' required='required'>본인인증 하러가기</button>";
							html += "</form>";
				            //html += "</div>"; 
 							$('.content').append(html);
 							let url = " ";
							$('#emp_name').val('');
							$('#emp_no').val('');
							$('#rrn').val('');
						}
					},
					 error:function(){
			                alert("에러입니다");
			            }
				});
 			};
 			
		
		const modal = document.getElementById("modal")
		const btnModal = document.getElementById("find_pwd_btn")
		
		
		
		btnModal.addEventListener("click", e => {
			if($("#emp_name").val() != "" && $("#emp_no").val() && $("#rrn").val()){
				
			    modal.style.display = "flex"
				}
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