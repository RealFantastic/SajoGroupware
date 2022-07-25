<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<header>
        <div id="menu_bar_container">
            <div id="logo">
                <a href="#">
                    <img src="<%=request.getContextPath()%>/resources/images/main_logo.png" alt="로고">
                </a>
            </div>
            <div id="menus_container">
                <ul id="menus" class="font3">
                    <li><a href="#">홈</a></li>
                    <li><a href="<%=request.getContextPath()%>/calendar/view">캘린더</a></li>
                    <li><a href="<%=request.getContextPath()%>/commute/status">근태관리</a></li>
                    <li><a href="<%=request.getContextPath()%>/project/list">업무관리</a></li>
                    <li><a href="<%=request.getContextPath()%>/holiday/list">연차관리</a></li>
                    <li><a href="#" data-bs-toggle="modal" data-bs-target="#empchart">조직도</a></li>
                    <li><a href="<%=request.getContextPath()%>/eap/main">전자결재</a></li>
                </ul>
                <div id="search_area">
                    <form action="#" method="post">
                        <input type="text" name="searchWord" id="searchBox" class="font2">
                        <button  id="s_button"><i class="fa-solid fa-magnifying-glass"></i></button>
                    </form>
                </div>
            </div>

            <div id="profile">
            	<c:choose>
            		<c:when test="${loginSsInfo.emp_no != null}">
		                <a href="#" class="dropdown_toggle">
		                    <img src="<%=request.getContextPath()%>/resources/images/default_profile_img.png" alt="프로필">
		                    <strong>${loginSsInfo.emp_name}</strong>
		                </a>
		                <ul class="dropdown_menu hide">
		                    <li><a href="#">내 정보</a></li>
		                    <li><a href="<%=request.getContextPath()%>/member/updatePwd">비밀번호 재설정</a></li>
		                    <li><a href="<%=request.getContextPath()%>/member/logout">로그아웃</a></li>
		 				</ul>                   
	 				</c:when> 
            		<c:when test="${loginSsInfo.emp_no != null && loginSsInfo.job_no == 10 }">
		                <a href="#" class="dropdown_toggle">
		                    <img src="<%=request.getContextPath()%>/resources/images/default_profile_img.png" alt="프로필">
		                    <strong>${loginSsInfo.emp_name}</strong>
		                </a>
		                <ul class="dropdown_menu hide">
		                    <li><a href="#">내 정보</a></li>
		                    <li><a href="<%=request.getContextPath()%>/member/updatePwd">비밀번호 재설정</a></li>
		                    <li><a href="<%=request.getContextPath()%>/member/invite">직원초대</a></li>
		                    <li><a href="<%=request.getContextPath()%>/member/logout">로그아웃</a></li>
		 				</ul>                   
	 				</c:when> 
	 				<c:otherwise>
		                <a href="#" class="dropdown_toggle">
		                    <img src="<%=request.getContextPath()%>/resources/images/default_profile_img.png" alt="프로필">
		                    <strong>Login or Join us!</strong>
	               		 </a>
						 <ul class="dropdown_menu hide">
							<li><a href="<%=request.getContextPath()%>/member/login">로그인</a></li>
							<li><a href="<%=request.getContextPath()%>/company/enroll">회원가입</a></li>
		                </ul>
	                </c:otherwise>
                </c:choose>
            </div>
        </div>
        <!-- Modal -->
		<div class="modal fade" id="empchart" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">조직도</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body" id="emp_info">
						<div id="emp_list">
							<input type="text" id="empchart_search">
							<div id="jstree_empchart">
							</div>
						</div>
						<div id="emp_detail_container">
							<div id="emp_detail">
								<img src="<%=request.getContextPath()%>/resources/images/default_profile_img.png">
								<table>
									<tr>
										<th>사원명</th>
										<td><input type="text" readonly="readonly" name="emp_name"></td>
									</tr>
									<tr>
										<th>전화번호</th>
										<td><input type="text" readonly="readonly" name="phone"></td>
									</tr>
									<tr>
										<th>이메일</th>
										<td><input type="text" readonly="readonly" name="email"></td>
									</tr>
									<tr>
										<th>생일</th>
										<td><input type="text" readonly="readonly" name="rrn"></td>
									</tr>
								</table>
							</div>
							<div id="emp_detail2">
								<table>
									<tr>
										<th scope="col">사원번호</th>
										<td><input type="text" readonly="readonly" name="emp_no"></td>
									</tr>
									<tr>
										<th scope="col">직위</th>
										<td><input type="text" readonly="readonly" name="job_name"></td>
									</tr>
									<tr>
										<th scope="col">부서</th>
										<td><input type="text" readonly="readonly" name="dept_name"></td>
									</tr>
									<tr>
										<th scope="col">입사일</th>
										<td><input type="text" readonly="readonly" name="hire_date"></td>
									</tr>
									<tr>
										<th scope="col">주소</th>
										<td><input type="text" readonly="readonly" name="address"></td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						
					</div>
				</div>
			</div>
		</div>
		<script>
		console.log("0");
		sessionStorage.setItem("contextPath","${pageContext.request.contextPath}");
		console.log("1");
		$(function () {
			orgChart($('#jstree_empchart'));
			var to = false;
			$('#empchart_search').keyup(function(event){
			  	var target = $(event.target);
				searchJstree(target);
			});
		});
		$("#jstree_empchart").bind('select_node.jstree',function(event,data){
			var emp_no = data.instance.get_node(data.selected).id;
			console.log(emp_no);
			$.ajax({
				url:'<%= request.getContextPath() %>/member/detail',
				type:"post",
				data:{emp_no : emp_no},
				dataType:"json",
				success:function(data){
// 					console.log(data);
					console.log(data.emp_name);
					$("#emp_detail table th td input").empty();
					$("#emp_detail2 table th td input").empty();
					$("input[name=emp_name]").val(data.emp_name);
					$("input[name=phone]").val(data.phone);
					$("input[name=email]").val(data.email);
					$("input[name=rrn]").val(data.rrn);
					$("input[name=emp_no]").val(data.emp_no);
					$("input[name=job_name]").val(data.job_name);
					$("input[name=dept_name]").val(data.dept_name);
					$("input[name=hire_date]").val(data.hire_date);
					$("input[name=address]").val(data.address);
				},
				error:function(){
					alert("동작실패");
				}		
			})
		});
		</script>
		<script>
			$("#searchBox").hover(function() {
				$("#s_button").css("border-top-right-radius", "20px");
				$("#s_button").css("border-bottom-right-radius", "20px");
			}, function() {
				$("#s_button").css("border-top-right-radius", "10px");
				$("#s_button").css("border-bottom-right-radius", "10px");
			});

			$("#searchBox").focusout(function() {
				$("#searchBox").val('');
				$("#s_button").css("border-top-right-radius", "10px");
				$("#s_button").css("border-bottom-right-radius", "10px");
			});
			$(".dropdown_toggle").click(function() {
				$(".dropdown_menu").toggleClass("hide");
			});
		</script>
    </header>
