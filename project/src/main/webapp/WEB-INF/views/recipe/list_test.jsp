<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <!-- Header -->
	<%@ include file="../common/header.jsp" %>
	
	<!-- Main -->
	<section id="main" style="border: 3px dashed #ed786a;">
		<div class="container">
	      <div class="bg-light p-5 rounded">
	        <h1>📚 목록 보기 📚 </h1>
	        <p class="lead"></p>
	        <a class="btn btn-sm btn-dark" href="./write" role="button" target="_blank">글쓰기</a>
	        <a class="btn btn-sm btn-dark" href="#" role="button" onclick="deletelist();">선택한 글 삭제하기</a> 
	      </div>
	      
			<form id="deleteForm" action="./delete">
			    <input id="delNoInput" type="hidden" name="bno" value="">
			</form>
	
		<%@ include file="../common/searchForm.jsp" %>
	      <div class="list-group w-auto">
	      <p>게시글은 총 <b>${tCnt}</b>개 입니다.</p>
	      
	      <c:choose>
				<c:when test="${empty list}">
				<div class="d-flex gap-2 w-100 justify-content-between">
			       <div><p>🤷‍♀ 등록된 게시글이 없는걸 ??? 🤷‍♀️</p></div>
			    </div>
				</c:when>
				
				<c:otherwise>
					<c:forEach items="${list}" var="list">
			        <a
			          href="#"
			          onclick="requestAction('./view', ${list.b_NO})"
			          class="list-group-item list-group-item-action d-flex gap-3 py-3"
			          aria-current="true"
			        >
			          <div class="d-flex gap-2 w-100 justify-content-between">
			            <div><input type="checkbox" class="chkBox" name="bno" value="${list.b_NO}"></div>
			            <div><p class="mb-0 opacity-75">${list.title}</p></div>
			            <div><h6 class="mb-0">${list.nickName}</h6></div>
			            <div><p class="mb-0 opacity-75">${list.regdate}</p></div>
			           <small class="opacity-50 text-nowrap">${list.c_NO}</small>
			          </div>
			        </a>
	        		</c:forEach>
				</c:otherwise>
			</c:choose>
	      </div>
	      <%@ include file="../common/pageNavi.jsp" %>
		</div>
	</section>
		
	<!-- Footer -->
	<%@ include file="../common/footer.jsp" %>
