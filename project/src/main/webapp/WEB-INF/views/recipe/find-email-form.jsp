<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이메일 찾기</title>
    
    <script src="/resources/assets/js/jquery-3.7.0.js"></script>
    <script type="text/javascript" src="/resources/recipe_js/common.js"></script>
    
    <style>
      .form-signin {
        max-width: 330px;
        padding: 15px;
        top: 50%;
        left: 50%;
        transform: translate(-20%, -40%);
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
	    <div class="container">
	        <form id= "emailForm" action="/recipe/findEmail" method="post">
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
	       		<div class="button-container">
	       		<button onclick="goToLogin()">로그인 하러가기</button>
				</div>
	            <script>
				// alert("가입된 이메일은 : '${foundEmail }' 입니다.");
				
				var foundEmail = '${foundEmail}';
			    var error = '${error}';
				if (foundEmail) {
					alert("가입된 이메일은 : '${foundEmail }' 입니다.\n로그인 화면으로 돌아갑니다.");
					window.location.href = '/recipe/login';
				} else if (error) {
					alert(error);
				}
				
				function goToLogin() {
	                window.location.href = '/recipe/login';
	            }
				
				document.getElementById('pnum').addEventListener('input', function (e) {
		    	    var input = e.target;
		    	    var value = input.value.replace(/\D/g, '');

		    	    if (value.length > 3 && value.length <= 7) {
		    	        value = value.replace(/(\d{3})(\d{1,4})/, '$1-$2');
		    	    } else if (value.length > 7) {
		    	        value = value.replace(/(\d{3})(\d{4})(\d{1,4})/, '$1-$2-$3');
		    	    }

		    	    input.value = value;
		    	});
				</script>
	        </form>
	    </div>
	</main>
	</div>
</body>
</html>