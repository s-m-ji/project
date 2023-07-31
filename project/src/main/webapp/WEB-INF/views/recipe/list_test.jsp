<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <!-- Header -->
	<%@ include file="../common/header.jsp" %>
	
	<!-- 2023/07/31 10:01 test -->
	
	<!-- Main -->
	<section id="main" style="border: 3px dashed #ed786a;">
		<div class="container">
	      <div class="bg-light p-5 rounded">
	        <h1>🍉 Recipe 🍉 </h1>
	      </div>
			<!-- <form id="deleteForm" action="./delete">
			    <input id="delNoInput" type="hidden" name="bno" value="">
			</form> -->
			<%@ include file="../common/searchForm.jsp" %>
			
			<br>
	      <div class="gtco-section">
		<div class="gtco-container">
			<div class="row">
	      <p>게시글은 총 <b>${tCnt}</b>개 입니다.</p>
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
							<div class="fh5co-text">
							 <%-- <div><input type="checkbox" class="chkBox" name="bno" value="${list.b_NO}"></div> --%>
					            <p class="mb-0 opacity-75">게시글 제목 : ${list.title}</p>
					            <p class="mb-0 opacity-75">등록일 : ${list.regdate}</p>
					            <p class="mb-0 opacity-75">재료명 : ${list.i_NAME}</p>
					            <h6 class="mb-0">작성자 닉넴 : ${list.nickName}</h6>
				           		<small class="opacity-50 text-nowrap">카테고리번호 : ${list.c_NO}</small>
							</div>
						</a>
					</div>
			        <%-- <a
			          href="#"
			          onclick="requestAction('./view', ${list.b_NO})"
			          class="list-group-item list-group-item-action d-flex gap-3 py-3"
			          aria-current="true"
			        >
			          <div class="d-flex gap-2 w-100 justify-content-between">
			           <small class="opacity-50 text-nowrap">b_NO : ${list.b_NO}</small>
			            <div><input type="checkbox" class="chkBox" name="bno" value="${list.b_NO}"></div>
			            <div><p class="mb-0 opacity-75">${list.title}</p></div>
			            <div><h6 class="mb-0">${list.nickName}</h6></div>
			            <div><p class="mb-0 opacity-75">${list.regdate}</p></div>
			            <div><p class="mb-0 opacity-75">cateName : ${list.cateName}</p></div>
			           <small class="opacity-50 text-nowrap">c_NO : ${list.c_NO}</small>
			          </div>
			        </a> --%>
	        		</c:forEach>
				</c:otherwise>
			</c:choose>
	      </div>
	      </div>
		</div>
	      <%@ include file="../common/pageNavi.jsp" %>
		</div>
	</section>
		
	<!-- Footer -->
	<%@ include file="../common/footer.jsp" %>
