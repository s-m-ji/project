<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>비밀번호 찾기</title>

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
	    <form action="/recipe/sendPw" method="post">
	    <h2 class="h3 mb-3 fw-normal">임시 비밀번호 발급</h2>
	        <div class="form-floating">
		        <label for="email">이메일:</label>
		        <input type="text" id="email" name="email" required>
		    </div>
		    <div class="form-floating">
		        <label for="name">이름:</label>
		        <input type="text" id="name" name="name" required>
	        </div>
	        
	        <button type="submit">임시 비밀번호 발송</button>
	    
	    ${msg }    
	    ${error }
	    </form>
    </main>
</body>
</html>