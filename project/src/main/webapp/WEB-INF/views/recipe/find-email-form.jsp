<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>�̸��� ã��</title>
    
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
	        <h2 class="h3 mb-3 fw-normal">�̸��� ã��</h2>
	            <div class="form-floating" style="display: inline-block;">
	                <label for="name">�̸� : </label>
	                <input type="text" id="name" name="name" required>
	            </div>
	            <div class="form-floating" style="display: inline-block;">
	                <label for="pNum">��ȭ��ȣ : </label>
	                <input type="text" id="pnum" name="pnum" required>
	            </div>
	            <div class="form-group">
	                <input type="submit" value="ã��">
	       		</div>
	       		<div class="button-container">
	       		<button onclick="goToLogin()">�α��� �Ϸ�����</button>
				</div>
	            <script>
				// alert("���Ե� �̸����� : '${foundEmail }' �Դϴ�.");
				
				var foundEmail = '${foundEmail}';
			    var error = '${error}';
				if (foundEmail) {
					alert("���Ե� �̸����� : '${foundEmail }' �Դϴ�.\n�α��� ȭ������ ���ư��ϴ�.");
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