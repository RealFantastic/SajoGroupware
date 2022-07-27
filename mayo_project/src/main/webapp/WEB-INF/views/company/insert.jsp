<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회사 등록</title>
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
   	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
   	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
   	
   	<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">  
	<link href="<%=request.getContextPath()%>/resources/css/cp_enroll.css" rel="stylesheet">
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
    <div style="padding: 50px;">
        <form id="cp_enroll" name="cp_enroll" action="<%=request.getContextPath()%>/company/enroll" method="post">
            <section>
            <div id="j_container">
            <p id="j_title">회사등록</p>
             <div id="j_container1">
                    <div id="j_cp_name" class="j_c">
                        <label for="cp_name" >회사명 : </label>
                        <input type="text" id="cp_name" name="cp_name" required>                       
                    </div>
                    <div id="j_cp_number" class="j_c">
                        <label>사업자 번호 : </label>
                        <input type="text" id="cp_number" name="cp_number" maxlength='12' required >
                        <button type="button" id="cp_number_btn" class="j_btn_gray" onclick = "checkNum()">조회</button>
                        <br><font id="check_result" size ="2"></font>
                    </div>
                    <div id="j_name" class="j_c">
                        <label>대표자 성함 : </label>
                        <input type="text" id="cp_king" name="cp_king" required>
                    </div>
                    <div id="j_cp_tel" class="j_c">
                        <label>전화번호 : </label>
                        <input type="text" id="cp_tel" name="cp_tel" maxlength="13" required>
                    </div>
                    <div class="j_c">
                        <label for="cp_category">업종 : </label>
                        <input type="text" id="selboxDirect" name="selboxDirect" />
                        <select id="cp_category" name="cp_category" required>
                            <option value="">선택</option>
                            <option value="도매">도매</option>
                            <option value="제조">제조</option>
                            <option value="건설">건설</option>
                            <option value="운송">운송</option>
                            <option value="유통">유통</option>
                            <option value="direct">직접입력</option>
                        </select>
                    </div>
                    <div id="j_addr">
                    <div class="j_c">
                        <label style="font-size: larger;">회사주소</label>
                    </div>
                    <div class="j_c">
                        <div>
                            <label>우편번호 : </label>
                            <input type="text" id="sample6_postcode" placeholder="우편번호" name="cp_postcode"
                            style="width: 45%; margin: 10px 0;" required="required">
                            <input type="button" onclick="sample6_execDaumPostcode()" class="j_btn_gray" value="우편번호 찾기"><br>
                        </div>
                        <div>
                            <label>주소 : </label>
                            <input type="text" id="sample6_address" placeholder="주소" name="cp_address" required="required"
                            style="width: 85%; margin: 0 0 10px 0; "><br>                        
                        </div>
                        <div>
                            <label>상세주소 : </label>
                            <input type="text" id="sample6_detailAddress" placeholder="상세주소" name="cp_detail_address" required="required"
                            style="width: 50%">
                            <input type="text" id="sample6_extraAddress" placeholder="참고항목" 
                            style="width: 100px;">
                        </div>
                    </div>
                    </div>

                </div>
                <div id="j_line" class="j_c">
                </div>
                <div id="j_container2">
                	<div id="j_birth" >
                	 <label id="j_birth_t" for="cp_birth" class="j_c">회사창립일 : </label>
                	 <input type="date"  id="cp_birth" name="cp_birth" placeholder="YYYY/MM/DD" required="required">	
                	</div>
                    <div id="j_email" class="j_c">
                        <label for="email_id" class="">이메일 : </label>
                        <div>
                        <input type="text" id="email_id" name="email_id" required="required">
                        <span id="middle">@</span>
                        <input type="text" id="domain" name="domain" required="required"/>
                        <select id="domain_list" name="domain_list" required="required">
                            <option value="naver.com">naver.com</option>
                            <option value="google.com">google.com</option>
                            <option value="hanmail.net">hanmail.net</option>
                            <option value="nate.com">nate.com</option>
                            <option value="kakao.com">kakao.com</option>
                            <option value="direct" >직접입력</option>
                          </select>
                            <button 
                               type="button"
                               id="emailChk_send_btn"
                               class="j_btn_gray" 
                               name="emailChk_send_btn" required="required">인증번호 전송</button>
                              <input type="hidden" id="totalemail" name="email" value="" required="required">
                        </div>
                    </div>

                    <div id="email_check" class="j_c">
                        <label>인증번호 : </label>
                        <input type="text" id="email_check_no" required="required">
                            <button type="button" id="email_check_btn" class="doubleChk" >인증</button>
 							<p class="point successEmailChk">이메일 입력후 인증번호를 인증 해주십시오.</p>
							<input type="hidden" id="emailDoubleChk" required="required"/>
                    </div>

                    <div id="clause">
                        <ul>
                            <li>
                                <hr id="j_cline">
                            </li>
                        <li>
                            <label><a>이용약관 동의</a>(필수)</label>
                            <input type="checkbox" class="clause" id="clause1" name="clause1" required>
                        </li>
                        <li>
                            <label><a>개인 정보 수집및 이용 동의</a>(필수)</label>
                            <input type="checkbox" class="clause" id="clause2" name="clause2" required>
                        </li>
                        <li>
                            <label><a>마케팅 정보 활용 및 광고성 정보 수신 동의</a>(선택)</label>
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
                    <button type="reset" class="btn_yellow" id="j_cancle_btn">뒤로가기</button>
                    <button type="submit" class="btn_green" id="j_enroll_btn">가입</button>
                </div>
            </div>
            </div>
            </section>
        </form>
        <footer>
            <p class="mb-1" id="j_footer">&copy; 2022 참치 마요 주식회사 - 대표자 참지 않아 박정환</p>
        </footer>
    </div>
    
    <!-- 가입 버튼 클릭 이벤트 -->
    <script> 
    $("#j_enroll_btn").click(function(){
    	   
		/*회사명 미기입시 alert창  */
 		if($("#cp_name").val() == '') {
			alert("회사명을 입력해주십시오");
			$("#cp_name").focus();
			return false;
		} 
		
		/*사업자 번호 형식 체크*/
 		var cp_number = $("#cp_number").val().trim();
		var regExpCp_number = /^[0-9]{3}-[0-9]{2}-[0-9]{5}$/; // 숫자3-숫자3,4-숫자4
		if(!regExpCp_number.test(cp_number)){
			alert("사업자번호 입력란에는 000-00-00000 형식으로 입력해주세요.");
			$("#cp_number").val('');
			$("#cp_number").focus();
			return false;
		} 	
		/* 사업자 성함 */
		var replaceName = /^[가-힣a-zA-Z\s]+$/
			if(!replaceName.test(cp_king)){
				alert("성함은 한글, 영문만 입력 가능합니다.");
				$("#cp_king").val('');
				$("#cp_king").focus();
				return false;
			} 	
			 
// 		$("#cp_king").on("focusout", function() {
// 		    var x = $(this).val();
// 		    if (x.length > 0) {
// 		        if (!x.match(replaceName)) {
// 		           alert("성함은 한글, 영문만 입력 가능합니다.");
// 		        } 
// 		    }
// 		});

    	/*전화번호 형식 체크*/
 		var phone = $("#cp_tel").val().trim();
		var regExpPhone = /^[0-9]{3}-[0-9]{3,4}-[0-9]{4}$/; // 숫자3-숫자3,4-숫자4
		if(!regExpPhone.test(phone)){
			alert("전화번호 입력란에는 000-0000-0000 형식");
			$("#cp_tel").focus();
			return false;
		} 
		
		/*회사 창립일 미기입시 */
	    if($("#cp_birth").val() == '') {
	    	alert("생년월일을 선택해주십시오");
	    	$("#cp_birth").focus();
	    	return false;
	    } 
		
		/* 약관 동의  */
		if($("#clause1").is(':checked') == false) {
		alert("필수 약관에 동의해주세요.");
		$("#clause1").focus();
		return false;
		}
		
		if($("#clause2").is(':checked') == false) {
			alert("필수 약관에 동의해주세요.");
			$("#clause2").focus();
			return false;
		}
		   
// 	var frm = $("#cp_enroll");
<%-- 	frm.attr("action","<%= request.getContextPath()%>/company/enroll");  --%>
// 	frm.attr("method","post");
// 	frm.submit(); 
// 	});
    
    </script>
    

    
    
    <!--사업자 번호 하이픈 정규식 DOM  -->
    <script>
    $("#cp_number").on("input",
            function() {
                var target = document.getElementById("cp_number");
                target.value = target.value.replace(/[^0-9]/g,'').replace(/^(\d{0,3})(\d{0,2})(\d{0,5})$/g, "$1-$2-$3").replace(/(-{1,2})$/g,"");
    }); 
    </script>
    <!--전화번호 하이픈 정규식 DOM  -->
    <script>
    $("#cp_tel").on("input",
            function() {
                var target = document.getElementById("cp_tel");
                target.value = target.value.replace(/[^0-9]/g,'').replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(-{1,2})$/g,"");
    }); 
    </script>
    

	<!-- 뒤로 가기 버튼 -->
	<script>
	   //뒤로 가기
	   $("#j_cancle_btn").click(function() {
	        var result = confirm('이전페이지로 이동하시겠습니까?'); 
	        if(result) { 
	            //yes //TODO 메인페이지로 이동
	            location.href="history.go(-1);";
	            } else { 
	            //no 
            	 location.href="history.go(0);";
	            }
	    });
	</script>
    <!-- 업종 select box 직접입력 -->
    <script>
        
        $(function inputbox(){

        //직접입력 인풋박스 기존에는 숨어있다가
        $("#selboxDirect").hide();
        $("#cp_category").change(function() {
            console.log("변했음.");
            //  직접입력을 누를 때 나타남
            if($(this).val()=="direct") {
                $("#selboxDirect").show();
                
            }  else {
                $("#selboxDirect").hide();
            }
            }) 
        });
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
            }) 
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
					$(".successEmailChk").text("유효한 이메일 주소를 입력해주세요.");
					$(".successEmailChk").css("color","red");
	        	}else{	        		
					alert("인증번호 발송이 완료되었습니다.\n입력한 이메일에서 인증번호 확인을 해주십시오.");
	        		$("#email_check_no").attr("disabled",false);
	        		$("#email_check_btn").css("display","inline-block");
	        		$(".successEmailChk").text("인증번호를 입력한 뒤 이메일 인증을 눌러주십시오.");
	        		$(".successEmailChk").css("color","black");
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
	function checkNum(){
			var cp_number = $('#cp_number').val();
			console.log("cp_number: "+cp_number);
			
			$.ajax({
				url:'<%=request.getContextPath()%>/company/check',
				type:"post",
				data: {"cp_number":cp_number},
// 				contentType:"json",
				success: function(result){
					console.log("result"+result);
					if(result == "false"){
						console.log("안녕");
						$("#check_result").html('이미 등록된 사업자번호 입니다');
						$("#check_result").attr('color','red');
					}else if(result == "ok"){
						$("#check_result").html('사업자번호가 등록되었습니다.');
						$("#check_result").attr('color','green');
					} 
				},
				error : function(){
					alert("서버요청실패");
				}
			
			});
			
		};
	
	</script>  
</body>
</html>