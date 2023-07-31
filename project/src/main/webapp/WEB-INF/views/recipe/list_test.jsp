<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <!-- Header -->
	<%@ include file="../common/header.jsp" %>
	
	<!-- Main -->
	<section id="main" style="border: 5px dashed #FBB448;">
		<div class="container">
	      <div class="bg-light p-5 rounded">
	        <h1>👩‍🍳  Recipe 👩‍🍳</h1>
	      </div>
			<!-- <form id="deleteForm" action="./delete">
			    <input id="delNoInput" type="hidden" name="bno" value="">
			</form> -->
			<%@ include file="../common/searchForm.jsp" %>
			
			<br>
	      <div class="gtco-section">
		<div class="gtco-container">
		<div class="container text-center">
			  <div class="row">
			    <div class="col">
			      <p style="font-size:16px">게시글은 총 <b class="badge bg-secondary" style="font-size:16px">${tCnt}</b>개 입니다.</p>
			    </div>
			    <div class="col">
				<div class="btn-group" role="group">
				<form id="orderForm" method="get" action="/recipe/list_test">
				    <button type="button" id="orderByRG" class="btn btn-success" onclick="changeOrderBy(true)">최신순</button>
				    <button type="button" id="orderByBU" class="btn btn-warning" onclick="changeOrderBy(false)">추천순</button>
				    <input type="hidden" id="orderByInput" name="orderBy" value="true">
				</form>
				</div>
			<script type="text/javascript">
			    function changeOrderBy(orderByRegidateFlag) {
			        document.getElementById("orderByRG").disabled = orderByRegidateFlag;
			        document.getElementById("orderByBU").disabled = !orderByRegidateFlag;
			
			        // 버튼 클릭 시 orderBy 값 변경
			        document.getElementById("orderByInput").value = orderByRegidateFlag;
			
			        // 폼 제출 (페이지 새로고침)
			        document.getElementById("orderForm").submit();
			    }
			</script>

				
			    </div>
			  </div>
			  </div>
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
						<a href="#" class="fh5co-card-item image-popup" onclick="requestAction('./view', ${list.b_NO})">
							<figure>
								<div class="overlay"><i class="bi bi-box-arrow-up-right"></i></div>
								<img src="/resources/images/꼬시래기물냉면.jpg" alt="Image" class="img-responsive">
							</figure>
							<div class="fh5co-text position-relative">
					            <p class="mb-0">✅ ${list.b_NO}</p>
					            <p class="mb-0">📝 ${list.title}</p>
					            <p class="mb-0"> ${list.intro}</p>
				           		<p class="mb-0"> ${list.c_NO1}, ${list.c_NO2}</p>
					            <p class="mb-0"> ${list.cateName1}, ${list.cateName2}</p>
					            <p class="mb-0"> ${list.regdate}</p>
					            <p class="mb-0">🙋‍♀️‍ ${list.nickName}</p>
					            <p class="mb-0">👍 ${list.boomup}</p>
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
