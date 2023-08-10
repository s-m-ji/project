<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원관리- 회원등록</title>

 	 <!-- Bootstrap CSS -->
 	 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	
	
	<!-- 부트스트랩 아이콘 (MI, 2023/07/26)-->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
	<!-- 폰트어썸 아이콘 (MI, 2023/07/26) -->
	<script src="https://kit.fontawesome.com/bc0f5040fb.js" crossorigin="anonymous"></script>

    <!-- 부트스트랩 css CDN (최신 버전) -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	
	<!-- 템플릿 css 모음  (MI, 2023/07/26) -->
	<link rel="stylesheet" href="/resources/assets/css/main.css" />
	<link rel="stylesheet" href="/resources/css/animate.css">
	<link rel="stylesheet" href="/resources/css/style.css">
	
	<!-- ============ recipe 플젝 css 모음 (MI, 2023/07/26) ============ -->	
	<!-- 지상미 css (MI, 2023/07/28) -->
	<link rel="stylesheet" href="/resources/recipe_css/mimi.css">
	

	<!-- 템플릿 js 모음  (MI, 2023/07/26) -->
	<script src="/resources/js/jquery.min.js"></script>
	<script src="/resources/js/jquery.easing.1.3.js"></script>
	<script src="/resources/js/bootstrap.min.js"></script>
	<script src="/resources/js/jquery.waypoints.min.js"></script>
	<script src="/resources/js/jquery.countTo.js"></script>
	<script src="/resources/js/main.js"></script>
	
	<!-- ============ recipe 플젝 js 모음 (MI, 2023/07/26) ============ -->	
	<!-- 공통 적용 -->
    <script src='/resources/recipe_js/common.js'></script> 
    
    <!-- list 파일 적용 -->
    <script src='/resources/recipe_js/listFile.js'></script>
    
    <!-- 지상미 js -->
    <script src='/resources/recipe_js/mimi.js'></script>

	<!--  adminInput.css -->
  <style>
    body {
      min-height: 100vh;

      padding-top: 100px;

     /*  background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);  */ /* 원본 */
      background: linear-gradient(to top right, #ebd9a8 0%, #ffdae6  100%);
    }

    .input-form {
      max-width: 680px;

      margin-top: 80px;
      padding: 32px;

      background: #fff;
      -webkit-border-radius: 10px;
      -moz-border-radius: 10px;
      border-radius: 10px;
      -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }
    .btn-primary{
        background-color : #ff631cb5;
        border-color: #ff631c00;
    }
    .btn-primary:hover{
        background-color: #ff962fb0;
        border-color: #ff631c00;
    }
	.copy{
		text-align: center;
	}
	.row{
		margin-top: -40px;
		margin-left: -20px;
	}
	.inputTitle{
		text-align: center;
		font-size: 1.5em;
	}
	
  </style>


</head>

<body>
  <div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3 inputTitle">회원등록👨🏻‍👩🏻‍👧🏻‍👦🏼</h4>
        
                <input type="hidden" class="form-control" id="mno" name ="mno" placeholder="회원번호" >
        <form class="memberForm" action="/recipe/adminInputAction" method="post"  accept-charset="UTF-8" enctype="multipart/form-data" novalidate>
            <div class="mb-4">
              </div>

              <div class=" mb-3">
                <label for="email">이메일</label>
                <input type="email" class="form-control" id="email" name ="email" placeholder="usermail@naver.com" required>
                <div class="invalid-feedback">
                  이메일을 등록해주세요.
                </div>
              </div>

              <div class=" mb-3">
                <label for="pw">패스워드</label>
                <input type="password" class="form-control"  id="pw" name ="pw" required>
                <div class="invalid-feedback">
                  패스워드를 등록해주세요.
                </div>
            </div>
            
          <div class="row">
            <div class="col-md-6 mb-3" style="padding-right: 36px; padding-left: 21px;">
              <label for="name">이름</label>
              <input type="text" class="form-control" id="name" name='name' placeholder="username" required>
              <div class="invalid-feedback">
                이름을 등록해주세요.
              </div>
            </div>
            <div class="col-md-6 mb-3" style="padding-right: 12px;">
              <label for="nickname">닉네임</label>
              <input type="text" class="form-control" id="nickname"  name ="nickname" placeholder="ex) 만종원"  required>
              <div class="invalid-feedback">
                닉네임을 등록해주세요.
              </div>
            </div>
          </div>

          <div class="mb-3">
            <label for="pnum">전화번호</label>
            <input type="text" class="form-control" id="pnum" name ="pnum" required>
            <div class="invalid-feedback">
              전화번호를 등록해주세요.
            </div>
          </div>

    <div class="mb-3">
            <label for="files">회원 사진</label>
            <input type="file" class="form-control" id="files" name ="files" required style="border: 1px solid white;">
            <div class="invalid-feedback">
             파일을 등록해주세요.
            </div>
          </div>

          <hr class="mb-4">
          <div class="mb-4"></div>
          <button class="btn btn-primary btn-lg btn-block"  type="submit">등록</button>
        </form>
      </div>
    </div>
    
    <footer class="my-3 text-center text-small">
      <p class="mb-1 copy"  style='text-align: center;'>&copy; 2023 오늘뭐먹조?</p>
    </footer>
  </div>

<!--  유효성 검사  -->
  <script>
    window.addEventListener('load', () => {
      const forms = document.getElementsByClassName('memberForm');

      Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', function (event) {
          if (form.checkValidity() === false) {
            event.preventDefault();
            event.stopPropagation();
          }

          form.classList.add('was-validated');
        }, false);
      });
    }, false);
  </script>
</body>
</html>