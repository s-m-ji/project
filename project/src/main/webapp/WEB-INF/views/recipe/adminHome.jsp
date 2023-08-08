<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지 </title> 
    <!-- Header -->
	<%@ include file="../common/header.jsp" %>
	
	<script type="text/javascript">
	window.addEventListener('load', function(){
		
		mainBtn.addEventListener('click', function(){
			location.href = "/recipe/main";
		})
	});
	</script>
</head>
<body>
<!-- 여기에서 관리자 페이지 만들어보고 다 붙이기 !!!! -->
 <!-- Main -->
<section id="main">
	<div class="container">
<!-- Features -->
<section id="features">
    <div class="container">
        <header>
            <h2>This is <strong>관리자 페이지</strong>!</h2>
        </header>
        <div class="row aln-center">
            <div class="col-4 col-6-medium col-12-small">

                <!-- Feature -->
                    <section>
                        <a href="/recipe/admin" class="image featured"><img src="../resources/images/member.jpg" alt="" style="width: 100%; height: 100%;"/></a>
                        <header>
                            <h1>회원 관리👨🏻‍👩🏻‍👧🏻‍👦🏼</h1>
                        </header>
                    </section>

            </div>
            <div class="col-4 col-6-medium col-12-small">

                <!-- Feature -->
                    <section>
                        <a href="/recipe/notice" class="image featured"><img src="../resources/images/notice.jpeg" alt=""  style="width: 100%; height: 210px;"/></a>
                        <header>
                            <h1>공지 관리📝</h1>
                        </header>
                    </section>

            </div>
            <div class="col-4 col-6-medium col-12-small">

                <!-- Feature -->
                    <section>
                        <a href="/recipe/reward" class="image featured"><img src="../resources/images/reward2.jpg" alt=""  style="width: 100%; height: 210px;"/></a>
                        <header>
                            <h1>리워드 관리🏆</h1>
                        </header>
                    </section>

            </div>
            <div class="col-12">
                <ul class="actions">
                    <li><button id="mainBtn" style='color: white;' onclick="goBack()" >메인으로 돌아가기</button></li>
                </ul>
            </div>
        </div>
    </div>
</section>

	</div>
</section>

<!-- 
<script>
    // 버튼 클릭 시 실행될 함수
    document.getElementById("mainBtn").addEventListener("click", function() {
        // 페이지 이동
        window.location.href = "../recipe/main";
    });
</script>

 -->
<!-- Footer -->
	<%@ include file="../common/footer.jsp" %>
