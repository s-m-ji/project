<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>로그인</title>
    
	<script src="/resources/assets/js/jquery-3.7.0.js"></script>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	
	<%@ include file="../common/header.jsp" %>
	
    <script type="text/javascript" src="/resources/recipe_js/common.js"></script>
    
    <style>

      .form-signin {
        max-width: 330px;
        padding: 15px;
      }

      .form-signin .form-floating:focus-within {
        z-index: 2;
      }

	  .middle{
	    border-bottom-right-radius: 0;
        border-bottom-left-radius: 0;
        border-top-left-radius: 0;
        border-top-right-radius: 0;
        margin-bottom: -1px;
        
	  }
      .start  {
        margin-bottom: -1px;
        border-bottom-right-radius: 0;
        border-bottom-left-radius: 0;
      }
	  
      .end  {
        margin-bottom: 10px;
        border-top-left-radius: 0;
        border-top-right-radius: 0;
      }
      #btnRegisterView {
        margin-bottom: 20px;
    }

    </style>
    
    <script>

      window.addEventListener('load',function(){
        
    	// 로그인 폼 출력
        btnRegisterView.addEventListener('click',function(){
        	location.href = '/recipe/register';
        })
		
        // 로그인
        btnSignin.addEventListener('click', function(e){
    		// 기본이벤트 제거
    		e.preventDefault();
    		
    		// 파라메터 수집`
    		let obj={
    			email : document.querySelector('#email').value
    			, pw : document.querySelector('#pw').value 
    		}
    			
    		console.log(obj);
    			
    		// 요청
    		fetchPost('/recipe/loginAction', obj, loginCheck)
    	})
    	
		
    	function loginCheck(map){
    		// 로그인 성공 -> list 로 이동
    		// 실패 -> 메세지 처리
    		if(map.result == 'success'){
    			location.href=map.url;
    		} else {
    			msg.innerHTML=map.msg;
    		}
    		console.log(map);
    	}
    	
        pleaseLogin();
    	
      })
      
      function goToRegister() {
        location.href = '/recipe/register';
    	}
      
      // 로그인 후 이용 가능 alert
      function pleaseLogin(){
    	  
    	  let message = document.querySelector("#message").value;
    	  
    	  if(message == 'false'){
    			 
    		  swal ( "앗 ! " ,  "로그인 후 이용 가능합니다." ,  "error" );
    	  		message = ",";
    	  }
    	  
    	 
      }
      
      
    </script> 
  </head>
	<body class="text-center">
	<main class="form-signin w-100 m-auto">
	
	<input type="hidden" id="message" value="${message}">
	<!-- 로그인 폼 -->
  <form name='signinForm'>
    <h1 class="h3 mb-3 fw-normal">로그인</h1>
	<div id="msg"></div>

    <div class="form-floating">
      <input type="text" class="form-control start" required="required" id="email">
      <label for="email">Email</label>
    </div>
    <div class="form-floating">
      <input type="password" class="form-control end" id="pw">
      <label for="pw">Password</label>
    </div>

    <div class="checkbox mb-3">
      <label>
        <input type="checkbox" value="remember-email"> 이메일 저장 
        <input type="checkbox" value="auto-login"> 자동로그인
      </label>
    </div>
    <button class="w-100 btn btn-lg btn-primary" type="submit" id='btnSignin'>로그인</button>
    
    <a href = "/recipe/findEmailForm">이메일 찾기</a><br>
    <a href = "/recipe/sendPwForm">임시 비밀번호 발급</a>
    
    
  </form>

	<%@ page import="java.net.URLEncoder" %>
	<%@ page import="java.security.SecureRandom" %>
	<%@ page import="java.math.BigInteger" %>
	  <%
	    String clientId = "K4dBcaR2392POv2SFnSD";//애플리케이션 클라이언트 아이디값";
	    String redirectURI = URLEncoder.encode("http://localhost:8080/login/naver_callback", "UTF-8");
	    SecureRandom random = new SecureRandom();
	    String state = new BigInteger(130, random).toString();
	    
	    // 요청URL -> 네이버로그인및 사용자정보제공 동의 -> 콜백으로 코드를 제공
	    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	    apiURL += "&client_id=" + clientId;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&state=" + state;
	    session.setAttribute("state", state);
	 %>
	 
  <button id='btnRegisterView' onclick="goToRegister()">회원가입 하러가기</button>
  
  <a href="<%=apiURL%>"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
	
	<a class="p-2" href="https://kauth.kakao.com/oauth/authorize?client_id=a88f9343e17d11ccbc54e79106cac137&redirect_uri=http://localhost:8080/recipe/list&response_type=code">
  <img src="/resources/images/kakao_login_large.png" style="height:50px"/></a>
  
</main>


   	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</body>
</html>

