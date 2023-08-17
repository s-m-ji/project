<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.DataOutputStream"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <!-- 브라우저 탭 제목 -->
    <title>레시피 목록</title>
    
    <!-- css -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	
   <link rel="stylesheet" href="/resources/assets/css/main.css" />
   <link rel="stylesheet" href="/resources/css/style.css">
   <link rel="stylesheet" href="/resources/css/animate.css">
   <link rel="stylesheet" href="/resources/recipe_css/mimi.css">
    
    <!-- js -->
    <script src="/resources/js/jquery.min.js"></script>
	<script src="/resources/js/jquery.easing.1.3.js"></script>
	<script src="/resources/js/bootstrap.min.js"></script>
	<script src="/resources/js/jquery.waypoints.min.js"></script>
	<script src="/resources/js/owl.carousel.min.js"></script>
	<script src="/resources/js/jquery.countTo.js"></script>
	<script src="/resources/js/jquery.stellar.min.js"></script>
	<script src="/resources/js/jquery.magnific-popup.min.js"></script>
	<script src="/resources/js/magnific-popup-options.js"></script>
	<script src="/resources/js/moment.min.js"></script>
	<script src="/resources/js/bootstrap-datetimepicker.min.js"></script>
	<script src="/resources/js/main.js"></script>
    
    <script src='/resources/recipe_js/mimi.js'></script>
    
    <script>
    window.addEventListener("load", function(){
    		getFileList();
    		
    		// ▶ 파일 목록 요청
    		function getFileList(){
    			fetch('/file/recList')
    				.then(response => response.json())
    				.then(map => viewFileList(map));
    		}
    		
    		// ▶ 파일 목록 조회 
    		function viewFileList(map) {
    		    let fileList = map.list; // 파일 목록 배열 저장
    		    let fileDivs = document.querySelectorAll(".fileDiv"); // 모든 fileDiv 태그 선택

    		    fileDivs.forEach(function (fileDiv) {
    		        let inputElement = fileDiv.querySelector("input[name='b_no']");
    		        if (inputElement !== null) {
    		            let bnoValue = inputElement.value;
    		            let matchingFile = fileList.find(item => item.b_NO === parseInt(bnoValue));
    		            // console.log("matchingFile 출력 ", matchingFile);
    		            
    		            if (matchingFile) {
    		                let savePath = encodeURIComponent(matchingFile.savePath); // 원본 파일
    		                let fileExtension = matchingFile.savePath.split('.').pop(); // 파일 확장자 추출
    		                if (fileExtension === "mp4") {
    		                  let videoTag = "<video autoplay='autoplay' muted='muted' playsinline loop width='100%' height='auto'><source src='/recListdisplay?fileName=" + savePath + "' type='video/mp4'></video>";
    		                  fileDiv.innerHTML = videoTag; // 해당 fileDiv 태그에 동영상 추가
    		                } else {
    		                  let imageTag = "<img src='/recListdisplay?fileName=" + savePath + "' alt='레시피 사진 " + matchingFile.b_NO + "'>";
    		                  fileDiv.innerHTML = imageTag; // 해당 fileDiv 태그에 이미지 추가
    		                }
    		            }
    		        } else {
    		            console.log("input[name='b_no']가 없는 fileDiv가 있습니다.");
    		        }
    		    });
    		}
    		
    	});
  	
    /* 클릭시 viewcnt 증가 함수   =====================================================*/
    
    function plusViewCnt(b_no){
		
		fetchGet("/recipe/plusView/" + b_no, plusViewRes);
		
	}
    
    function plusViewRes(map){
    	
    	console.log("plusView cnt 실행 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", map.res);
    	if(map.res > 0){
    		console.log("view 카운트 증가 성공");
    	}else{
    		console.log("view 카운트 증가 실패");
    	}
    	
    }
    
    /* 클릭시 viewcnt 증가 함수   =====================================================*/

    </script>
    
    <!-- Header -->
	<%@ include file="../common/header.jsp" %>
	
	<script>
	// ▶▶▶  게시글 페이지네이션
	function go(page){
		document.searchForm.action = "./list";
		document.searchForm.pageNo.value=page;
		document.searchForm.submit();
	}
	</script>
	
	<!-- Main -->
	<section id="main">
		<div class="container text-center">
	     <!--  <div class="bg-light p-5 rounded"><h1>👩‍🍳  레시피 👩‍🍳</h1> <sup>※ 제목 추후 삭제</sup></div> -->
	      
			<!-- 검색폼 -->	
			<%@ include file="../common/searchForm.jsp" %>
	      <div class="gtco-section">
			<div class=""> <!-- <div class="gtco-container"> -->
			<div class="container text-center">
			<div class="row">
			
			 <c:choose>
				<c:when test="${empty list}">
				<div class="d-flex gap-2 w-100 emptyList">
					<p>👩‍🍳 다른 검색어를 입력해보세요 👩‍🍳</p>
			    </div>
				</c:when>
				<c:otherwise>
					<c:forEach items="${list}" var="list">
					<!-- ViewCnt ++ 8-14  시작 함수 생성 mimi.js 에 추가 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
					<div class="col-lg-4 col-md-4 col-sm-6" onclick="plusViewCnt(${list.b_NO})">
<!-- 					<div class="col-lg-3 col-md-3 col-sm-5"> -->
						<a href="./view?b_no=${list.b_NO}" class="fh5co-card-item">
						<%-- <a href="#" class="fh5co-card-item" onclick="requestAction('./view', ${list.b_NO})"> --%>
							<figure>
								<div class="overlay"><i class="bi bi-box-arrow-up-right"></i></div>
								<div class="fileDiv" class="">
									<input id="bno" type="text" name="b_no" value="${list.b_NO}" placeholder="추후  hidden 처리">!!!!! 요리 사진 !!!!!
								</div>
							</figure>
							<div class="fh5co-text position-relative">
							<div class="fh5co-text-top">
					            <p class="mb-0 bno">No. ${list.b_NO}</p>
					            <p class="mb-0 boom"><i class="fa-solid fa-eye" style="color: #6d737e;"></i> ${list.boomup} &nbsp; <i class="fa-solid fa-thumbs-up" style="color: #8c929b;"></i> ${list.viewcnt}</p> 
							</div>
					            <p class="mb-0 title" title="${list.title}">${list.title}</p>
					            <p class="mb-0 intro" title="${list.intro}">${list.intro}</p>
					            <p class="mb-0 name">‍<i class="fa-solid fa-user"style="color: #aaa;"></i> ${list.nickName}</p>
				            <div class="fh5co-text-btm">
					            <p class="mb-0 cate">${list.cateName1} > ${list.cateName2}</p>
				           		<!-- 
				           			오늘 등록 : 몇분 전, 몇시간 전
				           			일주일 내로 등록 : 며칠 전
				           			그 외 : 2023/00/00
				           		 -->
					            <p class="mb-0"> ${list.regdate}</p>
							</div>
					            <!-- 3일 내로 등록한 글이면 new 표시 -->
								<c:if test="${ not empty list.newpost}">
									<span class="position-absolute top-0 start-90 translate-middle badge rounded-pill bg-danger"> ${list.newpost} </span>
								</c:if>
							</div>
						</a>
					</div>
	        		</c:forEach>
			      <%@ include file="../common/pageNavi.jsp" %>
				</c:otherwise>
			</c:choose>
	      </div>
	      </div>
	      </div>
		</div>
		</div>
	</section>
		
	<!-- Footer -->
	<%@ include file="../common/footer.jsp" %>

	<script type="text/javascript">

</script>
	<!-- Search Trend API -->
	<%
	
	 String clientId = "029baf0kwq";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "3Ea7ZHASn2UVTaqgGYWfZWkv2cyzQEnW4EtftFu3";//애플리케이션 클라이언트 시크릿값";

    try {
        String apiURL = "https://naveropenapi.apigw.ntruss.com/datalab/v1/search";
        String body = "{\"startDate\":\"2017-01-01\",\"endDate\":\"2017-04-30\",\"timeUnit\":\"month\",\"keywordGroups\":[{\"groupName\":\"한글\",\"keywords\":[\"한글\",\"korean\"]},{\"groupName\":\"영어\",\"keywords\":[\"영어\",\"english\"]}],\"device\":\"pc\",\"ages\":[\"1\",\"2\"],\"gender\":\"f\"}";
        URL url = new URL(apiURL);
        HttpURLConnection con = (HttpURLConnection)url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
        con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);
        con.setRequestProperty("Content-Type", "application/json");

        con.setDoOutput(true);
        DataOutputStream wr = new DataOutputStream(con.getOutputStream());
        wr.write(body.getBytes());
        wr.flush();
        wr.close();

        int responseCode = con.getResponseCode();
        BufferedReader br;
        if(responseCode==200) { // 정상 호출
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 오류 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }

        String inputLine;
        StringBuffer response2 = new StringBuffer();
        while ((inputLine = br.readLine()) != null) {
            response2.append(inputLine);
        }
        br.close();
        System.out.println("response 출력");
        System.out.println(response.toString());

    } catch (Exception e) {
        System.out.println(e);
    }
	%>
