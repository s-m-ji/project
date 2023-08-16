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
        top: 50%;
        left: 50%;
        transform: translate(-40%, -40%);
      }

      .form-signin .form-floating:focus-within {
        z-index: 2;
      }
      .center-container {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
      }
      .button-container {
        display: flex;
        justify-content: space-between;
        margin-top: 20px;
    }
    
    	.form-floating {
        margin-bottom: 10px;
    }
    
    </style>
      <%@ include file="../common/header.jsp" %>
</head>
<body class="text-center">
<div class="center-container">
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
	        <div class="button-container">
	    	<button onclick="goToLogin()">로그인 하러가기</button>
	    	</div>
	    
	    <script>
			var msg = '${msg}';
		    var error = '${error}';
			if (msg) {
				alert("'${msg }'\n임시 비밀번호로 로그인 해주세요. \n로그인 화면으로 돌아갑니다.");
				window.location.href = '/recipe/login';
			} else if (error) {
				alert(error);
			}
			
			function goToLogin() {
                window.location.href = '/recipe/login';
            }
		</script>
	    </form>
    </main>
    </div>
</body>
</html>