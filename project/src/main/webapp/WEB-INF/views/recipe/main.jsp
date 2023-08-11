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
}

.div_BoomUpList {
	border: 2px solid;
	display: inline-block
}

.div_ViewCntList {
	border: 2px solid;
	display: inline-block
}

.div_ReplyCntList {
	border: 2px solid;
	display: inline-block
}

.div_RecentList {
	border: 2px solid;
	display: inline-block
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

/* .quickmenu {
	position: absolute;
	width: 90px;
	top: 50%;
	margin-top: -50px;
	right: 10px;
	background: #fff;
}

.quickmenu ul {
	position: relative;
	float: left;
	width: 100%;
	display: inline-block;
	*display: inline;
	border: 1px solid #ddd;
}

.quickmenu ul li {
	float: left;
	width: 100%;
	border-bottom: 1px solid #ddd;
	text-align: center;
	display: inline-block;
	*display: inline;
}

.quickmenu ul li a {
	position: relative;
	float: left;
	width: 100%;
	height: 30px;
	line-height: 30px;
	text-align: center;
	color: #999;
	font-size: 9.5pt;
}

.quickmenu ul li a:hover {
	color: #000;
}

.quickmenu ul li:last-child {
	border-bottom: 0;
} */

.content {
	position: relative;
	min-height: 1000px;
}

.slider-container {
	width: 400px; /* 슬라이드 컨테이너 너비 */
	height: 300px; /* 슬라이드 컨테이너 높이 */
	overflow: hidden; /* 너비를 벗어나는 이미지 숨기기 */
	position: relative; /* 슬라이드 위치를 조정하기 위해 필요 */
}

.slide {
	width: 100%; /* 슬라이드 이미지 너비 100%로 설정 */
	height: 100%; /* 슬라이드 이미지 높이 100%로 설정 */
	position: absolute; /* 슬라이드 위치를 조정하기 위해 필요 */
	opacity: 0; /* 기본적으로 슬라이드 숨김 */
	transition: opacity 1s ease-in-out; /* 페이드 인/아웃 효과를 위한 트랜지션 */
}

.slide.active {
	opacity: 1; /* 활성 슬라이드의 투명도를 1로 설정하여 표시 */
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
</style>
<!-- <script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=6j3xj4ny38&submodules=geocoder"></script>
<%@ include file="../common/header.jsp" %>
</head>
<body>
[참고] 깃헙 토큰 : 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
	<!-- //1. 최다 추천 레시피 리스트 불러오기(누적 랭킹) -->
	<h1>1. 명예의 전당 (=최다 추천 레시피 리스트 불러오기)</h1>
	<c:forEach var="BoomUpList" items="${BoomUpList}" begin="0" end="4" step="1">
		<!--  begin="0" end="5" step="1" varStatus="status" -->
		<div class="div_BoomUpList">
			<%-- <p>이미지 :${}</p> --%>
			<div class="fileDiv" class=""></div>
			<a id="imghref" onclick="" data-value="${BoomUpList.title }" class="imghref">제목 : ${BoomUpList.title }</a>
			<p>닉네임 : ${BoomUpList.nickName }</p>
			<p>추천 수 : ${BoomUpList.boomup }</p>
		</div>
	</c:forEach>

	<!-- //2. 최다 조회 레시피 리스트 불러오기(누적 랭킹) -->
	<h1>2. 화제의 레시피 (=최다 추천 레시피 리스트 불러오기)</h1>
	<c:forEach var="ViewCntList" items="${ViewCntList}" begin="0" end="4" step="1">
		<div class="div_ViewCntList">
			<%-- <p>이미지 :${}</p> --%>
			<a id="imghref" onclick="" data-value="${ViewCntList.title }" class="imghref">제목 : ${ViewCntList.title }</a>
			<p>닉네임 : ${ViewCntList.nickName }</p>
			<p>조회 수 : ${ViewCntList.viewCnt }</p>
		</div>
	</c:forEach>

	<!-- //3. 최다 댓글 레시피 리스트 불러오기(누적 랭킹) -->
	<%-- <h1>3. 왁자지껄 댓글 폭발 레시피 리스트 불러오기(=최다 댓글 레시피 리스트 불러오기)</h1>
	<c:forEach var="ReplyCntList" items="${ReplyCntList}" begin="0" end="4"
		step="1">
		<div class="div_ReplyCntList">
			<p>이미지 :${}</p>
			<a id="imghref" onclick="" data-value="${ReplyCntList.title }" class="imghref">제목 : ${ReplyCntList.title }</a>
			<p>닉네임 : ${ReplyCntList.nickName }</p>
			<p>댓글 수 : ${ReplyCntList.replyCnt }</p>
		</div>
	</c:forEach> --%>

	<!-- //4. 최신 등록 레시피 리스트 불러오기 -->
	<h1>3. 따끈따끈한 레시피 (=최신 등록 레시피 리스트 불러오기)</h1>
	<c:forEach var="RecentList" items="${RecentList}" begin="0" end="4"
		step="1">
		<div class="div_RecentList">
			<%-- <p>이미지 :${}</p> --%>
			<a id="imghref" onclick="" data-value="${RecentList.title }" class="imghref">제목 : ${RecentList.title }</a>
			<p>닉네임 : ${RecentList.nickName }</p>
			<p>등록일 : ${RecentList.regdate }</p>
		</div>
	</c:forEach>

	<!-- //6. 챗봇 -->
	<!-- <h1>무엇이든 물어보세요!</h1> -->
	<div id="main-content" class="container" style="">
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
				<div class="col-md-7" > <%-- <!-- style="position: fixed; bottom: 0;" --> --%>
					<form class="form-inline">
						<div class="form-group" >
							<input type="text" id="msg" class="form-control" placeholder="궁금한 내용을 알려주세요.">
							<button id="send" class="btn btn-default" disabled type="submit" >전송</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<!-- <img src="/resources/img/Ministry_of_Food_and_Drug_Safety(vertical).svg.png" style="width:130px; height:100px;"> -->
	<!-- <button onclick="greeneyeImage()">그린아이 가동!!</button>
	<input type="text" id="textext"> -->
	
<!-- //6. 공공데이터API-->
<div style="width: 500px; height: 350px;"> <!-- class="slider-container" --> 
		<!-- <h3 class="slide">요리하기 전에 잠깐!<br>손은 깨끗이 씻으셨나요?</h3> -->
		<canvas id="MonthData_Chart"></canvas><!-- class="slide" -->
		<canvas id="RegionData_Chart"></canvas><!-- class="slide" -->
		<canvas id="LocationData_Chart"></canvas><!-- class="slide" -->
		<!-- <h3 class="slide">이 캠페인은 <img src="/resources/img/Ministry_of_Food_and_Drug_Safety(vertical).svg.png" style="width:130px; height:100px;">와 함께 합니다.</h3> -->
</div>
<!-- <button id="prevBtn">이전</button>
<button id="nextBtn">다음</button>-->
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<!-- //7. 네이버 지도-->
<div id="map" style="width: 500px; height: 350px;">
	<div style="position: relative; z-index: 100">
		<input type="text" id="searchRestaurantAddress" value="경기도" placeholder="주소를 입력해 주세요">
		<input type="text" id="searchRestaurantName" placeholder="상호명을 입력해 주세요">  <!-- value="경기도" --> 
		<input type="radio" value="한식" id="koreaFood" name="foodCheckBox" style="font-weight: 1200" checked="checked">한식
		<input type="radio" value="중식" id="chinaFood" name="foodCheckBox" style="font-weight: 1200">중식
		<input type="radio" value="일식" id="japanFood" name="foodCheckBox" style="font-weight: 1200">일식
		<button type="submit" id="searchRestaurant" class="searchRestaurant">검색</button>
		<button id="resetRestaurant" class="resetRestaurant">초기화</button>
	</div>
</div>

<!-- <div id="mapList"></div> -->
<%@ include file="../common/footer.jsp" %>
</body>
<script>


$(document).ready(function() {
	function getFileList(){
		fetch('/file/recList')
		then(response => response.json())
		.then(map => viewFileList(map));
	}
	
	
	
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
	
	//console.log('RELAX_ADD1List3 : ' , RELAX_ADD1List);

	//console.log('RELAX_RSTRNT_NMList : ' , RELAX_RSTRNT_NMList);
	
	// 현재 위치로 이동 이미지
    var curtBtn = '<img src="/resources/img/free-icon-location-5582962 (1).png" alt="현재위치로 이동">';

    // 현재 위치 위도, 경도 좌표 객체를 담을 변수
    var curtLoca = "";

    // 서울 시청 위/경도 좌표 객체
    /* var sCityHallLoca = new naver.maps.LatLng(37.5666805, 126.9784147); */

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
        return; // 검색 결과가 없으면 더 이상 코드를 실행하지 않음
    }
	
	//console.log('RELAX_Search_ListRELAX_Search_ListRELAX_Search_List : ', RELAX_Search_List);
    RELAX_Search_List.forEach(item => {
    	var matchingIndex = RELAX_Data_List.findIndex(dataItem =>
        	dataItem.RELAX_ADD1 === item.RELAX_ADD1 &&
        	dataItem.RELAX_RSTRNT_NM === item.RELAX_RSTRNT_NM
    	);
	
		if (matchingIndex !== -1) {
			var RELAX_GUBUN_DETAIL = RELAX_Data_List[matchingIndex].RELAX_GUBUN_DETAIL;; // 수정된 부분
	    	if (selectedGubunValues.includes(RELAX_GUBUN_DETAIL)) {
	    		var location = item.RELAX_ADD1; // 또는 item.RELAX_RSTRNT_NM, 필요에 따라 선택
	    		//console.log('일치하는 데이터:', location, RELAX_GUBUN_DETAIL, selectedGubunValues, matchingIndex);
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
});//맨 끝

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

/* function closeAllInfoWindows() {
    for (var i = 0; i < infoWindows.length; i++) {
        infoWindows[i].close(); // 상태창을 닫음
    }
} */

    


/* var marker = new naver.maps.Marker({
	map: null, // 지도 객체
	position: new naver.maps.LatLng(latitude, longitude), // 마커 위치
	title: location // 마커 타이틀
}); */


	/* marker.forEach(marker => { 
		marker.setMap(null)
	}
		});
	}
*/
/* marker.forEach(item => {
	if(item.includes(searchRestaurantForm)){
			RELAX_ADD1SearchList = RELAX_ADD1List.filter(item => item.includes(searchRestaurantForm));
		//RELAX_ADD1SearchList.push(item.includes(searchRestaurantForm));
	}
}) */
	
//const newMarkers = markerPositions.map(position => new kakao.maps.Marker({ map: kakaoMap, position, image: markerImage}));
//setMarkers(markers => {markers.forEach(marker => marker.setMap(null));


    
	//setMarkers(markers => {markers.forEach(marker => marker.setMap(null));
	/* marker.forEach(item => {
		marker.setMap(null);
	}); */
	
	/* for(var i = 0; i < 300; i++){
		marker.setMap(null);
	} */
	//setMarkers(markers => {markers.forEach(marker => marker.setMap(null));
	/* marker.forEach(marker => {
		marker.setMap(null);
	}); */
    
    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
/*     for (var i = 0; i < jsonData.length; i++) {
    var location = jsonData[i].location; // 주소 정보

    // 네이버 지도 API를 활용한 주소 지오코딩
    naver.maps.Service.geocode({
        query: location // 변환할 주소
    }, function(status, response) {
        if (status === naver.maps.Service.Status.OK) {
            var result = response.v2.addresses[0];
            var latitude = result.y; // 위도
            var longitude = result.x; // 경도

            // 마커 생성
            var marker = new naver.maps.Marker({
                map: map, // 지도 객체
                position: new naver.maps.LatLng(latitude, longitude), // 마커 위치
                title: location // 마커 타이틀
            });

            /* // 마커 클릭 시 추가 정보 표시 등 이벤트 처리 가능
            naver.maps.Event.addListener(marker, 'click', function() {
                // 마커 클릭 시 동작할 내용
            }); */
        /* } else {
            console.log('Geocoding failed: ' + status);
        } */
    //});
//} */
    
    //★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    
    
    
    
    
 	// 주소 => 위/경도 조회
   /*  var searchAddressToCoordinate = function (address) {
        naver.maps.Service.geocode({ query: address },
        function(status, response) {
            if (status === naver.maps.Service.Status.ERROR) {
                if (!address) {
                    return alert('Geocode Error, Please check address');
                }
                return alert('Geocode Error, address:' + address);
            }

            if (response.v2.meta.totalCount === 0) {
                return alert('Geocode No result.');
            }

            var item = response.v2.addresses[0];
            var lat = item.y;
            var lng = item.x;
                
            var htmlAddresses = [],
            item = response.v2.addresses[0],
            point = new naver.maps.Point(item.x, item.y);
        
            /* if (item.roadAddress) {
            	htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
       		}
        	
            if (item.jibunAddress) {
            	htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
        	}
        	if (item.englishAddress) {
            	htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
        	} */
	        
        	//insertAddress(item.roadAddress, item.x, item.y); */
            
            //console.log(item);
        //});
   // } 
	
    /* function insertAddress(address, latitude, longitude) {
    	var mapList = "";
    	mapList += "<tr>"
    	mapList += "	<td>" + address + "</td>"
    	mapList += "	<td>" + latitude + "</td>"
    	mapList += "	<td>" + longitude + "</td>"
    	mapList += "</tr>"

    	$('#mapList').append(mapList);	

    	var map = new naver.maps.Map('map', {
    	    center: new naver.maps.LatLng(longitude, latitude),
    	    zoom: 14
    	});
        var marker = new naver.maps.Marker({
            map: map,
            position: new naver.maps.LatLng(longitude, latitude),
        });
    } */
	
	
	
	
	
	
	
	
	
	
	
	
	//1. 캠페인
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
	
	//차트
	const MonthData_Chart = new Chart(ctx1, {
	    type: 'bar',
	    data: {
	        labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        datasets: [{
	            label: '', /*월별 사고 건 수*/ 
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
	            //borderWidth: 1
	        }]
	    },
	    options: {
	    	plugins:{
	    		legend: {
                    display: false
                    /* scales: {
        	            y: {
        	                beginAtZero: true
        	            }
        	        } */
	    		}
	    	}
	    }
	});

	const RegionData_Chart = new Chart(ctx2, {
	    type: 'line',
	    data: {
	        labels: ['서울', '부산', '대구', '인천', '광주', '대전', '제주'],
	        datasets: [{
	            label: '', /*월별 사고 건 수*/ 
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
	    	plugins:{
	    		legend: {
                    display: false
                    /* scales: {
        	            y: {
        	                beginAtZero: true
        	            }
        	        } */
	    		}
	    	}
	        /* scales: {
	            y: {
	                beginAtZero: true
	            }
	        } */
	    }
	});

	const LocationData_Chart = new Chart(ctx3, {
	    type: 'doughnut',
	    data: {
	        labels: ['불명', '음식점', '학교', '학교 외 집단급식', '가정집', '기타'],
	        datasets: [{
	            label: '장소별 총 사고 건 수',
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
	            //borderWidth: 1
	        }]
	    },
	    options: {
	    	plugins:{
	    		legend: {
                    display: false
                    /* scales: {
        	            y: {
        	                beginAtZero: true
        	            }
        	        } */
	    		}
	    	}
	        /* scales: {
	            y: {
	                beginAtZero: true
	            }
	        } */
	    }
	});
	
	//3. 챗봇 시작
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
});

	//3. 챗봇 끝
	
	
	
	
	
	
	
</script>
</html>