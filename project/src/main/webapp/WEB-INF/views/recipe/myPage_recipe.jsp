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
	
	#notResult{
		    position: relative;
		    display: grid;
		    margin: 0 auto;
		    font-weight: 900;
	}
	
	.limit-lines {
	  display: -webkit-box;
	  -webkit-box-orient: vertical;
	  -webkit-line-clamp: 2;
	  overflow: hidden;
	}
	
	.Mactive {
		  background-color: #fff; /* Set your desired background color */
		  border: 1px solid #c7c4c9;
		  margin-left: 30px;
		  border-bottom: 1px solid #fff;
		  margin-bottom: -1px;
	      font-weight: 900;
	}
	
	
	.recipeModeTab{
		margin-left: 30px;
	}
	
	/* 3개 탭 */
	#myRecipe{
		background-color: #F7863B;
	    font-weight: 900;
	    color: aliceblue;
	    
	}
	
	#myInfo{
		margin-left: 5px;
	}
	
	.truncated {
	  overflow: hidden;
	  text-overflow: ellipsis;
	  display: -webkit-box;
	  -webkit-box-orient: vertical;
	  -webkit-line-clamp: 2;
	}
	
		.mainTab {
	    line-height: 20px;
	    width: 100%;
	    margin: 0 auto;
	    margin-top: 10px;
	    padding: 0 5px;
	}

	.mainTab > span {
	    display: inline-block;
	    width: 90%;
	    font-size: 14px;
	    white-space: nowrap;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    color: black;
	    font-weight: 900;
	}
	
	.mainTab > .author {
	    font-size: 12px;
	    font-weight: 600;
	    color: #23080896;
	}
	
	.mainTab > p {
	    overflow: hidden;
	    white-space: nowrap;
	    text-overflow: ellipsis;
	    margin: 5px 0;
	}
	
	
	
	
</style>

<%@ include file="../common/header.jsp" %>


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
			const myRec = document.querySelector("#myRec");
			const likeRec = document.querySelector("#likeRec");
			
			
			if(mode == "myRecipe"){
				
				myRec.classList.add("Mactive");
				likeRec.classList.remove("Mactive");
				
			}else{
				myRec.classList.remove("Mactive");
				likeRec.classList.add("Mactive");
			}
			
		}
		
		
		$(document).ready(function() {
			  $('.limit-lines').each(function() {
			    var maxHeight = parseFloat($(this).css('line-height')) * 2;
			    if ($(this).height() > maxHeight) {
			      $(this).addClass('truncated');
			    }
			  });
			});
	

</script>
</head>
<body>


<!-- 세션에서 받아오기 필요  -->
<input type="hidden" id="m_no" value="1">
<input type="hidden" id="mode" value="${param.mode}">
	<script type="text/javascript">
		
	</script>
	<section id="features" style="background-color: #f7863b36;">
		<!-- 전체 container -->
		<div style="height: 500px;" id="myPage_Con">
			<!-- 상단 탭 -->
			<div id="myPage_tab">
				<ul >
					<li class="hoverTab" id="myInfo"><a href="/recipe/myPage2">나의 정보</a></li>
					<li class="hoverTab" id="myRecipe"><a style="color:white;" href="/recipe/myList?mode=myRecipe">레시피</a></li>
					<li class="hoverTab" id="myReview"><a href="/recipe/myPage_Review?mode=myWrite">요리 후기</a></li>
				</ul>
			</div>
			
			<!-- 마이페이지 컨텐츠 -->
			<div id="myPage_Content">
				<div id="myImg_nickname">
					<!--  <img style="width: 100px; height: 100px; border-radius: 50%;" src="/display?fileName=${savePath}">--> 
				 	<!--   <span>별명 :${member.nickname} </span>-->
				 </div>
				
				<div>
					<ul style="display: flex; border-bottom: 1px solid #c7c4c9;">
						<li id="myRec" style="width: 15%;  " class="recipeModeTab toggleable-tab"><a href="/recipe/myList?mode=myRecipe">나의 레시피</a></li>
						<li id="likeRec" style="width: 15%;" class="recipeModeTab toggleable-tab"><a href="/recipe/myList?mode=myLike">찜한 레시피</a></li>
					</ul>
				</div>
				<div id="ContentInfo">
					<ul style="display: flex">
					
					<c:if test="${empty myList}">
							
		           	 		<li id="notResult"><img style="width: 50%; margin: 0 auto;" src="/resources/img/조회결과 없음.jpg">조회된 결과가 없습니다</li>
					</c:if>
					
					<c:forEach items="${myList}" var="item">
		        	 	
			           	 <li class="hoverOutLine" style="width: 17%; position: relative; height: 250px; border: 1px solid #d9c2c2; margin-left: 20px;"><a href="/recipe/view?b_no=${item.b_no}">
			           	 	<div>
			           	 		<img style="width: 70%; height: 100px;" src="/display?fileName=${item.savePath}">
			           	 	</div>
			           	 	<div class="mainTab"> 
			           	 		<span style="color: black;  font-weight: 900;">${item.title}</span>
			           	 		<p style="margin-top: 25px; font-size: 12px; font-weight: 600; color:#23080896;">by ${item.nickname}</p> 	
			           	 	</div>
			           	 	<div style="position: absolute; margin-top: 33px; bottom: 0; width: 100%; background-color: yellowgreen; height: 35px "> </div>
			           	 	</a>
			           	 </li> <!-- Modify according to your data structure -->
		           	 	
		           	 
		           	 
		        	</c:forEach>
		        		        		
					</ul>
					
					<div style="float: right;"><button class="btn btn-primary me-md-2" onclick="location.href='/recipe/rec_write'" href ='#' class="aName">글쓰기</button></div> 
				 </div>
			</div>
		</div>
	</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


<%@ include file="../common/footer.jsp" %>
</body>
</html>