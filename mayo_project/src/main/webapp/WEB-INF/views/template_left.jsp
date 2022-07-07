<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<script type="text/javascript">
// 		현재시간  https://stickode.tistory.com/124 
function setClock(){
    var dateInfo = new Date(); 
    var hour = modifyNumber(dateInfo.getHours());
    var min = modifyNumber(dateInfo.getMinutes());
    var sec = modifyNumber(dateInfo.getSeconds());
    var year = dateInfo.getFullYear();
    var month = dateInfo.getMonth()+1; //monthIndex를 반환해주기 때문에 1을 더해준다.
    var date = dateInfo.getDate();
    document.getElementById("time").innerHTML = hour + ":" + min  + ":" + sec;
    document.getElementById("date").innerHTML = year + "년 " + month + "월 " + date + "일";
}
function modifyNumber(time) {
	if(parseInt(time)<10){
		return "0"+time;
	}else{
		return time;
	}
}
window.onload=function(){
	setClock();
	setInterval(setClock,1000); //1초마다 setClock 함수실행
			
			
// 		출퇴근시간 확인
	$.ajax({
		type:"post"
		,url:"<%=request.getContextPath()%>/commute/leftAttInfo"
		,dataType:"json"
		,success:function(result){
			console.log(result);
			var html="";
			if(result  == null){
				html += '<button class="btn_green btn_attendance" id="btn_attendance" >출근</button>';
				html += '<div id="timeAttendance" class="font3"></div>';
				html += '<div id="timeLeave" class="font3"></div>';
				html += '<button class="btn_green btn_leave" id="btn_leave" >퇴근</button>';
			}else{
				if(result.today_start_time == null){
					html += '<button class="btn_green btn_attendance" id="btn_attendance" >출근</button>';
				}else{
					html += '<div id="timeAttendance" class="font3">출근시간 : ' + result.today_start_time + '</div>';
				}
				if(result.today_end_time == null){
					html += '<div id="timeLeave" class="font3"></div>';
					html += '<button class="btn_green btn_leave" id="btn_leave" >퇴근</button>';
				}else{
					html += '<div id="timeLeave" class="font3">퇴근시간 : ' + result.today_end_time + '</div>';
					html += '<button class="btn_green btn_leave" id="btn_leave" >퇴근</button>';
				}
			}
			$("#leftAttInfo").html(html);
		},
		error:function(){
			alert("ajax 제대로 동작 못했다. 왜죠왜죠??");
		}
	});
	
	
	//	출근버튼 클릭시
	$(document).on("click", '#btn_attendance', function() {
		$.ajax({
			type:"post" //post or get
			,url:"<%=request.getContextPath()%>/commute/statusAtt"
			,dataType:"json"//받는자료형(@ResponseBody=스트링)
			,success:function(resultAtt){
				console.log(resultAtt);
				if(resultAtt == "fail"){
					alert("출근처리에 실패했습니다. 다시 시도하세요.");
				}else {
					console.log(resultAtt);
					$("#timeAttendance").text("출근시간 : " + resultAtt.today_start_time);
					//출근버튼 출근처리 후 사라짐
					$("#btn_attendance").addClass("complete_attend");
					
				}
			}
			,error:function(){
				alert("ajax 제대로 동작 못했다. 다시해라");
			}
		});
	});
		
	//	퇴근버튼 클릭시
	$(document).on("click", '#btn_leave', function() {

		//출근버튼을 누른 후 퇴근버튼을 누를 수 있음.
		if($("#timeAttendance").text() == 0 ){
			alert("출근처리가 되지않아 퇴근처리를 할 수 없습니다.");
			return;
		}
	

		$.ajax({
			type : "post"
			,url:"<%=request.getContextPath()%>/commute/statusLeave"
			,dateType:"json"
			,success:function(resultLeave){
				debugger
				console.log(resultLeave);
				if(resultLeave=="fail"){
					alert("퇴근처리 실패했습니다. 다시 시도하세요");
				}else{
// 					json형태로 들어와야 하는데 String 형태로 들어옴
					resultLeave = JSON.parse(resultLeave)
					$("#timeLeave").text("퇴근시간 : " + resultLeave.today_end_time);
				}
			}
			,error:function(){
				alert("ajax 제대로 동작하지않음. 다시보기");
			}
		});
	});
		
		
}



// // 		버튼 - 근무재시작 or 근무 외 시간
// 		$ (function() {
// 			$('#btn_off_on').click(function(){
// 				if($(this).html()=='근무 외 시간'){
// 					$(this).html('근무 재시작');
// 				}else{
// 					$(this).html('근무 외 시간');
// 				}
// 			});
// 		});
	</script>

	<div class="left_bar">
		<div class="left_bar_img">
			<img alt="" src="">
			이미지 자리<br>
			이미지 자리<br>
			이미지 자리<br>
			이미지 자리<br>
			이미지 자리<br>
			이미지 자리<br>
		</div>
		
		<div>
			<div id="date" class="left_bar_date font3"></div>
			<div id="time" class="left_bar_time font6"></div>
		</div>
		
		<div class="left_bar_btn" id="leftAttInfo"></div>
		
		<div>
		달력 자리<br>
		달력 자리<br> 
		달력 자리<br>
		달력 자리<br>
		달력 자리<br>  
		<!-- 혜리니자리 -->
		</div>
	</div>