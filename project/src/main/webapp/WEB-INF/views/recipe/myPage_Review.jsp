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
<link rel="stylesheet" href="/resources/recipe_css/mimi.css">

<style>
	
	
	.Mactive {
		  background-color: #fff; /* Set your desired background color */
		  border: 1px solid;
		  margin-left: 30px;
		  border: 1px solid; border-bottom: 1px solid #fff; margin-bottom: -1px;
	}
	
	/* 3개 탭 */
	#myReview{
		background-color: #F7863B;
	    font-weight: 900;
	    color: aliceblue;
	    
	}
	
	#myInfo{
		margin-left: 5px;
	}
	
	.recipeModeTab{
		margin-left: 30px;
	}
	
	.mainTab{
		line-height: 20px; width: 80%; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; width: 70%; 
		margin:0 auto;
		margin-top: 10px;
		padding: 0 5px;
	}
	
	
</style>

<%@ include file="../common/header.jsp" %>

<script>
	// ▶▶▶  게시글 페이지네이션
	function go(page){
		
		const mode = document.querySelector("#mode").value;
		document.searchForm.action = "./myPage_Review";
		document.searchForm.mode.value= mode;
		document.searchForm.pageNo.value= page;
		document.searchForm.submit();
	}
	</script>

<script type="text/javascript">

		window.addEventListener('load',function(){
			
			
			modeChange();
			
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
		
		function modeChange(){
			
			const mode = document.querySelector("#mode").value;
			console.log(mode);
			const writeReview = document.querySelector("#writeReview");
			const receiveReview = document.querySelector("#receiveReview");
			
			
			if(mode == "myWrite"){
				
				writeReview.classList.add("Mactive");
				receiveReview.classList.remove("Mactive");
				
			}else{
				
				writeReview.classList.remove("Mactive");
				receiveReview.classList.add("Mactive");
			}
			
		}
		
		
	
</script>
</head>
<body>
<form action="./myPage_Review"  name="searchForm">
<input type="text" name="pageNo" value="${pDto.cri.pageNo}">
<input type="text" id="m_no" value="1">
<input type="text" id="mode" name="mode" value="${param.mode}">	
</form>	
	
	<h2>요리후기 페이지 입니다.</h2>
	<section id="features" style="background-color: #f7863b36;">
		<!-- 전체 container -->
		<div id="myPage_Con">
			<!-- 상단 탭 -->
			<div id="myPage_tab">
				<ul>
					<li class="hoverTab" id="myInfo"><a href="/recipe/myPage2">나의 정보</a></li>
					<li class="hoverTab" id="myRecipe"><a href="/recipe/myList?mode=myRecipe">레시피</a></li>
					<li class="hoverTab" id="myReview"><a style="color:white;" href="/recipe/myPage_Review?mode=myWrite">요리 후기</a></li>
				</ul>
			</div>
			
			<div>
				<ul style="display: flex; border-bottom: 1px solid;">
					<li style="width: 15%;" id="writeReview" class="recipeModeTab"><a href="/recipe/myPage_Review?mode=myWrite">내가 쓴 요리후기</a></li>
					<li style="width: 15%;" id="receiveReview" class="recipeModeTab"><a href="/recipe/myPage_Review?mode=myReceive">받은 요리후기</a></li>
				</ul>
			</div>			
			<!-- 마이페이지 컨텐츠 -->
			<div id="myPage_Content">
				<div id="ReviewCont">
					<ul style="display: flex;">
					
					<c:if test="${empty ReviewList}">
							<li>조회된 결과가 없습니다.</li>
						</c:if>
					
					<c:forEach items="${ReviewList}" var="item">
						
						<!-- ------------------------------------ -->
						 <li style="width: 17%; position: relative; height: 250px; border: 1px solid; margin-left: 10px;"><a href="/recipe/view?b_no=${item.b_no}">
		           	 	<div>
		           	 		
		           	 		<img style="width: 70%; height: 100px;" src="/display?fileName=${item.savePath }">
		           	 	</div>
		           	 	<div class="mainTab"> 
		           	 		<span style="color: black;  font-weight: 900;">${item.reply}</span>
		           	 		<p style="margin-top: 5px; font-size: 12px; font-weight: 600; color:#23080896;">by ${item.writer}</p> 	
		           	 		<p>${item.title}</p>
		           	 	</div>
		           	 	<div style="position: absolute; margin-top: 33px; bottom: 0; width: 100%; background-color: yellowgreen; height: 35px "> </div></a></li>
			
						
						
					</c:forEach>
					</ul>
				 </div>
				
				
				
				<div id="ContentInfo">
					
				 
				 </div>
			</div>
		</div>
		
		<%@ include file="../common/pageNavi.jsp" %>
	</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


<%@ include file="../common/footer.jsp" %>
</body>
</html>