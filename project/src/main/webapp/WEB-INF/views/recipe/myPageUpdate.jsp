<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<!-- ============ recipe 플젝 js 모음 (MI, 2023/07/26) ============ -->	
	<!-- 공통 적용 -->
    <script src='/resources/recipe_js/common.js'></script> 
    <!-- 지상미 js -->
    <script src='/resources/recipe_js/mimi.js'></script>
	<!-- swal -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


<script>
	function requestAction(url){
		editForm.action=url;
		editForm.submit();
	}
</script>
<script type="text/javascript">
	window.addEventListener('load', function(){
	var backAdmin = document.querySelector('#backAdmin');
	backAdmin.addEventListener('click', function(){
		editForm.action = '/recipe/myPage2';
		editForm.method = "get"; 
		editForm.submit();
	});
	
	getFileList(); 
	
	
	// 비밀번호 11자만 보이도록 하기 
	const pwRealInput = document.querySelector("#pwReal");
	const originalPw = pwRealInput.value;
	pwRealInput.value = originalPw.substring(0,11);
	
	var nickname = document.querySelector('#nickname');
	console.log(nickname);
	
	nickname.addEventListener('blur', function(){
		
		// 파라메터 세팅
		let obj={ nickname : nickname.value };
		console.log("닉네임 체크", obj);
		
		// 닉네임 체크
		fetchPost('/recipe/nicknameCheck', obj, (map)=>{
	    	  if(map.result == 'success'){
	    		  nicknameCheckRes.value='1'; // 닉네임 사용 가능
	    		  pnum.focus();
	    	  } else {
	    		  nicknameCheckRes.value='0'; // 닉네임 사용 불가능
	    		  nickname.focus();
	    		  nickname.value='';
	    	  }
	   		  signupMsg.innerHTML = map.msg; // 메세지 출력
	    });
		
	})
	
	var updateBtn = document.querySelector('#updateBtn');
	updateBtn.addEventListener('click', function(){
		//e.preventDefault();
		
		let nickname = nickname.value;
		
		if(!nickname){
    		signupMsg.innerHTML = '닉네임을 입력해주세요';
    		return;
    	}
		
		// 닉네임 중복체크 확인
    	if(nicknameCheckRes.value != 1){
    		signupMsg.innerHTML = '닉네임 중복체크를 해주세요';
    		signUpNickname.focus();
    		return;
    	}
	})
	
})

function getFileList(){
		let mno = document.querySelector("#mno").value;
		console.log(mno);
		
		fetch('/recipe/fileList/'+ mno)
		.then(response => response.json())
		.then(map => viewFileList(map));
	}
		// ★파일 보여주기 함수
		function viewFileList(map){
			console.log("map : ", map);
			let content = '';
			
			if(map.FileList.length > 0){
				content += 
					'<div class="mb-3" id="divFileupload"></div>'
					+ '<div class="mb-3"> '
					+  ' <label for="attachFile" class="form-label">첨부파일 목록</label> '
					+  '	<div class = "form-control" id="attachFile" style="width: 100%;height: 100%;background-color: #e6e6e6 !important;border: 0px;box-shadow: inset 2px 2px 0px 0px rgba(0, 0, 0, 0.1);"> '
					
			map.FileList.forEach(function(item, index){
				// URL 인코딩 
				let savePath = encodeURIComponent(item.savePath);
				
				console.log("item.savePath" , item.savePath);
				content += 
				 	 '<img src="/recipe/displayAdmin?filename='+savePath+'"alt="회원 사진"'+item.mno+'" style="width: 100px;">'
				 	 + '<i class="fa-solid fa-square-xmark" data-mno="'+item.mno+'"data-uuid="'+item.uuid+'" onclick="attachFileDelete(this)"></i>' 
					+ '<br>' ;
				 
				})
				content +=
		 			 '	</div> '
		 			+ '</div>  ';
			}else{
				content ='';
			}
			divFileupload.innerHTML = content;
		}	
	
		function attachFileDelete(e){
			(e.dataset.aaa)?'true':'false';
			
			let mno = e.dataset.mno;
			let uuid = e.dataset.uuid;
			
			console.log(mno);
			console.log(uuid);
			
			fetch('/recipe/fileDelete/'+ mno + '/' + uuid)
			.then(response => response.json())
			.then(map => delRes(map));
		}
		
		function delRes(map){
			if(map.result == 'success'){
				/* alert('삭제'); */
				let divFileUpload = document.querySelector('#divFileupload');
				divFileUpload.style.display='none';
				getFileList();
			}else{
				alert('삭제 실패');
			}
		}
		 
		// 탈퇴 신청 관련 
		function myPageDel(){
			let mno = document.querySelector("#mno").value;
			
	 		swal({
				title:'정말로 탈퇴하시겠습니까?',
				text : "탈퇴 신청 후 복구시킬 수 없습니다.",
				icon : 'warning',
				buttons: true,
				dangerMode: true,
			}).then((willDelete) =>{
				if(willDelete){
					let obj = {
							mno:mno
					};
					fetchPost('myPage/DelYn', obj, myPageDelRes);
					console.log(obj);
				} else{
					swal("신청 실패", "탈퇴 신청이 처리되지 않았습니다.", "error");
				}
			}); 
		}		
/* 	     Swal.fire({
	            title: "신청 완료!",
	            text: "탈퇴 신청이 정상적으로 처리되었습니다.",
	            icon: "success",
	            confirmButtonText: "확인"
	        }).then(() => {
	            // 이전 페이지로 이동
	            window.history.back();
	        }); */
		function myPageDelRes(map){
			if(map.result == 'success'){
				swal("신청 완료!", "탈퇴 신청이 정상적으로 처리되었습니다", "success").then(okay =>{
					if(okay){
						/* location.href ="myPage2"; */
						 window.history.back();
					}
				});
				
			}else{
				swal("탈퇴 신청 중 오류가 발생하였습니다. 관리자에게 문의해주세요.");
			}
		}
		// post방식 요청
		function fetchPost(url, obj, callback){
			try{
				// url 요청
				fetch(url
						, {
							method : 'post'
							, headers : {'Content-Type' : 'application/json'}
							, body : JSON.stringify(obj)
						})
					// 요청결과 json문자열을 javascript 객체로 반환
					.then(response => response.json())
					// 콜백함수 실행
					.then(map => callback(map));			
			}catch(e){
				console.log('fetchPost', e);
			}
		}
		
		
		 
</script>

  <style>
    body {
      min-height: 100vh;

      padding-top: 100px;

      background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);  /* 원본 */
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
		justify-content: center;
	}
	.inputTitle{
		text-align: center;
		font-size: 1.5em;
	}
	.backDiv{
	padding-left: 10px;
	padding-right: 30px;z
	}
	.myUpdate1{
	display: flex;
    justify-content: flex-end;
	}
	.myUpdate2{
	  padding: 5px;
    border-radius: 5px;
	}
	.myUpdate3{
	    text-decoration: none;
    color: black;
	}
	.myUpdate2:hover {
	background-color: white;
	}
  </style>

</head>

<body>
  <div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3 inputTitle">내 정보 수정🧑🏻‍🍳</h4>
        
       <c:set value="${myList}" var="member"></c:set>
        <div class="myUpdate1">
        <div class="myUpdate2">
		    <input type="hidden" id="mno" name="mno" value="${member.mno}">
			<input type="button" onclick='myPageDel()' value="탈퇴신청" id="myPageDelBtn"
				style="background-color: ghostwhite; color: black;font-weight: 400;">
       </div> 
        </div>
       <input type="text" class="form-control" id="mno" name ="mno" placeholder="회원번호" value="${member.mno }" hidden>
        <form action="/recipe/myPageUpdateAction" method="post" accept-charset="UTF-8"  name="editForm" enctype="multipart/form-data" novalidate>
	    <!--  파라메터 🌈 --> 
   		<input type="text" name="mno" value="${member.mno}" id = "mno" hidden>
   		
            <div class="mb-4">
              </div>
              <div class=" mb-3">
                <label for="email">이메일</label>
                <input type="email" class="form-control" id="email" name ="email" placeholder="usermail@naver.com" value="${member.email }" required readonly="readonly">
                <div class="invalid-feedback">
                  이메일을 등록해주세요.
                </div>
              </div>

         <div class=" mb-3">
                <label for="pwReal"> 현재 패스워드</label>
                <input type="password" class="form-control"  id="pwReal" name ="pwReal" value="${member.pw}" required readonly="readonly">
                <div class="invalid-feedback">
                  패스워드를 등록해주세요.
                </div>
            </div>

              <div class=" mb-3">
                <label for="pw"> 새로운 패스워드</label>
                <input type="text" class="form-control"  id="pw" name ="pw" value="${pw}" required>
                <div class="invalid-feedback">
                  패스워드를 등록해주세요.
                </div>
            </div>
            
          <div class="row">
            <div class="col-md-6 mb-3" style="padding-right: 36px; padding-left: 21px;">
              <label for="name">이름</label>
              <input type="text" class="form-control" id="name" name='name' placeholder="username" value="${member.name}" required >
              <div class="invalid-feedback">
                이름을 등록해주세요.
              </div>
            </div>
            <div class="col-md-6 mb-3" style="padding-right: 12px;">
              <label for="nickname">닉네임 </label>
              <input type="text" class="form-control" id="nickname"  name ="nickname" placeholder="ex) 만종원" value="${member.nickname}" required>
              	<!--  닉네임 중복 체크 -->
              	<div id="signupMsg" style="=padding: 10px;color: orange;"></div>
              <div class="invalid-feedback">
                닉네임을 등록해주세요.
              </div>
            </div>
          </div>

          <div class="mb-3">
            <label for="pnum">전화번호</label>
            <input type="text" class="form-control" id="pnum" name ="pnum" value="${member.pnum }" required>
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

          <!--  파일 목록을 뿌려주는 공간 -->
 	 <div class="mb-3" id="divFileupload">
	 </div>
 
          <hr class="mb-4">

                <div class="row">
                <div class="col-md-4 mb-1 backDiv" >
              <a  class="btn btn-primary btn-lg btn-block" href="#" id ="backAdmin" role="button">뒤로가기</a>
            </div>
                
            <div class="col-md-4 mb-1">
              <button class="btn btn-primary btn-lg btn-block" id="updateBtn" type="submit">수정</button>
            </div>
            
            
          </div>
          
           <input type="hidden" value="0" id="nicknameCheckRes">
           
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
