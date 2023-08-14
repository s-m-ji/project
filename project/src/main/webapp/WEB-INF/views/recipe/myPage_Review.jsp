<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link href="/resources/css/view.css" rel="stylesheet">
<script src="/resources/js/view.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@100;500&family=Nanum+Gothic&family=Noto+Sans+KR&family=Orbit&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@500&family=Nanum+Gothic&family=Orbit&display=swap" rel="stylesheet">
<link href="/resources/css/myPage.css" rel="stylesheet">

<style>
	
	
	
	
	/* 3개 탭 */
	#myReview{
		background-color: #F7863B;
	    font-weight: 900;
	    color: aliceblue;
	    
	}
	
	#myInfo{
		margin-left: 5px;
	}
	
	
	
	
</style>

<%@ include file="../common/header.jsp" %>


<script type="text/javascript">

		window.addEventListener('load',function(){
			
			
			
			
		});
		
		
		function getMyRecipe(){
			
			const m_no = document.querySelector("#m_no").value;
			console.log(m_no);
			
			fetchGet("/recipe/myPage_recipeList/" + m_no, ListRes);
			
		};
		
		// 좋아요 한 레시피 ..
		function ListRes(map){
			
			const ContentInfo = document.querySelector('#ContentInfo');
			console.log(map.list);
			
			let list = '';
			map.list.forEach(function(item, index){
				
					list +=
						'<div>'+item.title+'</div>'
				
			});
			
			ContentInfo.innerHTML = list;
		}
		
		
	
</script>
</head>
<body>

<input type="text" id="m_no" value="1">
	
	
	
	<h2>요리후기 페이지 입니다.</h2>
	<section id="features">
		<!-- 전체 container -->
		<div id="myPage_Con">
			<!-- 상단 탭 -->
			<div id="myPage_tab">
				<ul>
					<li class="hoverTab" id="myInfo" ><a href="/recipe/myPage2">나의 정보</a></li>
					<li class="hoverTab" id="myRecipe"><a href="/recipe/myList?mode=myRecipe">레시피</a></li>
					<li class="hoverTab" id="myReview"><a style="color:white;" href="/recipe/myPage_Review">요리 후기</a></li>
				</ul>
			</div>
			
			<div>
				<ul>
					<li><a href="">내가 쓴 요리후기</a></li>
					<li><a href="">받은 요리후기</a></li>
				</ul>
			</div>			
			<!-- 마이페이지 컨텐츠 -->
			<div id="myPage_Content">
				<div id="ReviewCont">
					<ul>
					<c:forEach items="${ReviewList}" var="item">
						
						<li>${item.title}</li>
						<li>${item.reply}</li>
						
					</c:forEach>
					</ul>
				 </div>
				
				
				
				<div id="ContentInfo">
					
				 
				 </div>
			</div>
		</div>
	</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


<%@ include file="../common/footer.jsp" %>
</body>
</html>