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

  <style>
    body {
      min-height: 100vh;

      padding-top: 100px;

      background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);  /* 원본 */
      background: linear-gradient(to top right, #ebd9a8 0%, #ff9658 100%);
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
  </style>
</head>
<!-- -- MNO,EMAIL,PW,NAME,NICKNAME,PNUM -->
<body>
  <div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3" style='text-align: center;'>회원등록👨🏻‍👩🏻‍👧🏻‍👦🏼</h4>
        <form class="memberForm" action="/recipe/adminInputAction" method="post"  accept-charset="UTF-8" novalidate>
            <div class="mb-4">
                <input type="hidden" class="form-control" id="mno" name ="mno" placeholder="회원번호" >
              </div>

              <div class=" mb-3">
                <label for="email">이메일</label>
                <input type="email" class="form-control" id="email" placeholder="usermali@naver.com" required>
                <div class="invalid-feedback">
                  이메일을 등록해주세요.
                </div>
              </div>

              <div class=" mb-3">
                <label for="pw">패스워드</label>
                <input type="password" class="form-control" id="pw" placeholder="" required>
                <div class="invalid-feedback">
                  패스워드를 등록해주세요.
                </div>


            </div>
          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="name">이름</label>
              <input type="text" class="form-control" id="name" name='name' placeholder="username" value="" required>
              <div class="invalid-feedback">
                이름을 등록해주세요.
              </div>
            </div>
            <div class="col-md-6 mb-3">
              <label for="nickname">닉네임</label>
              <input type="text" class="form-control" id="nickname" placeholder="ex) 만종원" value="" required>
              <div class="invalid-feedback">
                닉네임을 등록해주세요.
              </div>
            </div>
          </div>

          <div class="mb-3">
            <label for="pnum">전화번호</label>
            <input type="text" class="form-control" id="pnum" placeholder="" required>
            <div class="invalid-feedback">
              전화번호를 등록해주세요.
            </div>
          </div>

      
          <hr class="mb-4">
          <!-- <div class="custom-control custom-checkbox">
            <input type="checkbox" class="custom-control-input" id="aggrement" required>
            <label class="custom-control-label" for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
          </div> -->
          <div class="mb-4"></div>
          <button class="btn btn-primary btn-lg btn-block" type="submit">등록</button>
        </form>
      </div>
    </div>
    <footer class="my-3 text-center text-small">
      <p class="mb-1">&copy; 2023 오늘뭐먹조?</p>
    </footer>
  </div>

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