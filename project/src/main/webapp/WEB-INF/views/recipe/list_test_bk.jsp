<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <!-- 브라우저 탭 제목 -->
    <title>레시피 list</title>
    
    <!-- Header -->
	<%@ include file="../common/header.jsp" %>
	
	<!-- Main -->
	<section id="main" style="border: 5px dashed #FBB448;">
		<div class="container">
	      <div class="bg-light p-5 rounded"><h1>👩‍🍳  레시피 👩‍🍳</h1></div>
			<!-- 검색폼 -->	
			<%@ include file="../common/searchForm.jsp" %>
	      <div class="gtco-section">
			<div class=""> <!-- <div class="gtco-container"> -->
			<div class="container text-center">
			<div class="row">
			
	      <c:choose>
				<c:when test="${empty list}">
				<div class="d-flex gap-2 w-100 justify-content-between">
			       <div><p>🤷‍♀ 등록된 게시글이 없는걸 ??? 🤷‍♀️</p></div>
			    </div>
				</c:when>
				
				<c:otherwise>
					<c:forEach items="${list}" var="list">
					<div class="col-lg-4 col-md-4 col-sm-6">
						<a href="#" class="fh5co-card-item image-popup" onclick="requestAction('./view_test', ${list.b_NO})">
							<figure>
								<div class="overlay"><i class="bi bi-box-arrow-up-right"></i></div>
								<img src="/resources/images/꼬시래기물냉면.jpg" alt="Image" class="img-responsive">
							</figure>
							<div class="fh5co-text position-relative">
					            <p class="mb-0">✅ ${list.b_NO}</p>
					            <p class="mb-0">🍴 ${list.title}</p>
					            <p class="mb-0">📝  ${list.intro}</p>
					            <p class="mb-0">🙋‍♀️‍ ${list.nickName}</p>
					            <p class="mb-0">👍 ${list.boomup} &nbsp; 👀 ${list.viewcnt}</p> 
				           		<p class="mb-0">${list.c_NO1} - ${list.cateName1} , ${list.c_NO2} - ${list.cateName2}</p>
				           		<!-- 
				           			오늘 등록 : 몇시간 전
				           			일주일 내로 등록 : 며칠 전
				           			그 외 : 2023/00/00
				           		 -->
					            <p class="mb-0">${list.regdate}</p>
					            <!-- 3일 내로 등록한 글이면 new 표시 -->
								<c:if test="${ not empty list.newpost}">
									<span class="position-absolute top-0 start-90 translate-middle badge rounded-pill bg-danger"> ${list.newpost} </span>
								</c:if>
							</div>
						</a>
					</div>
	        		</c:forEach>
				</c:otherwise>
			</c:choose>
	      </div>
	      </div>
	      </div>
		</div>
	      <%@ include file="../common/pageNavi.jsp" %>
		</div>
	</section>
		
	<!-- Footer -->
	<%@ include file="../common/footer.jsp" %>