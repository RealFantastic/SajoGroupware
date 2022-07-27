<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>

    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
   	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
   	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
   	
   	
   	<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/resources/css/emp_enroll.css" rel="stylesheet">   
	<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet"> 
	
	<!-- JSTree -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
	
 

    <!-- 다음 우편주소api  -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function sample6_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
    
                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수
                    var extraAddr = ''; // 참고항목 변수
    
                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }
    
                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if(data.userSelectedType === 'R'){
                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                            extraAddr += data.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if(data.buildingName !== '' && data.apartment === 'Y'){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if(extraAddr !== ''){
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        // 조합된 참고항목을 해당 필드에 넣는다.
                        document.getElementById("sample6_extraAddress").value = extraAddr;
                    
                    } else {
                        document.getElementById("sample6_extraAddress").value = '';
                    }
    
                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('sample6_postcode').value = data.zonecode;
                    document.getElementById("sample6_address").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("sample6_detailAddress").focus();
                }
            }).open();
        }
    </script>
    
		    
</head>
<body id="j_background">
<c:if test="${not empty msg }">
	<script>
		alert('${msg}');
	</script>
</c:if>
<jsp:include page="/WEB-INF/views/template_header.jsp"/>
    <div>
        <form id="emp_enroll" name="emp_enroll"
        	 action="<%=request.getContextPath()%>/member/enroll"
			 method="post" enctype="multipart/form-data">
            <section>
            <div id="j_container"
             style="
    			padding-top: 40px;
    			margin: 0 auto;
			    display: block;
			    position: relative;
			    top: 150px;">
            <p id="j_title">회원가입</p>
             <div id="j_container1">
                    <div id="j_cp_number" class="j_e">
                        <label>사업자 번호 : </label>
                        <input type="text" id="cp_number" name="cp_number" maxlength='12' required >
                        <button type="button" id="cp_number_btn" class="j_btn_gray">조회</button>
                        <div><font id="check_cp" class="feedback" size ="2"></font></div>
                    </div>             
                    <div id="j_name" class="j_e">
                        <label for="emp_name">성함 : </label>
                        <input type="text" id="emp_name" name="emp_name" required="required">
                        <br><font class="feedback" size ="2"></font>
                    </div>
                    <div id="j_emp_number" class="j_e">
                        <label for="rrn">주민 번호 : </label>
                        <input type="text" id="rrn" name="rrn" maxlength="14">
                        <button type="button" class="j_btn_gray" onclick = "checkRrn()">조회</button>
                        <div><font id="check_rrn" size ="2"></font></div>
                    </div>
                    <div class="j_e" id="j_dept">
                        <label for="dept_no">부서 : </label>
                        <select id="dept_no" name="dept_no" required="required">
                            <option value="">선택</option>
                            <option value="10">인사팀</option>
                            <option value="20">영업팀</option>
                            <option value="30">총무팀</option>
                            <option value="40">기획팀</option>
                            <option value="50">회계팀</option>
                            <option value="60">개발팀</option>
                            <option value="70">마케팅팀</option>
                            <option value="80">연구개발팀</option>
                        </select>
                        <br><font class="feedback" size ="2"></font>
                    </div>
                    <div class="j_e" id="j_job">
                        <label for="job_no">직위 : </label>
	                    <select name="job_no" id="job_no" required="required">
	                    	<option value="">선택</option>
	                    	<option value="1">사원</option>
	                    	<option value="2">대리</option>
	                    	<option value="3">과장</option>
	                    	<option value="4">차장</option>
	                    	<option value="5">부장</option>
	                    	<option value="6">이사</option>
	                    	<option value="7">대표</option>
	                    </select>
                    </div>
                    <div id="j_emp_no" class="j_e">
                        <label for="emp_no">아이디(사원번호) : </label>
                        <input type="text" id="emp_no" name="emp_no" maxlength="9" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required="required">
                        <button type="button" class="j_btn_gray" onclick = "checkNo()">조회</button>
                        <br><font id="check_result" size ="2"></font>
                    </div>
                    <div id="j_pwd" class="j_e">
                        <label>비밀번호 : </label>
                        <input type="password" id="password" name="password" class="j_pwd" required="required">
                        <br><font class="feedback" size ="2"></font>
                    </div>
                    <div id="j_pwd_chk" class="j_e">
                        <label for="password_chk">비밀번호 재확인 : </label>
                        <input type="password" id="password_chk" name="password_chk" class="j_pwd" required="required">
                        <br><font id="check_pwd" size ="2"></font>
                  </div>

                    <div class="j_e">
                        <label for="hire_date">입사일 : </label>
                        <input type="date" id="hire_date" name="hire_date" required="required"/>
                        <input type="hidden" name="total" value=""> 
                    </div>
                    <div>
                        <div id="j_email" class="j_e">
                            <label>이메일 : </label>
                            <div>
                            <input type="text" id="email_id" name="email_id" required="required">
                            <span id="middle">@</span>
                            <input type="text" id="domain" name="domain" />
                            <div id="domain_box" >
                            <select id="domain_list" name="domain_list" required="required">
                                <option value="naver.com">naver.com</option>
                                <option value="google.com">google.com</option>
                                <option value="hanmail.net">hanmail.net</option>
                                <option value="nate.com">nate.com</option>
                                <option value="kakao.com">kakao.com</option>
                                <option value="direct" >직접입력</option>
                              </select>
                              <button type="button"
                               id="emailChk_send_btn"
                               class="j_btn_gray" 
                               name="emailChk_send_btn">인증번호 보내기</button>
                               </div>
                              <input type="hidden" id="totalemail" name="email" value="" required="required">
                            </div>
                        </div>
    
                        <div id="email_check" class="j_e" >
                            <label>인증번호 : </label>
                            <input type="text" id="email_check_no" disabled required="required">
                            <button type="button" id="email_check_btn" class="doubleChk" >인증</button>
							<input type="hidden" id="emailDoubleChk" required="required"/>
							<br><font class="point successEmailChk"></font>
                        </div>
                    </div>

                </div>
                <div id="j_line" class="j_e">
                </div>
                <div id="j_container2">

                    <div>
                        <div class="j_e">
                            <label style="font-size: larger;">주소</label>
                        </div>
                        <div >
                            <div class="j_e">
                                <label for="sample6_postcode">우편번호 : </label>
                                <input type="text" id="sample6_postcode" placeholder="우편번호" name="emp_postcode" required="required">
                                <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="j_btn_gray"><br>
                            </div>
                            <div class="j_e" style=" width: 100%;">
                                <label for="sample6_address">주소 : </label>
                                <input type="text" id="sample6_address" placeholder="주소" name="address" required="required"><br>                        
                            </div>
                            <div class="j_e">
                                <label for="sample6_detailAddress">상세주소 : </label>
                                <input type="text" id="sample6_detailAddress" placeholder="상세주소" name="detail_address">
                          	    <input type="text" id="sample6_extraAddress" placeholder="참고항목" 
                            style="width: 100px;">
                            </div>
                        </div>
                        <br><font class="feedback" size ="2"></font>
                    </div>
                    <div id="j_emp_phone" class="j_e">
                        <label for="phone">전화번호 : </label>
                        <input type="text" id="phone" name="phone" maxlength="13" required="required">
                    </div>
                    <div class="j_e" id="j_pic_file">
                        <label for="pic_file">프로필 사진 : </label>
                        <input type="file" id="pic_file" name="pic_file" >
                    </div>
                    <div class="j_e" id="j_sign_file">
                        <label for="sign_file">서명파일 : </label>
                        <input type="file" id="sign_file" name="sign_file" >
                    </div>

                   <div id="clause">
                       <ul style="padding: 10px 3px;">
                           <li>
                               <hr id="j_cline">
                           </li>
	                        <li>
	                            <label for="clause1"><a>이용약관 동의</a>(필수)</label>
	                            <input type="checkbox" class="clause" id="clause1" name="clause1" required="required">
	                        </li>
	                        <li>
	                            <label for="clause2"><a>개인 정보 수집및 이용 동의</a>(필수)</label>
	                            <input type="checkbox" class="clause" id="clause2" name="clause2" required="required">
	                        </li>
	                        <li>
	                            <label for="clause3"><a>마케팅 정보 활용 및 광고성 정보 수신 동의</a>(선택)</label>
	                            <input type="checkbox" class="clause" id="clause3" name="clause3">
	                        </li>
	                        <li>
	                            <br>
	                            <label><a><strong>모두 동의 하기</strong></a></label>
	                            <input type="checkbox" class="clause" id="clauseAll" name="clauseAll">                                
	                        </li>
                  		 </ul>
              	 	</div>
                <div id="j_btn">
                    <button type="reset" class="btn_yellow">뒤로가기</button>
                    <button type="submit" class="btn_green" id="j_enroll_btn">가입</button>
                </div>
            </div>
            </div>
            </section>
        </form>
        <footer style="position: relative; top: 150px;">
            <p class="mb-1" id="j_footer">&copy; 2022 참치 마요 주식회사 - 대표자 참지 않아 박정환</p>
        </footer>
    </div>
    
    <script type="text/javascript">
    $("#j_enroll_btn").click(function(){
    	var password = $('input[name=password]').val();
    	
    	// 비밀번호 공란시 형식 체크
	    if($("#password").val() == "") {
			alert("비밀번호를 입력해주십시오");
			$("#password").focus();
			return false;
		}
	    
	    // 비밀번호 재입력 공란시 형식 체크 
	    if($("#password_chk").val() == "") {
			alert("비밀번호를 한번 더 입력해주십시오");
			$("#password_chk").focus();
			return false;
		}
	    //비밀번호 형식 체크
		var regExpPassword = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}$/; // 영문자, 숫자가 적어도 1개이상, 8~16글자
		if(!regExpPassword.test(password)){
			alert("패스워드 입력란에는 영문자, 숫자가 적어도 1개이상, 8~16글자를 입력해주세요.");
			$("#password").val("");
			$("#password_chk").val("");
			$("#password").focus();
			return false;
		}
    	//사업자 번호 형식 체크 
    	var cp_number = $("#cp_number").val().trim();
    	var regExpCpnum = /^[0-9]{3}-[0-9]{2}-[0-9]{5}$/; // 숫자3-숫자2-숫자5
    	if(!regExpCpnum.test(cp_number)){
    		alert("사업자번호 입력란에는 000-00-00000 형식으로 입력해주세요.");
    		$("#cp_number").val('');
    		$("#cp_number").focus();
    		return false;
    	}
    	//주민번호 형식 체크 
    	var rrn = $("#rrn").val().trim();
    	var regExpRrn = /^[0-9]{6}-[0-9]{7}$/; //숫자6-숫자7
    	if(!regExpRrn.test(rrn)){
    		alert("주민번호 입력란에는 000-00-00000 형식으로 입력해주세요.");
    		$("#rrn").val('');
    		$("#rrn").focus();
    		return false;
    	}
    	//사원번호 형식 체크 
    	var emp_no = $("#emp_no").val().trim();
    	var regExpEmpNo = /^[0-9]{9}$/; //숫자9
    	if(!regExpEmpNo.test(emp_no)){
    		alert("사원번호 입력란에는 000000000 형식으로 입력해주세요.");
    		$("#emp_no").val('');
    		$("#emp_no").focus();
    		return false;
    	}
    	//핸드폰 번호 형식 체크 
    	var phone = $("#phone").val().trim();
    	var regExpPhone = /^[0-9]{3}-[0-9]{4}-[0-9]{4}$/; // 숫자3-숫자4-숫자4
    	if(!regExpPhone.test(phone)){
    		alert("전화번호 입력란에는 000-0000-0000 형식으로 입력해주세요.");
    		$("#phone").val('');
    		$("#phone").focus();
    		return false;
    	}
    	


    });	
    </script>
    
    
    <!-- 비밀번호 재확인  -->
    <script type="text/javascript">
    $('.j_pwd').keyup(function() {
    	let password = $("#password").val().trim();
    	let password_chk = $("#password_chk").val().trim();
    	
    	if(password != " " || password_chk != " "){
    		if(password == password_chk){
    			console.log("password :"+password);
    			console.log("password_chk :"+password_chk);
    			$("#check_pwd").html('비밀번호가 일치 합니다.');
    			$("#check_pwd").attr('color','green');
    			$("#j_enroll_btn").attr("disabled",false);
    		}else {
    			$("#check_pwd").html('비밀번호가 일치하지 않습니다.');
    			$("#check_pwd").attr('color','red');
    			$("#j_enroll_btn").attr("disabled",true);
    		}
    	}
    		
	});

    </script>
    <!--전화번호 하이픈 정규식 DOM  -->
    <script type="text/javascript">
    $("#phone").on("input",function() {
        var target = document.getElementById("phone");
        target.value = target.value.replace(/[^0-9]/g,'').replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(-{1,2})$/g,"");
	});
    
    </script>
    <!--사업자 번호 하이픈 정규식 DOM  -->
    <script>
	    $("#cp_number").on("input",
	            function() {
	                var target = document.getElementById("cp_number");
	                target.value = target.value.replace(/[^0-9]/g,'').replace(/^(\d{0,3})(\d{0,2})(\d{0,5})$/g, "$1-$2-$3").replace(/(-{1,2})$/g,"");
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

    
    <!--아이디 중복체크-->
	<script type="text/javascript">
	function checkNo(){
			var emp_no = $('#emp_no').val();
			console.log("emp_no: "+emp_no);
			
			$.ajax({
				url:'<%=request.getContextPath()%>/member/checkno',
				type:"post",
				data: {"emp_no":emp_no},
				success: function(result){
					console.log("result:"+result);
					if(result == "false" ){
						console.log("안녕");
						$("#check_result").html('사원번호를 다시 확인해주세요.');
						$("#check_result").attr('color','red');
						$("#j_enroll_btn").attr("disabled",true);
					}else if(result == "ok" ){
						$("#check_result").html('사원번호가 확인 되었습니다.');
						$("#check_result").attr('color','green');
						$("#j_enroll_btn").attr("disabled",false);
					} 
				},
				error : function(){
					alert("서버요청실패");
				}
			
			});
			
		};
	
	</script>  
	
	<!--주민번호 중복체크-->
	<script type="text/javascript">
	function checkRrn(){
			var rrn = $('#rrn').val();
			console.log("rrn: "+rrn);
			
			$.ajax({
				url:'<%=request.getContextPath()%>/member/checkrrn',
				type:"post",
				data: {"rrn":rrn},
				success: function(result){
					console.log("result"+result);
					if(result == "false" || result == null){
						console.log("안녕");
						$("#check_rrn").html('주민번호를 다시 확인해주십시오.');
						$("#check_rrn").attr('color','red');
						$("#j_enroll_btn").attr("disabled",true);
					}else if(result == "ok"){
						$("#check_rrn").html('주민번호가 확인 되었습니다.');
						$("#check_rrn").attr('color','green');
						$("#j_enroll_btn").attr("disabled",false);
					} 
				},
				error : function(){
					alert("서버요청실패");
				}
			
			});
			
		};
	
	</script>  
	<!-- 이메일 합치기 -->
	<script type="text/javascript">
		//이메일주소 가져오기
		$("#email_id").blur(function(){
			email();	
		});
		
		$("#domain_list").change(function(){
			email();	
		});
	
		function email() {
			const email = $("#email_id").val();
			const middle = $("#middle").text();
			const address = $("#domain_list").val();
			if(email != "" && address != "") {
				$("#totalemail").val(email+middle+address);
			}
		};
	</script>

    <!-- 이메일 직접입력 -->
    <script>
        $(function (){

        //직접입력 인풋박스 기존에는 숨어있다가
        $("#domain").hide();
        $("#domain_list").change(function() {
            console.log("변했음.");
            //  직접입력을 누를 때 나타남
            if($(this).val()=="direct") {
                $("#domain").show();
                
            }  else {
                $("#domain").hide();
            }
        }); 
           
        /* holiday */
        $("#hire_date").change(function(e){
   			var hire_date = $(e.target).val().split('-');
        	var hd = new Date(hire_date[0],hire_date[1],hire_date[2]);
        	var td = new Date(); //오늘날짜

        	var hy = hd.getFullYear(); 
        	var dy = td.getFullYear();
 
        	var holiday = Math.abs(dy-hy);
        	var totalHoliday = 0;
        	if(holiday > 0 && holiday < 3){
//        		totalHoliday
        		totalHoliday = 15;
        	} else if(holiday >= 3){
        		totalHoliday = 16;
        	}
        	$("input[name=total]").val(totalHoliday);
        	
        });
		            
        });
   
    </script>
    <!-- 이메일 인증 -->
    <script>
	var code = "";
	$("#emailChk_send_btn").click(function(){
		var email = $("#totalemail").val();
		$.ajax({
	        type:"GET",
	        url:"mailCheck?email=" + email,
	        cache : false,
	        success:function(data){
	        	if(data == "error"){
	        		alert("이메일 주소가 올바르지 않습니다. 유효한 이메일 주소를 입력해주세요.");
					$("#totalemail").attr("autofocus",true);
					$(".successEmailChk").html("유효한 이메일 주소를 입력해주세요.");
					$(".successEmailChk").css("color","red");
	        	}else{	        		
					alert("인증번호 발송이 완료되었습니다.\n입력한 이메일에서 인증번호 확인을 해주십시오.");
	        		$("#email_check_no").attr("disabled",false);
	        		$("#email_check_btn").css("display","inline-block");
	        		$(".successEmailChk").html("인증번호을 입력하여 인증을 완료해주세요.");
	        		$(".successEmailChk").css("color","blue");
	        		code = data;
	        	}
	        }
	    });
	});
	</script>
	<!-- 이메일 인증번호 대조  -->
	<script type="text/javascript">
		$("#email_check_btn").click(function(){
		if($("#email_check_no").val() == code){
			$(".successEmailChk").text("인증번호가 일치합니다.");
			$(".successEmailChk").css("color","green");
			$("#emailDoubleChk").val("true");
			$("#email_check_no").attr("disabled",true);
		}else{
			$(".successEmailChk").text("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
			$(".successEmailChk").css("color","red");
			$("#emailDoubleChk").val("false");
			$("#email_check_no").attr("autofocus",true);
			$("#j_enroll_btn").attr("disabled",true);
		}
	});
	</script>

    <!-- 약관 모두 동의 -->
    <script>
        $(document).ready( function() {
          $( "#clauseAll" ).click( function() {
            $( '.clause' ).prop( 'checked', this.checked );
          } );
        } );
     </script>
   <!--사업자 번호 중복체크  -->
	<script type="text/javascript">
	
		 $("#cp_number_btn").click(function(){
				var cp_number = $('#cp_number').val();
				console.log("cp_number: "+cp_number);
				
				$.ajax({
					url:'<%=request.getContextPath()%>/member/checkcpnum',
					type:"post",
					data: {"cp_number":cp_number},
					success: function(result){
						console.log("result:"+result);
						if(result == "false" || result == null){
							console.log("result:"+result);
							$("#check_cp").html('등록되지 않은 사업자번호 입니다.');
							$("#check_cp").attr('color','red');
							$("#j_enroll_btn").attr("disabled",true);
						}else if(result == "ok" || result != null){
							console.log("result:"+result);
							$("#check_cp").html('사업자번호가 확인 되었습니다.');
							$("#check_cp").attr('color','green');
						} 
					},
					error : function(){
						alert("서버요청실패");
					}
				
				});
				
		 });
	
	</script>  
</body>
</html>