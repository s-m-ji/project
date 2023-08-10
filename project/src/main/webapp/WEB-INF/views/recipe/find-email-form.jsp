<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이메일 찾기</title>
    
    <script src="/resources/assets/js/jquery-3.7.0.js"></script>
    
    <style>
      .form-signin {
        max-width: 330px;
        padding: 15px;
      }

      .form-signin .form-floating:focus-within {
        z-index: 2;
      }
    </style>
      <%@ include file="../common/header.jsp" %>
</head>
<body class="text-center">
	<main class="form-signin w-100 m-auto">
	    <div class="container">
	        <form action="/recipe/findEmail" method="post">
	        <h2 class="h3 mb-3 fw-normal">이메일 찾기</h2>
	            <div class="form-floating" style="display: inline-block;">
	                <label for="name">이름 : </label>
	                <input type="text" id="name" name="name" required>
	            </div>
	            <div class="form-floating" style="display: inline-block;">
	                <label for="pNum">전화번호 : </label>
	                <input type="text" id="pnum" name="pnum" required>
	            </div>
	            <div class="form-group">
	                <input type="submit" value="찾기">
	       		</div>
	            ${foundEmail }
	            ${error }
	        </form>
	    </div>
	</main>
</body>
</html>