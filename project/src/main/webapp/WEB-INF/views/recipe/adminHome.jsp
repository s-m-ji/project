<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지 </title> 
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<!-- 부트스트랩을 사용하기 위해서 css, js를 추가 합니다. -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

 	<!--  notice의 css   ** recipe_css 로 -->
 	<link rel="stylesheet" type="text/css" href="../resources/recipe_css/notice.css">
 	
 	    <!-- Header -->
	<%@ include file="../common/header.jsp" %>
	
	
	<!-- swal -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

	<script type="text/javascript">
	window.addEventListener('load', function(){
		
		mainBtn.addEventListener('click', function(){
			location.href = "/recipe/main";
		})
		
		pleaseLogin();
	});
	
	function pleaseLogin(){

  	  let message = document.querySelector("#message").value;
  	  if(message === 'false'){
  		  swal ( "앗 ! " ,  "로그인 후 이용 가능합니다." ,  "error" );
  	  }
	}
	</script>
</head>
<body>
<%-- <c:if test="${not empty member.role}"> --%>
 <input type="hidden" id="message" value="${message}">
<!-- 여기에서 관리자 페이지 만들어보고 다 붙이기 !!!! -->
 <!-- Main -->
<section id="main">
	<div class="container">
<!-- <!-- Features -->
    <div class="container">
 <section id="features"> 

        <header>
            <h3 style="padding-bottom: 30px;">이곳은 <strong>☘️관리자 페이지☘️</strong>입니다</h3>
       
        </header>
        <div class="row aln-center">
            <div class="col-4 col-6-medium col-12-small">
                    <section>
                        <a href="/recipe/admin" class="image featured"><img src="../resources/images/member.jpg" alt=""style="width: 100%; height: 278px;"/></a>
                        <header>
                            <h4>회원 관리👨🏻‍👩🏻‍👧🏻‍👦🏼</h4>
                        </header>
                    </section>

            </div>
            <div class="col-4 col-6-medium col-12-small">
                    <section>
                        <a href="/recipe/notice" class="image featured"><img src="../resources/images/notice.jpeg" alt=""  style="width: 100%; height: 278px;"/></a>
                        <header>
                            <h4>공지 관리📝</h4>
                        </header>
                    </section>

            </div>
            <div class="col-4 col-6-medium col-12-small">
                    <section>
                        <a href="/recipe/reward" class="image featured"><img src="../resources/images/reward2.jpg" alt=""  style="width: 100%; height: 278px;"/></a>
                        <header>
                            <h4>리워드 관리🏆</h4>
                        </header>
                    </section>

            </div>
            <div class="col-12">
                <ul class="actions">
                    <li><button id="mainBtn" style='color: white;' onclick="goBack()" >메인으로 돌아가기</button></li>
                </ul>
            </div>
        </div>
        </section> 
    </div>
	</div>
</section>
<%-- </c:if> --%>
<!-- Footer -->
	<%@ include file="../common/footer.jsp" %>
