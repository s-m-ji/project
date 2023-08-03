<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<!-- 부트스트랩 아이콘 (MI, 2023/07/26)-->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
	<!-- 폰트어썸 아이콘 (MI, 2023/07/26) -->
	<script src="https://kit.fontawesome.com/bc0f5040fb.js" crossorigin="anonymous"></script>

    <!-- 부트스트랩 css CDN (최신 버전) -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	
	<!-- 템플릿 css 모음  (MI, 2023/07/26) -->
	<link rel="stylesheet" href="/resources/assets/css/main.css" />
	<link rel="stylesheet" href="/resources/css/animate.css">
	<link rel="stylesheet" href="/resources/css/themify-icons.css">
	<link rel="stylesheet" href="/resources/css/bootstrap.css"> <!-- 부트스트랩 css 내장 (템플릿 전용) -->
	<link rel="stylesheet" href="/resources/css/magnific-popup.css">
	<link rel="stylesheet" href="/resources/css/bootstrap-datetimepicker.min.css">
	<link rel="stylesheet" href="/resources/css/owl.carousel.min.css">
	<link rel="stylesheet" href="/resources/css/owl.theme.default.min.css">
	<link rel="stylesheet" href="/resources/css/style.css">
	
	<!-- ============ recipe 플젝 css 모음 (MI, 2023/07/26) ============ -->	
	<!-- 지상미 css (MI, 2023/07/28) -->
	<link rel="stylesheet" href="/resources/recipe_css/mimi.css">
	

	<!-- 템플릿 js 모음  (MI, 2023/07/26) -->
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
	
	<!-- ============ recipe 플젝 js 모음 (MI, 2023/07/26) ============ -->	
	<!-- 공통 적용 -->
    <script src='/resources/recipe_js/common.js'></script> 
    
    <!-- list 파일 적용 -->
    <script src='/resources/recipe_js/listFile.js'></script>
    
    <!-- 지상미 js -->
    <script src='/resources/recipe_js/mimi.js'></script>
    

</head>
<body>
<!-- Header -->
	<section id="header">
		<div class="container">

			<!-- Logo -->
				<h1 id="logo"><a href="index.html">오늘 뭐 먹조 ?</a></h1>

			<!-- Nav -->
				<nav id="nav">
					<ul>
						<li><a class="icon solid fa-home" href="main.jsp"><span>홈페이지</span></a></li>
						<li><a class="icon solid fa-cog" href="left-sidebar.html"><span>커뮤니티</span></a></li>
						<li><a class="icon solid fa-retweet" href="right-sidebar.html"><span>관리자페이지</span></a></li>
						<li><a class="icon solid fa-sitemap" href="no-sidebar.html"><span>로그인</span></a></li>
						<li><a class="icon solid fa-sitemap" href="no-sidebar.html"><span>회원가입</span></a></li>
						<!-- <li>
							<a href="#" class="icon fa-chart-bar"><span>Dropdown</span></a>
							<ul>
								<li><a href="#">Lorem ipsum dolor</a></li>
								<li><a href="#">Magna phasellus</a></li>
								<li><a href="#">Etiam dolore nisl</a></li>
								<li>
									<a href="#">Phasellus consequat</a>
									<ul>
										<li><a href="#">Magna phasellus</a></li>
										<li><a href="#">Etiam dolore nisl</a></li>
										<li><a href="#">Phasellus consequat</a></li>
									</ul>
								</li>
								<li><a href="#">Veroeros feugiat</a></li>
							</ul>
						</li> -->
					</ul>
				</nav>
				
			<!-- 검색 -->
			<div class="search-wrapper">
			    <div class="input-holder">
			    <form action="./list_test" name="searchFormHeader">
			        <input type="text" name="sWord" class="search-input" placeholder="레시피를 검색하세요." />
			        <button class="search-icon" onclick="searchToggle(this, event);"><span><i class="bi bi-search"></i></span></button>
			      </form>
			    </div>
			    <span class="close" onclick="searchToggle(this, event);"><i class="bi bi-x-circle"></i></span>
			</div>
		</div>
		<br>
		<p>김광민 - 김지수 - 서동준 - 이한규 - 정명현 - 지상미</p>
		<br>
	</section>
	
	<script>
	function searchToggle(obj, evt){
	    var container = $(obj).closest('.search-wrapper');
	        if(!container.hasClass('active')){
	            container.addClass('active');
	            evt.preventDefault();
	        }
	        else if(container.hasClass('active') && $(obj).closest('.input-holder').length == 0){
	            container.removeClass('active');
	            // clear input
	            container.find('.search-input').val('');
	        }
	}
	</script>