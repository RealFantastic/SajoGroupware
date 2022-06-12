<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헤더 메뉴바</title>
<script src="https://kit.fontawesome.com/ef09f998fc.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/template_header.css" rel="stylesheet">
</head>
<body>
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
                    <li><a href="#">캘린더</a></li>
                    <li><a href="#">근태관리</a></li>
                    <li><a href="#">업무관리</a></li>
                    <li><a href="#">연차관리</a></li>
                    <li><a href="#" data-bs-toggle="modal" data-bs-target="#exampleModal">조직도</a></li>
                    <li><a href="#">전자결재</a></li>
                </ul>
                <div id="search_area">
                    <form action="#" method="post">
                        <input type="text" name="searchWord" id="searchBox" class="font2">
                        <button  id="s_button"><i class="fa-solid fa-magnifying-glass"></i></button>
                    </form>
                </div>
            </div>
            <div id="profile">
                <a href="#" class="dropdown_toggle">
                    <img src="<%=request.getContextPath()%>/resources/images/default_profile_img.png" alt="프로필">
                    <strong>박박이</strong>
                </a>
                <ul class="dropdown_menu hide">
                    <li><a href="#">내 정보</a></li>
                    <li><a href="#">로그아웃</a></li>
                </ul>
            </div>
        </div>
        <!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
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
</body>
</html>