<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <!-- 브라우저 탭 제목 -->
    <title>커뮤니티 목록</title>
    
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
    			fetch('/file/comList')
    				.then(response => response.json())
    				.then(map => viewFileList(map));
    			console.log('/file/comList 목록 요청함');
    		}
    		
    		// ▶ 파일 목록 조회 
    		function viewFileList(map) {
    		    let fileList = map.list; // 파일 목록 배열 저장
    		    
    		    let fileDivs = document.querySelectorAll(".fileDiv"); // 모든 fileDiv 태그 선택

    		    fileDivs.forEach(function (fileDiv) {
    		        let inputElement = fileDiv.querySelector("input[name='com_bno']");
	    		    
    		        if (inputElement !== null) {
    		            let bnoValue = inputElement.value;
		    		    
    		            let matchingFile = fileList.find(item => item.com_bno === parseInt(bnoValue));
		    		    
    		            if (matchingFile) {
    		                let savePath = encodeURIComponent(matchingFile.savePath); // 원본 파일
    		                
    		                let fileExtension = matchingFile.savePath.split('.').pop(); // 파일 확장자 추출
    		                if (fileExtension === "mp4") {
    		                  let videoTag = "<video autoplay playsinline mute width='100%' height='auto'><source src='/recListdisplay?fileName=" + savePath + "' type='video/mp4'></video>";
    		                  fileDiv.innerHTML = videoTag; // 해당 fileDiv 태그에 동영상 추가
    		                } else {
    		                  let imageTag = "<img src='/recListdisplay?fileName=" + savePath + "' alt='레시피 사진 " + matchingFile.com_bno + "'>";
    		                  fileDiv.innerHTML = imageTag; // 해당 fileDiv 태그에 이미지 추가
    		                }
    		            }
    		            else {
    		            	// console.log("[else] matchingFile 출력");
    		            }
    		            
    		        } else {
    		            console.log("input[name='com_bno']가 없는 fileDiv가 있습니다.");
    		        }
    		    });
    		}

    	});
    </script>
    
    <!-- Header -->
	<%@ include file="../common/header.jsp" %>
	
	
	<script>
	// ▶▶▶  게시글 페이지네이션
	function go(page){
		document.searchForm.action = "./com_list";
		document.searchForm.pageNo.value=page;
		document.searchForm.submit();
	}
	</script>
	
	<!-- Main -->
	<section id="main" >
		<div class="container">
	      <div class="bg-light p-5 rounded text-center"> <h1 id="test">🤪 망한요리 🤪  </h1><sup>※ 제목 추후 삭제</sup></div>
			<%@ include file="../common/com_searchForm.jsp" %>
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
					<div class="col-lg-6 col-md-6 col-sm-6">
						<a href="./com_view_test?com_bno=${list.com_bno}" class="fh5co-card-item cmn">
						<%-- <a href="#" class="fh5co-card-item" onclick="requestAction('./view', ${list.com_bno})"> --%>
							<figure>
								<div class="overlay"><i class="bi bi-box-arrow-up-right"></i></div>
								<div class="fileDiv" class="">
									<input id="com_bno" type="text" name="com_bno" value="${list.com_bno}" placeholder="추후  hidden 처리">!!!!! 요리 사진 !!!!!
								</div>
							</figure>
							<div class="fh5co-text position-relative">
					            <p class="mb-0">✅ ${list.com_bno}</p>
					            <p class="mb-0 title">🍴 ${list.com_title}</p>
					            <p class="mb-0 intro">📝  ${list.com_content}</p>
					            <p class="mb-0">🙋‍♀️‍ ${list.nickName}</p>
					            <p class="mb-0">⌨ ${list.replycnt}</p> 
				           		<!-- 
				           			오늘 등록 : 몇시간 전
				           			일주일 내로 등록 : 며칠 전
				           			그 외 : 2023/00/00
				           		 -->
					            <p class="mb-0">📌 ${list.regdate}</p>
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
