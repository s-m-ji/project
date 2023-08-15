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
	#myInfo{
		background-color: #F7863B;
	    font-weight: 900;
	    color: aliceblue;
	    margin-left: 5px;
	}
	
	
	
	
</style>

<%@ include file="../common/header.jsp" %>

</head>
<body>


	<h2>마이페이지 입니다.</h2>
	<section id="features">
		<!-- 전체 container -->
		<div id="myPage_Con">
			<!-- 상단 탭 -->
			<div id="myPage_tab">
				<ul>
					<li class="hoverTab" id="myInfo"><a style="color:white;" href="/recipe/myPage2">나의 정보</a></li>
					<li class="hoverTab" id="myRecipe"><a href="/recipe/myList?mode=myRecipe">레시피</a></li>
					<li class="hoverTab" id="myReview"><a href="/recipe/myPage_Review">요리 후기</a></li>
				</ul>
			</div>
			
			<!-- 마이페이지 컨텐츠 -->
		<div id="myPage_Content">
			<table >
				<tbody>
				
				<tr >
					<th style="background: #e6e6e6; border: 1px solid; width: 30%; padding-left: 40px;">프로필 사진 & 별명</th>
					<td style="border:1px solid">	
						<div id="myImg_nickname">
					
							<c:choose>
								<c:when test="${not empty savePath}">
									<img style="width: 100px; height: 100px; border-radius: 50%;" src="/display?fileName=${savePath}"> 
								</c:when>
								<c:otherwise>
									<img style="width: 100px; height: 100px; border-radius: 50%;" src="/resources/img/기본이미지.jpg">
								</c:otherwise>
							</c:choose>
							
						 	<span id="nicknameS" style="margin-left: 20px;">${member.nickname}</span>
						</div>
				 </td>
				</tr>
				
				<tr>
					<th style="background: #e6e6e6; border: 1px solid; width: 30%; padding-left: 40px; height: 60px;" >이메일</th>
					<td style="border:1px solid">
						
						 ${member.email}
						 
					 </td>
				  </tr>
				  
			  <tr>
			  	<th style="background: #e6e6e6; border: 1px solid; width: 30%; padding-left: 40px; height: 60px;">이름</th>
			  	<td>
			  			${member.name}
			  	</td>
			  </tr>
			  
			  <tr >
			  	
			  	<td colspan="2">
			  		<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			  		<button class="btn btn-primary me-md-2" onclick="location.href='/recipe/myPageUpdate'">내정보 수정</button>
			  		</div>
			  	</td>
			  </tr>
				 	</tbody>
				 </table>
			</div>
		</div>
	</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


<%@ include file="../common/footer.jsp" %>
</body>
</html>