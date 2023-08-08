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
	
    <script src='/resources/recipe_js/listFile.js'></script>    
    <script src='/resources/recipe_js/mimi.js'></script>
    
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
						<a href="./view?b_no=${list.b_NO}" class="fh5co-card-item cmn">
						<%-- <a href="#" class="fh5co-card-item" onclick="requestAction('./view', ${list.b_NO})"> --%>
							<figure>
								<div class="overlay"><i class="bi bi-box-arrow-up-right"></i></div>
								<div class="fileDiv" class="">
									<input id="bno" type="text" name="b_no" value="${list.b_NO}" placeholder="추후  hidden 처리">!!!!! 요리 사진 !!!!!
								</div>
							</figure>
							<div class="fh5co-text position-relative">
					            <p class="mb-0">✅ ${list.b_NO}</p>
					            <p class="mb-0 title">🍴 ${list.title}</p>
					            <p class="mb-0 intro">📝  ${list.intro}</p>
					            <p class="mb-0">🙋‍♀️‍ ${list.nickName}</p>
					            <p class="mb-0">👍 ${list.boomup} &nbsp; 👀 ${list.viewcnt}</p> 
				           		<p class="mb-0">🛒 ${list.cateName1}, ${list.cateName2}</p>
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
