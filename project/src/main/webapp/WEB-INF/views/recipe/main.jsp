<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
html {
	height: 100%;
}

body {
	
	min-height: 100%;
	/* left : 100px; */
	/* display: flex;
    justify-content: center; /* 가로 가운데 정렬 */
   /*  align-items: center; */ /* 세로 가운데 정렬 */
    /* height: 100vh; */ /* 화면 전체 높이를 사용하여 세로 중앙 정렬 */
    /* margin: 0; */
}
.totalBody{
	/* transform: translateX(15%); */
}

.listHeader {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 1200px;
  }

.listHeader h3 {
    border: 2px solid #000;
    text-align: center;
    margin: 0;
    padding: 5px;
  }

  .listHeader button {
    border: none;
    background-color: transparent;
    cursor: pointer;
  }
  
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border: 2px solid #000;
    padding: 5px 10px;
    
    hegith : 50px;
  }

.header h3 {
    margin: 0;
}


.div_BoomUpList {
	width : 230px;
	height : 400px;
	overflow: hidden;
	border: 2px solid;
	display: inline-block;
}

.div_BoomUpList img {
	width: 100%;
	height : 50%;
}

.div_ViewCntList {
	width : 230px;
	height : 400px;
	overflow: hidden;
	border: 2px solid;
	display: inline-block;
}
.div_ViewCntList img{
	width: 100%;
	height : 50%;
}


.div_ReplyCntList {
	width : 230px;
	height : 400px;
	overflow: hidden;
	border: 2px solid;
	display: inline-block;
}

.div_ReplyCntList img{
	width: 100%;
	height : 50%;
}

.div_RecentList {
	width : 230px;
	height : 400px;
	overflow: hidden;
	border: 2px solid;
	display: inline-block;
}

.div_RecentList img{
	width: 100%;
	height : 50%;
}


.swiper-container {
	width: 1200px; /* 슬라이드 컨테이너 너비 */
	height: 500px; /* 슬라이드 컨테이너 높이 */
	overflow: hidden; /* 너비를 벗어나는 이미지 숨기기 */
	position: relative; /* 슬라이드 위치를 조정하기 위해 필요 */
}

/* .div_recentRecipeList {
	border: 2px solid;
	display: inline-block
} */
/* div, ul, li {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
	padding: 0;
	margin: 0
} */
a {
	text-decoration: none;
}

.content {
	position: relative;
	min-height: 1000px;
}

#main-content {
	margin-top: 10px;
	margin-right: 20px;
	/* width: 300px; 
	height: 400px; 
	position: fixed; 
	right:0; 
	bottom:0;
	 overflow: auto; */
}

#chatBox {
 	display: none;
	background-color: white;
	border: 4px solid;
	/*right: 0;
	bottom: 0; */
	width: 300px;
	height: 400px;
}


.totalListSize{
	width: 1200px;
	display: inline-block;
}
</style>
<%@ include file="../common/header.jsp" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=6j3xj4ny38&submodules=geocoder"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />

</head>
<body>
<div class="totalBody">
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide" style="position: relative;">
				<h3 class="slide" style="top: 30%; left: 40%; font-size:x-large; font-weight:bolder; position: absolute; margin: auto; text-align: center" > <!-- /* top: 50%; left: 40%;" */  -->
					요리하기 전에 잠깐!<br>손은 깨끗이 씻으셨나요?
				</h3>
			</div>
			<div class="swiper-slide" style="position: relative;">
				<h3 style="text-align: center; font-weight: bolder; font-size: 25px;">2022년 한 해 월별 사고 건 수</h3>
				<canvas id="MonthData_Chart"  width="1000" height="400" style="margin: auto;"></canvas>
			</div>
			<div class="swiper-slide" style="position: relative;">
				<h3 style="text-align: center; font-weight: bolder; font-size: 25px;">2022년 한 해 지역별 사고 건 수</h3>
				<canvas id="RegionData_Chart" width="1000" height="400" style="margin: auto;"></canvas>
			</div>
			<div class="swiper-slide" style="position: relative;">
				<h3 style="text-align: center; font-weight: bolder; font-size: 25px;">2022년 한 해 장소별 사고 건 수</h3>
				<canvas id="LocationData_Chart" width="1000" height="50px" style="margin: auto;"></canvas>
			</div>
			<div class="swiper-slide" style="position: relative;">
				<h3 class="slide" style="top: 10%; left: 40%; font-size:x-large; font-weight:bolder; position: absolute; margin: auto; text-align: center" ><!--  /* top: 50%; left: 40%;" */ -->
					이<br> 캠페인은 
					<br><img src="/resources/img/Ministry_of_Food_and_Drug_Safety(vertical).png" style="width: 400px; height: 300px ;"><br> 와 함께 합니다.
				</h3>
			</div>
		</div>
		<div class="swiper-button-prev"></div>
		<div class="swiper-button-next"></div>
	</div>
	<br><br>
	<!-- [참고] 깃헙 토큰 : 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 -->

	<div class="listHeader"> 
		<h3 style="border: 2px solid #000; text-align: center; margin: 0 auto;" >추천수 많은거 <button id="BoomUpListHide" style="left:80%">숨기기▼</button></h3>
	</div>
	<br>
	<div class="totalListSize">
	<c:forEach var="BoomUpList" items="${BoomUpList}" begin="0" end="4" step="1">
		<div class="div_BoomUpList">
			<img src="/display?fileName=${BoomUpList.savePath}">
			<a id="imghref" onclick="" data-value="${BoomUpList.title }" style="overflow: hidden;" >제목 : ${BoomUpList.title }</a>
			<p>닉네임 : ${BoomUpList.nickName } </p>
			<p>추천 수 : ${BoomUpList.boomup } </p>
		</div>
	</c:forEach>
	</div>
	<br>
	
	
	<div class="listHeader"> 
		<h3 style="border: 2px solid #000; text-align: center; margin: 0 auto;">조회수 많은거 <button id="ViewCntListHide" style="left:80%">숨기기▼</button></h3>
	</div>
	<br>
	<div class="totalListSize">
	<c:forEach var="ViewCntList" items="${ViewCntList}" begin="0" end="4" step="1">
		<div class="div_ViewCntList">
			<img src="/display?fileName=${ViewCntList.savePath}">
			<a id="imghref" onclick="" data-value="${ViewCntList.title }" class="imghref">제목 : ${ViewCntList.title }</a>
			<p>닉네임 : ${ViewCntList.nickName }</p>
			<p>조회 수 : ${ViewCntList.viewCnt }</p>
		</div>
	</c:forEach>
	<br>
	</div>
	
	<div class="listHeader"> 
		<h3 style="border: 2px solid #000; text-align: center; margin: 0 auto;" >댓글수 많은거 <button id="ReplyCntListHide" style="left:80%">숨기기▼</button></h3>
	</div>
	<br>
	<div class="totalListSize">
	<c:forEach var="ReplyCntList" items="${ReplyCntList}" begin="0" end="4" step="1">
		<div class="div_ReplyCntList">
			<img src="/display?fileName=${ReplyCntList.savePath}">
			<a id="imghref" onclick="" data-value="${ReplyCntList.title }" class="imghref">제목 : ${ReplyCntList.title }</a>
			<p>닉네임 : ${ReplyCntList.nickName }</p>
			<p>댓글 수 : ${ReplyCntList.replyCnt }</p>
		</div>
	</c:forEach>
	<br>
	</div>
	
	<div class="listHeader"> 
		<h3 style="border: 2px solid #000; text-align: center; margin: 0 auto;">최근 등록 <button id="RecentListHide" style="left:80%">숨기기▼</button></h3>
	</div>
	<br>
	<div class="totalListSize">
	<c:forEach var="RecentList" items="${RecentList}" begin="0" end="4" step="1">
		<div class="div_RecentList">
			<img src="/display?fileName=${RecentList.savePath}">
			<a id="imghref" onclick="" data-value="${RecentList.title }" class="imghref">제목 : ${RecentList.title }</a>
			<p>닉네임 : ${RecentList.nickName }</p>
			<p>등록일 : ${RecentList.regdate }</p>
		</div>
	</c:forEach>
	</div>
	<br><br>
	
	<!-- //6. 챗봇 -->
	<!-- <h1>무엇이든 물어보세요!</h1> -->
	<%-- <div id="main-content" class="container" style="">
		<div class="row">
			<div class="col-md-5">
				<form class="form-inline">
					<div class="form-group">
						<!-- <button id="connect" class="btn btn-default" type="submit"> -->
							<img id="connect" src="/resources/img/pingwing-bee_happy.png" style="width:150px; height:150px; position: fixed; right:0; bottom:0;">
						<!-- </button> -->
						<button id="disconnect" class="btn btn-default" type="submit" disabled="disabled" style="display: none">해제</button>
					</div>
				</form>
			</div>
			<div id="chatBox"class="col-md-row" >
				<div class="col-md-6">
					<table id="conversation" class="table table-striped">
						<thead>
							<tr>
								<th>메세지</th>
							</tr>
						</thead>
						<tbody id="showMessage"></tbody>
					</table>
				</div>
				<div class="col-md-7" > <!-- style="position: fixed; bottom: 0;" -->
					<form class="form-inline">
						<div class="form-group" >
							<input type="text" id="msg" class="form-control" placeholder="궁금한 내용을 알려주세요.">
							<button id="send" class="btn btn-default" disabled type="submit" >전송</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div> --%>
	
	<!-- <img src="/resources/img/Ministry_of_Food_and_Drug_Safety(vertical).svg.png" style="width:130px; height:100px;"> -->
	<!-- <input type="text" id="textext"> -->
	

<!-- //7. 네이버 지도-->
<h3 style="text-align: center">식품 의약 안전처가 인증한 모범 식당 찾아보기!</h3>
<div id="map" style="width: 1200px; height: 500px;">
	<div style="position: relative; z-index: 100">
		<input type="text" id="searchRestaurantAddress" placeholder="주소를 입력해 주세요" style="font-weight: border;">
		<input type="text" id="searchRestaurantName" placeholder="상호명을 입력해 주세요" style="font-weight: border;">
		<label style="font-weight: 1500; font-size: large;">
		<input type="radio" value="한식" id="koreaFood" name="foodCheckBox" style="font-weight: border; font-size: large; " checked="checked">한식
		<input type="radio" value="중식" id="chinaFood" name="foodCheckBox" style="font-weight: border; font-size: large; ">중식
		<input type="radio" value="일식" id="japanFood" name="foodCheckBox" style="font-weight: border; font-size: large; ">일식
		</label>
		<button type="submit" id="searchRestaurant" class="searchRestaurant" style="left: 35%; top: 10%">검색</button>
		<button id="resetRestaurant" class="resetRestaurant" style="left: 35%; top: 10%">초기화</button>
	</div>
</div>
<br><br>

</div><!-- totalBody -->
</body>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script>
$('#BoomUpListHide').click(function (element){
	 var elements = document.querySelectorAll('.div_BoomUpList');
	 
	 elements.forEach(function (element) {
	        if (element.style.display === 'none') {
	            element.style.display = 'inline-block';
	        } else {
	            element.style.display = 'none';
	            //elements.style.display = '';
	        }
	    });
});

$('#ViewCntListHide').click(function (element){
	 var elements = document.querySelectorAll('.div_ViewCntList');
	 
	 elements.forEach(function (element) {
	        if (element.style.display === 'none') {
	            element.style.display = 'inline-block';
	        } else {
	            element.style.display = 'none';
	        }
	 });
});

$('#ReplyCntListHide').click(function (element){
	 var elements = document.querySelectorAll('.div_ReplyCntList');
	 
	 elements.forEach(function (element) {
	        if (element.style.display === 'none') {
	            element.style.display = 'inline-block';
	        } else {
	            element.style.display = 'none';
	        }
	 });
});

$('#RecentListHide').click(function (element){
	 var elements = document.querySelectorAll('.div_RecentList');
	 
	 elements.forEach(function (element) {
	        if (element.style.display === 'none') {
	            element.style.display = 'inline-block';
	        } else {
	            element.style.display = 'none';
	        }
	 });
});

$(document).ready(function() {
//★		
	//1. 네이버 지도
	var RestaurantData = JSON.parse(`${restaurantData1}`);
	var RELAX_Data_List = [];
	for (var i = 0; i < RestaurantData.length; i++) { 
		var RELAX_DATA = {
			RELAX_ADD1: RestaurantData[i].RELAX_ADD1,
			RELAX_GUBUN_DETAIL: RestaurantData[i].RELAX_GUBUN_DETAIL,
			RELAX_RSTRNT_NM: RestaurantData[i].RELAX_RSTRNT_NM,
			RELAX_RSTRNT_TEL: RestaurantData[i].RELAX_RSTRNT_TEL
		}
		RELAX_Data_List.push(RELAX_DATA);
	}
	
	// 현재 위치로 이동 이미지
	var curtBtn = '<img src="/resources/img/free-icon-location-5582962 (1).png" alt="현재위치로 이동">';

	// 현재 위치 위도, 경도 좌표 객체를 담을 변수
	var curtLoca = "";

	// Map 초기화
	var map = new naver.maps.Map('map', {
	    center: new naver.maps.LatLng(37.3595704, 127.105399),    // X, Y 값 설정
	    scaleControl: false,      // 우측 하단 scale 표시
	    mapDataControl: false,    // 좌측 하단 @ NAVER Corp 표시
	    zoom: 17                  // 지도 줌 레벨
	});

	// getCurrentPosition 성공 콜백 함수
	var onSuccessGeolocation = function (position) {
	    // 현재위치
	    curtLoca = new naver.maps.LatLng(position.coords.latitude, position.coords.longitude);

	    // 얻은 좌표를 지도의 중심으로 설정합니다.
	    map.setCenter(curtLoca);
	    
	    // 지도의 줌 레벨을 변경합니다.
	    map.setZoom(17); 
	        
	    // 현재 위치에 마커 표시
	    new naver.maps.Marker({
	        position: curtLoca,
	        map: map,
	        icon: { url: "/resources/img/free-icon-location-5582962 (1).png" }
	    });
	}

	// getCurrentPosition 에러 콜백 함수
	var onErrorGeolocation = function () {

	    var agent = navigator.userAgent.toLowerCase(), name = navigator.appName;

	    if (name === 'Microsoft Internet Explorer' || agent.indexOf('trident') > -1 || agent.indexOf('edge/') > -1) {
	        alert("지원하지 않는 브라우져입니다.");
	    }
	    else {
	        console.log("현재 위치를 가져오는데 에러가 발생하였습니다.");
	    }
	}

	// Geolocation HTML5 API를 통해 얻은 현재 위치 좌표로 지도를 이동합니다.
	if (navigator.geolocation) {
	    /**
	     * navigator.geolocation 은 Chrome 50 버젼 이후로 HTTP 환경에서 사용이 Deprecate 되어 HTTPS 환경에서만 사용 가능 합니다.
	     * http://localhost 에서는 사용이 가능하며, 테스트 목적으로, Chrome 의 바로가기를 만들어서 아래와 같이 설정하면 접속은 가능합니다.
	     * chrome.exe --unsafely-treat-insecure-origin-as-secure="http://example.com"
	     */
	    navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);
	}
	else {
	    console.log("Geolocation Not supported Required");
	}

	///////////////////////////////
	//console.log('여기는 for문 : RELAX_ADD1SearchList', RELAX_Search_List);
	var RELAX_Search_List = [];	// 검색한 값이 들어갈 공간

	//맨 시작
	var markers = [];
	var infoWindows = [];

	$('.searchRestaurant').click(function() {
		var searchRestaurantAddress = document.getElementById('searchRestaurantAddress').value; //입력한 값
		var searchRestaurantName = document.getElementById('searchRestaurantName').value; 
		var RELAX_Check_List = document.querySelectorAll('input[name="foodCheckBox"]:checked'); 
		var selectedGubunValues = Array.from(RELAX_Check_List).map(radio => radio.value); //선택한 값
		var RELAX_Search_List = RestaurantData.filter(item => 
	    	item.RELAX_ADD1.includes(searchRestaurantAddress) 
	    	&& 
	    	item.RELAX_RSTRNT_NM.includes(searchRestaurantName)
		);

		if (RELAX_Search_List.length === 0) {
	    	alert('검색 결과를 찾지 못했어요');
	    	return; 
		}

		RELAX_Search_List.forEach(item => {
			var matchingIndex = RELAX_Data_List.findIndex(dataItem =>
	    		dataItem.RELAX_ADD1 === item.RELAX_ADD1 &&
	    		dataItem.RELAX_RSTRNT_NM === item.RELAX_RSTRNT_NM
			);

			if (matchingIndex !== -1) {
				var RELAX_GUBUN_DETAIL = RELAX_Data_List[matchingIndex].RELAX_GUBUN_DETAIL;; // 수정된 부분
	    		if (selectedGubunValues.includes(RELAX_GUBUN_DETAIL)) {
	    			var location = item.RELAX_ADD1; // 또는 item.RELAX_RSTRNT_NM, 필요에 따라 선택
	        		naver.maps.Service.geocode({ query: location }, function(status, response) {
	        		if (status === naver.maps.Service.Status.OK) {
	        			var result = response.v2.addresses[0];
	           			var latitude = result.y; // 위도
	           			var longitude = result.x; // 경도
	           			var marker = new naver.maps.Marker({
	        	   			map: map, // 지도 객체
	               			position: new naver.maps.LatLng(latitude, longitude), // 마커 위치
	               			title: location // 마커 타이틀
	           			});
	            
	           			var infoWindow = new naver.maps.InfoWindow({
	            			content : getInfoWindowContent(matchingIndex) //contentString
	            		});
	                
	            		var isOpen = false; // 상태창이 열렸는지 여부를 추적
	            			naver.maps.Event.addListener(marker, 'click', function() {
	                			if (isOpen) {
	                    			infoWindow.close();
	                    		} else {
	                        		infoWindow.open(map, marker);
	                    		}
	                			isOpen = !isOpen; // 열림 상태를 반전
	                		});
	                	
	                		naver.maps.Event.addListener(map, 'click', function() {
	                			for (var i = 0; i < infoWindows.length; i++) {
	                    			infoWindows[i].close(); // 상태창을 닫음
	                    		}
	                		});
	        		}else {
	        			//console.log('Geocoding failed: ' + status);
	        		}
	        			markers.push(marker); // 생성한 마커를 배열에 추가
	            		infoWindows.push(infoWindow);
	        		});
	    		}
			}
		});
	});	
	
	$('.resetRestaurant').click(function(){
		markers.forEach(marker => {
			marker.setMap(null); // 모든 마커를 지도에서 삭제
		});
		markers = [];
	});

	function getInfoWindowContent(matchingIndex) {
		var content = '<div>';
		content += '<p>상호 명: ' + RELAX_Data_List[matchingIndex].RELAX_RSTRNT_NM + '</p>';
		content += '<p>위치: ' + RELAX_Data_List[matchingIndex].RELAX_ADD1 + '</p>';
		content += '<p>세부 정보: ' + RELAX_Data_List[matchingIndex].RELAX_GUBUN_DETAIL + '</p>';
		content += '<p>전화 번호: ' + RELAX_Data_List[matchingIndex].RELAX_RSTRNT_TEL + '</p>';
		// ... 원하는 데이터 추가 ...
		content += '</div>';
		return content;
	}
	
	
//★	
	//2. 네이버 챗봇
	var stompClient = null;

	function setConnected(connected) {
		$("#connect").prop("disabled", connected);
		$("#disconnect").prop("disabled", !connected);
		$("#send").prop("disabled", !connected);
		if (connected) {
			$("#conversation").show();
		} else {
			$("#conversation").hide();
		}
		$("#msg").html("");
	}

	function connect() {
		var socket = new SockJS('/ws');
		stompClient = Stomp.over(socket);
		stompClient.connect({}, function(frame) {
			setConnected(true);
			//console.log('Connected: ' + frame);
			stompClient.subscribe('/topic/public', function(message) {
				let receiveMessage = message.body;
				showMessage2(receiveMessage); //서버에 메시지 전달 후 리턴받는 메시지
			});
		});
	}

	function disconnect() {
		if (stompClient !== null) {
			stompClient.disconnect();
		}
		setConnected(false);
		console.log("Disconnected");
	}

	function sendMessage() {
		let sendMessage = $("#msg").val()
		showMessage1(sendMessage);	//내가 입력한 메세지에요!
		stompClient.send("/app/sendMessage", {}, JSON.stringify(sendMessage)); //내가 입력한 메세지를 서버로 보내요!
	}

	function showMessage1(sendMessage) {
		$("#showMessage").append("<tr><td style='text-align: right;'>" + sendMessage + "</td></tr>");
	}

	function showMessage2(receiveMessage) {
		$("#showMessage").append("<tr><td style='text-align: left;'>" + receiveMessage + "</td></tr>");
	}

	$(function() {
		$("form").on('submit', function(e) {
			e.preventDefault();
		});
		$("#connect").click(function() {
			connect();
		});
		$("#disconnect").click(function() {
			disconnect();
		});
		$("#send").click(function() {
			sendMessage();
		});
		
		$('#connect').click(function() {
			if ($(".col-md-row").css("display") == "none") {
				$('.col-md-row').show();
				//$('.col-md-6').show();
				$('#connect').hide();
			}
		});
	});	
	
//★
	//3. 네이버 번역
	const translateButton = $("#translateButton");
	translateButton.click(function() {
	    const initialText = "번역된 텍스트로 초기화할 내용";
	    $(".translation-target p").each(function() {
	    	const originalText = $(this).text();
	    	const currentParagraph = $(this);/* document.getElementById("currentParagraph"); */ // 현재의 <p> 요소를 저장
	    	
	    	$.ajax({
    	    	url: "/recipe/english",
    	    	type: "GET",
    	    	dataType: "json", // 데이터 타입을 text로 설정
    	    	data: { korean: originalText },
    	    	success: function(v) { // 바로 번역된 텍스트를 받아서 처리
					//const english = "${english}";
    	    		//console.log('english : ', english);
    	    		//console.log('v : ' , v);
    	    		//const responseObject = JSON.parse(english);
    	    		//console.log('responseObject : ' ,responseObject);
    	    		 // 필요한 값인 'translatedText'를 추출하여 currentParagraph에 저장
                    const translatedText = english.message.result.translatedText;
    	    		console.log(translatedText);
                    currentParagraph.text(translatedText);
    	    	},error: function(e) {
    	    		console.log('실패입니다', e);
    	    	}
    		});
		});
	});
	
});	//document.ready End Point

//★
//4. 공공데이터
var ServerRegionData = JSON.parse('${regionData}');
var ServerlocationData = JSON.parse('${locationData}');

var OCCRNC_CNT1 = null;
var OCCRNC_CNT2 = null;
var OCCRNC_CNT3 = null;
var OCCRNC_CNT4 = null;
var OCCRNC_CNT5 = null;
var OCCRNC_CNT6 = null;
var OCCRNC_CNT7 = null;
var OCCRNC_CNT8 = null;
var OCCRNC_CNT9 = null;
var OCCRNC_CNT10 = null;
var OCCRNC_CNT11= null;
var OCCRNC_CNT12 = null;

var OCCRNC_CNT_None = null;
var OCCRNC_CNT_Restaurant = null;
var OCCRNC_CNT_NotSchool = null;
var OCCRNC_CNT_School = null;
var OCCRNC_CNT_ETC = null;
var OCCRNC_CNT_Home = null;

var OCCRNC_CNT_Seoul = null;
var OCCRNC_CNT_Busan = null;
var OCCRNC_CNT_Daegu = null;
var OCCRNC_CNT_Inchen = null;
var OCCRNC_CNT_Gwangju = null;
var OCCRNC_CNT_Daejeon = null;
var OCCRNC_CNT_Jeju = null;

const ctx1 = document.getElementById('MonthData_Chart').getContext('2d');
const ctx2 = document.getElementById('RegionData_Chart').getContext('2d');
const ctx3 = document.getElementById('LocationData_Chart').getContext('2d');

for (var i = 0; i < ServerRegionData.length; i++) {
	var OCCRNC_YEAR = ServerRegionData[i].OCCRNC_YEAR;
    var OCCRNC_MM = parseInt(ServerRegionData[i].OCCRNC_MM);
    var PATNT_CNT = ServerRegionData[i].PATNT_CNT;
    var OCCRNC_CNT = parseInt(ServerRegionData[i].OCCRNC_CNT);
    var OCCRNC_AREA = ServerRegionData[i].OCCRNC_AREA;
  	
  	/* if (OCCRNC_MM >= 1 && OCCRNC_MM <= 12) {
  	   	console.log('OCCRNC_AREA', OCCRNC_AREA);
  	   	console.log('OCCRNC_YEAR', OCCRNC_YEAR);
  	   	console.log('OCCRNC_MM', OCCRNC_MM)
  	   	console.log('OCCRNC_CNT', OCCRNC_CNT);
  	   	//totalOCCRNC_CNT += OCCRNC_CNT;
  	   	//console.log('totalOCCRNC_CNT', totalOCCRNC_CNT);
  	  	totalOCCRNC_CNT[OCCRNC_MM - 1] += OCCRNC_CNT; // OCCRNC_MM에 해당하는 배열 요소에 합산
      	console.log('totalOCCRNC_CNT for OCCRNC_MM', OCCRNC_MM, totalOCCRNC_CNT[OCCRNC_MM - 1]);
   	} */
   	
   	if (OCCRNC_MM == 01) {
  	  	OCCRNC_CNT1 += OCCRNC_CNT;
   	}
   	if (OCCRNC_MM == 02) {
   		OCCRNC_CNT2 += OCCRNC_CNT;
   	}
   	if (OCCRNC_MM == 03) {
   		OCCRNC_CNT3 += OCCRNC_CNT;
   	}
   	if (OCCRNC_MM == 04) {
   		OCCRNC_CNT4 += OCCRNC_CNT;
   	}
   	if (OCCRNC_MM == 05) {
   		OCCRNC_CNT5 += OCCRNC_CNT;
   	}
   	if (OCCRNC_MM == 06) {
   		OCCRNC_CNT6 += OCCRNC_CNT;
   	}
   	if (OCCRNC_MM == 07) {
   		OCCRNC_CNT7 += OCCRNC_CNT;
   	}
   	if (OCCRNC_MM == 08) {
   		OCCRNC_CNT8 += OCCRNC_CNT;
   	}
   	if (OCCRNC_MM == 09) {
   		OCCRNC_CNT9 += OCCRNC_CNT;
   	}
   	if (OCCRNC_MM == 10) {
   		OCCRNC_CNT10 += OCCRNC_CNT;
   	}
   	if (OCCRNC_MM == 11) {
   		OCCRNC_CNT11 += OCCRNC_CNT;
   	}
   	if (OCCRNC_MM == 12) {
   		OCCRNC_CNT12 += OCCRNC_CNT;
   	}
   	if(OCCRNC_AREA == "서울"){
   		OCCRNC_CNT_Seoul += OCCRNC_CNT;
   	}
   	if(OCCRNC_AREA == "부산"){
   		OCCRNC_CNT_Busan += OCCRNC_CNT;
   	}
   	if(OCCRNC_AREA == "대구"){
   		OCCRNC_CNT_Daegu += OCCRNC_CNT;
   	}
	if(OCCRNC_AREA == "인천"){
   		OCCRNC_CNT_Inchen += OCCRNC_CNT;
   	}
	if(OCCRNC_AREA == "광주"){
   		OCCRNC_CNT_Gwangju += OCCRNC_CNT;
   	}
	if(OCCRNC_AREA == "대전"){
   		OCCRNC_CNT_Daejeon += OCCRNC_CNT;
   	}
	if(OCCRNC_AREA == "제주"){
   		OCCRNC_CNT_Jeju += OCCRNC_CNT;
   	}
}
for (var i = 0; i < ServerlocationData.length; i++) {
	var OCCRNC_YEAR = ServerRegionData[i].OCCRNC_YEAR;
    var OCCRNC_MM = parseInt(ServerlocationData[i].OCCRNC_MM);
    var PATNT_CNT = ServerRegionData[i].PATNT_CNT;
    var OCCRNC_CNT = parseInt(ServerlocationData[i].OCCRNC_CNT);
    var OCCRNC_PLC = ServerlocationData[i].OCCRNC_PLC;
    
   	if(OCCRNC_PLC == "불명"){
   		OCCRNC_CNT_None += OCCRNC_CNT;
   	}
   	if(OCCRNC_PLC == "음식점"){
   		OCCRNC_CNT_Restaurant += OCCRNC_CNT;
   	}
   	if(OCCRNC_PLC == "학교 외 집단급식"){
   		OCCRNC_CNT_NotSchool += OCCRNC_CNT;
   	}
   	if(OCCRNC_PLC == "학교"){
   		OCCRNC_CNT_School += OCCRNC_CNT;
   	}
   	if(OCCRNC_PLC == "기타"){
   		OCCRNC_CNT_ETC += OCCRNC_CNT;
   	}
   	if(OCCRNC_PLC == "가정집"){
   		OCCRNC_CNT_Home += OCCRNC_CNT;
   	}
}
	
	const MonthData_Chart = new Chart(ctx1, {
	    type: 'bar',
	    data: {
	        labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        datasets: [{
	            label: '', 
	            data: [OCCRNC_CNT1,
	            		OCCRNC_CNT2,
	            		OCCRNC_CNT3,
	            		OCCRNC_CNT4,
	            		OCCRNC_CNT5,
	            		OCCRNC_CNT6,
	            		OCCRNC_CNT7,
	            		OCCRNC_CNT8,
	            		OCCRNC_CNT9,
	            		OCCRNC_CNT10,
	            		OCCRNC_CNT11,
	            		OCCRNC_CNT12],
	            backgroundColor: [
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	            ],
	            borderColor: [
	                'rgba(255, 99, 132, 1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(255, 99, 132, 1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(255, 99, 132, 1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	            ],
	        }]
	    },
	    options: {
	    	plugins:{
                legend: {
                    display: false
                },
	    		chartText1: {
	    			display: true
	    		}
            }
	   	}
	});
	
	/* var chartText1 = "2022년 한 해 월별 사고 건 수";
	ctx1.font = "30px";
	ctx1.fillStyle = "#000";
	ctx1.textAlign = "center";
	ctx1.fontweight = "border";
	ctx1.fillText(chartText1, MonthData_Chart.width / 2, 30); */
	
	  const RegionData_Chart = new Chart(ctx2, {
		    type: 'line',
		    data: {
		        labels: ['서울', '부산', '대구', '인천', '광주', '대전', '제주'],
		        datasets: [{
		            label: '', 
		            data: [OCCRNC_CNT_Seoul,
		            	OCCRNC_CNT_Busan,
		            	OCCRNC_CNT_Daegu,
		            	OCCRNC_CNT_Inchen,
		            	OCCRNC_CNT_Gwangju,
		            	OCCRNC_CNT_Daejeon,
		            	OCCRNC_CNT_Jeju],
		            fill: false,
		            borderColor: 'rgb(75, 192, 192)',
		            //tension: 0.1
		        }]
		    },
		    options: {
		    	responsive: true,
		    	plugins:{
	                legend: {
	                    display: false
	                },
	            }
		    }
		});

	 /*  var chartText2 = "2022년 한 해 지역별 사고 건 수";
		ctx2.font = "30px";
		ctx2.fillStyle = "#000";
		ctx2.textAlign = "center";
		ctx2.fontweight = "border";
		ctx2.fillText(chartText2, RegionData_Chart.width / 2, 30); */
	  
	  const LocationData_Chart = new Chart(ctx3, {
		    type: 'pie',
		    data: {
		        labels: ['불명', '음식점', '학교', '학교 외 집단급식', '가정집', '기타'],
		        datasets: [{
		            label: '',
		            data: [OCCRNC_CNT_None, OCCRNC_CNT_Restaurant, OCCRNC_CNT_School, OCCRNC_CNT_NotSchool, OCCRNC_CNT_ETC, OCCRNC_CNT_Home],
		            backgroundColor: [
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)',
		                'rgba(255, 206, 86, 0.2)',
		                'rgba(75, 192, 192, 0.2)',
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)',
		            ],
		            borderColor: [
		                'rgba(255, 99, 132, 1)',
		                'rgba(54, 162, 235, 1)',
		                'rgba(255, 206, 86, 1)',
		                'rgba(75, 192, 192, 1)',
		                'rgba(255, 99, 132, 1)',
		                'rgba(54, 162, 235, 1)',
		            ],
		        }]
		    },
		    options: {
		    	 responsive: true,
		    	 plugins:{
		                legend: {
		                    display: false
		                },
		         }
		    }
		});
	  
	  /* var chartText3 = "2022년 한 해 장소별 사고 건 수";
		ctx3.font = "30px";
		ctx3.fillStyle = "#000";
		ctx3.textAlign = "center";
		ctx3.fontweight = "border";
		ctx3.fillText(chartText3, LocationData_Chart.width / 2, 30); */
	  
	  
var mySwiper = new Swiper('.swiper-container', {
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
});

</script>
	  
<%@ include file="../common/footer.jsp" %>
</html>