<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<html lang="en">
<head>
<meta charset="utf-8">
    <title>회원가입</title>
	<script src="/resources/assets/js/jquery-3.7.0.js"></script>

    <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/sign-in/">

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

	<%@ include file="../common/header.jsp" %>

    <style>
      .form-signin {
        max-width: 500px;
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
      .form-floating {
	        position: relative;
	    }
	
	    .form-floating button {
	        position: absolute;
	        top: 50%;
	        right: 10px;
	        transform: translateY(-50%);
	    }



	/* css 추가 (MI, 2023/08/17) */
		.btn.btn-primary:hover {
			    background: #f9a974;
		}
		
		.container.text-center {
			padding: 50px 0;
		}
		
		#btnSignin {
			margin-bottom: 20px;
		}
		
		#btnRegisterView {
			margin-top: 20px;
		}
		
		#signupMsg {
			display: inline-block;
    	background: #f7863b50;
	    padding: 0 5px;
   	 	margin: 5px;
		}
		
    </style>
    <script type="text/javascript" src="/resources/recipe_js/common.js"></script>
    <script>

      window.addEventListener('load',function(){
        
    	btnSigninView.addEventListener('click',function(){
    		location.href = '/recipe/login';
          })
    	  
		signUpNickname.addEventListener('blur', function(){
    		
    		// 입력체크
			if(!signUpNickname.value){
				signupMsg.innerHTML = '닉네임을 입력 해주세요';
				return;
			}
			
			// 파라메터 세팅
			let obj={ nickname : signUpNickname.value };
			console.log("닉네임 체크", obj);
			
			// 닉네임 체크 -> 서버에 다녀와야 해요
			fetchPost('/recipe/nicknameCheck', obj, (map)=>{
		    	  if(map.result == 'success'){
		    		  nicknameCheckRes.value='1'; // 닉네임 사용 가능
		    		  signUpPNum.focus();
		    	  } else {
		    		  nicknameCheckRes.value='0'; // 닉네임 사용 불가능
		    		  signUpNickname.focus();
		    		  signUpNickname.value='';
		    	  }
		   		  signupMsg.innerHTML = map.msg; // 메세지 출력
		    });
    	});
    	
        signUpPw.addEventListener('blur', function(){
            if (!signUpPw.value) {
                signupMsg.innerHTML = '비밀번호를 입력해주세요';
                return;
            }

            if (signUpPw.value.length < 8) {
                signupMsg.innerHTML = '비밀번호는 최소 8자리 이상이어야 합니다.';
                signUpPw.value = '';
                return;
            }

            // 소문자 알파벳, 숫자, 특수문자 포함 여부 검사
            const passwordPattern = /^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$/;
            if (!passwordPattern.test(signUpPw.value)) {
                signupMsg.innerHTML = '비밀번호는 소문자 알파벳, 숫자, 특수문자를 모두 포함해야 합니다.';
                signUpPw.value = '';
                return;
            }
            
        });
        
        pwCheck.addEventListener('blur', function(){
            if (!signUpPw.value) {
                signupMsg.innerHTML = '비밀번호를 입력해주세요';
                return;
            }

            if (pwCheck.value && signUpPw.value !== pwCheck.value) {
                signupMsg.innerHTML = '비밀번호가 일치하지 않습니다.';
                pwCheckRes.value = 0;
                pwCheck.value = '';
                return;
            }

            // 비밀번호 확인 필드까지 입력되었고 모든 검증 조건을 통과한 경우
            pwCheckRes.value = 1;
            signupMsg.innerHTML = '';
        });
    	
    	btnSignup.addEventListener('click', function(e){
        	// 기본 이벤트 초기화
        	e.preventDefault();
        	
        	let email = signUpEmail.value;
        	let comfirmemail = confirmCode.value;
        	let pw = signUpPw.value;
        	let name = signUpName.value;
        	let nickname = signUpNickname.value;
        	let pNum = signUpPNum.value;
        	
        	
        	if(!email){
        		signupMsg.innerHTML = '이메일을 입력해주세요';
        		return;
        	}
        	if(!comfirmemail){
        		signupMsg.innerHTML = '이메일로 받은 인증번호를 입력해주세요';
        		return;
        	}
        	if(!pw){
        		signupMsg.innerHTML = '비밀번호를 입력해주세요';
        		return;
        	}
        	if(!name){
        		signupMsg.innerHTML = '이름을 입력해주세요';
        		return;
        	}
        	if(!nickname){
        		signupMsg.innerHTML = '닉네임을 입력해주세요';
        		return;
        	}
        	if(!pNum){
        		signupMsg.innerHTML = '휴대폰 번호를 입력해주세요';
        		return;
        	}
        	
        	// 이메일 형식 검사
            if (!isValidEmail(email)) {
                signupMsg.innerHTML = '올바른 이메일 형식이 아닙니다.';
                return;
            }

            // 비밀번호 최소 길이 확인
            if (!isValidPassword(pw)) {
                signupMsg.innerHTML = '비밀번호는 최소 8자리 이상이어야 합니다.';
                return;
            }

            // 핸드폰 번호 자동 하이픈 입력 및 길이 확인
            pNum = formatPhoneNumber(pNum);
            if (!isValidPhoneNumber(pNum)) {
                signupMsg.innerHTML = '올바른 핸드폰 번호를 입력해주세요.';
                return;
            }
        	
        	// 이메일 인증번호 검증 유무를 확인
        	if (document.getElementById('confirmCode').readOnly === false) {
                signupMsg.innerHTML = '인증번호를 확인해주세요.';  // 인증번호를 확인하지 않았을 경우 메시지 출력
                return;
            }
        	
        	// 닉네임 중복체크 확인
        	if(nicknameCheckRes.value != 1){
        		signupMsg.innerHTML = '닉네임 중복체크를 해주세요';
        		signUpNickname.focus();
        		return;
        	}
        	
        	// 비밀번호 일치 확인
        	if(pwCheckRes.value != 1){
        		signupMsg.innerHTML = '비밀번호가 일치하는지 확인 해주세요';
        		pwCheck.focus();
        		return;
        	}
        	
        	obj = {
        			email : email
        			, pw : pw
        			, name : name
        			, nickname : nickname
        			, pnum : pNum
        	}
        	
        	console.log('회원가입 obj : ', obj);
        	
        	// 회원가입 요청
        	fetchPost('/recipe/register'
        				, obj
        				, (map)=>{
					        if(map.result == 'success'){
					        	location.href='/recipe/login?msg='+map.msg;
					        	alert ('회원가입이 완료되었습니다.');
					        } else {
					        	signupMsg.innerHTML = map.msg;
					        }
					  });
        })
		
    	document.getElementById('confirmEmailBtn').addEventListener('click', function() {
    	    var email = document.getElementById('signUpEmail').value;

    	    // 이메일 형식 검증
    	    if (!isValidEmail(email)) {
    	        alert('올바른 이메일 형식이 아닙니다.');
    	        return;
    	    }
    	    
    	    fetch('/recipe/confirmEmail', {
    	        method: 'POST',
    	        headers: {
    	            'Content-Type': 'application/json',
    	        },
    	        body: JSON.stringify({ email: email }),
    	    })
    	    .then(response => response.json())
    	    .then(data => {
    	    	if (data.exists) {
    	            alert('이미 가입되어 있는 이메일입니다.');
    	        } else if (data.success) {
    	            alert('인증번호가 이메일로 발송되었습니다.');
    	        } else {
    	            alert('오류가 발생했습니다.');
    	        }
    	    })
    	    .catch(error => {
    	        console.error('오류 발생:', error);
    	        alert('요청 처리 중 오류가 발생했습니다.');
    	    });
    	});
    	
    	document.getElementById('confirmEmailCheck').addEventListener('click', function() {
    	    var confirmCode = document.getElementById('confirmCode').value;

    	    fetch('/recipe/verifyConfirmationCode', {
    	        method: 'POST',
    	        headers: {
    	            'Content-Type': 'application/json',
    	        },
    	        body: JSON.stringify({ confirmCode: confirmCode }),
    	    })
    	    .then(response => response.json())
    	    .then(data => {
    	        if (data.success) {
    	        	alert('인증되었습니다.');
    	        	document.getElementById('confirmCode').readOnly = true;
    	        	//document.getElementById('confirmationResult').textContent = '인증되었습니다.';
    	        } else {
    	        	alert('인증번호가 일치하지 않습니다.');
    	        	document.getElementById('confirmCode').value = '';
    	            //document.getElementById('confirmationResult').textContent = '인증번호가 일치하지 않습니다.';
    	        }
    	    })
    	    .catch(error => {
    	        console.error('오류 발생:', error);
    	        alert('요청 처리 중 오류가 발생했습니다.');
    	    });
    	});
    	
    	// 이메일 형식 유효성 검사 함수
    	function isValidEmail(email) {
    	    const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    	    return emailPattern.test(email);
    	}

    	// 비밀번호 최소 길이 확인 함수
    	function isValidPassword(password) {
    	    return password.length >= 8;
    	}

    	// 핸드폰 번호 자동 하이픈 입력 함수
    	function formatPhoneNumber(input) {
    	    const cleaned = ('' + input).replace(/\D/g, '');
    	    const match = cleaned.match(/^(\d{3})(\d{4})(\d{4})$/);
    	    if (match) {
    	        return match[1] + '-' + match[2] + '-' + match[3];
    	    }
    	    return input;
    	}

    	// 핸드폰 번호 길이 확인 함수
    	function isValidPhoneNumber(phoneNumber) {
    	    return phoneNumber.replace(/-/g, '').length === 11;
    	}
    	
    	document.getElementById('signUpPNum').addEventListener('input', function (e) {
    	    var input = e.target;
    	    var value = input.value.replace(/\D/g, '');

    	    if (value.length > 3 && value.length <= 7) {
    	        value = value.replace(/(\d{3})(\d{1,4})/, '$1-$2');
    	    } else if (value.length > 7) {
    	        value = value.replace(/(\d{3})(\d{4})(\d{1,4})/, '$1-$2-$3');
    	    }

    	    input.value = value;
    	});
    	
    	function goToLogin() {
            location.href = '/login';
        	}
      })
      
      
      // 비밀번호 텍스트 보기 (MI, 2023/08/16)
      window.addEventListener('load', function(){
	   		eye.addEventListener('click', function(e){
	   			let eyeCk = document.querySelector('#eye').checked;
	   			if (eyeCk){
	   				signUpPw.type= "text";
	   				pwCheck.type= "text";
	   			} else {
	   				signUpPw.type= "password";
	   				pwCheck.type= "password";
	   			}
	   		});
      });
    </script>
    
    <style>
    	.eyeWrap {
    		margin-top: 20px;
    	}
    	.eyeWrap label {
    		display: inline-block;
    	}
    	.eyeWrap input {
    		margin-left: 10px;
    	}
    </style>
</head>
<body class="text-center">
<section id="main">
	<div class="container text-center">
	<main class="form-signin w-100 m-auto">
	
	
  <!-- 회원가입 폼 -->
  <form name='signupForm'>
    <h1 class="h3 mb-3 fw-normal">회원가입</h1>

	<div id="signupMsg"></div>
    <div class="form-floating">
      <input type="email" class="form-control start" id="signUpEmail" >
      <button id="confirmEmailBtn" type="button" style="color: #fff;">인증번호 전송</button>
      <label for="email">Email</label>
    </div>
    <div class="form-floating">
      <input type="text" class="form-control middle" id="confirmCode" >
      <button id='confirmEmailCheck' type="button" style="color: #fff;">인증번호 확인</button>
      <label for="comfirmemail">Confirm Email</label>
    </div>
    <!-- 비밀번호 텍스트 보기 (MI, 2023/08/16) -->
    <div class="eyeWrap">
      <label for="eye"><i class="bi bi-eye-fill" ></i> 비밀번호 보기</label>
	   <input type="checkbox" id="eye">
    </div>
    <div class="form-floating">
      <input type="password" class="form-control middle" id="signUpPw">
      <label for="pw">Password</label>
    </div>
    <div class="form-floating">
      <input type="password" class="form-control middle" id="pwCheck">
      <label for="pwCheck">PasswordCheck</label>
    </div>
    <div class="form-floating">
      <input type="text" class="form-control middle" id="signUpName">
      <label for="name">Name</label>
    </div>
    <div class="form-floating">
      <input type="text" class="form-control middle" id="signUpNickname">
      <label for="nickname">Nickname</label>
      <button id="nicknameCheck" type="button" style="color: #fff;">중복체크</button>
    </div>
    <div class="form-floating">
      <input type="text" class="form-control end" id="signUpPNum">
      <label for="pNum">Phone without ' - '</label>
    </div>
    <button class="w-100 btn btn-lg btn-primary" id='btnSignup' type="submit" >회원가입</button>
    
    <input type="hidden" value="0" id="nicknameCheckRes">
    <input type="hidden" value="0" id="pwCheckRes">
    
    
  </form>

  <br><button id='btnSigninView' onclick="goToLogin()" style="color: #fff;" class="w-100 btn btn-lg btn-primary">로그인 하러가기</button>
</main>
</div>
	</section>
<!-- Footer -->
	<%@ include file="../common/footer.jsp" %>
   	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>