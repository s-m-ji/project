<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script type="text/javascript">
	// 메세지 처리
	/*
		부트스트랩을 이용한 모달창 띄우기 
		
		1. css, js 파일 추가 하기
		2. 모달요소 복사 
			타이틀및 메세지 수정
		3. 모달창 열기
			자바스크립트를 이용해서 모달객체 생성후 show()메서드 호출
		4. 모달창 닫기(닫기버튼 클릭, 배경화면 클릭)
			모달창이 닫히면 자바스크립트를 이용해서 뒤로가기 실행
			-> 모달창이 닫히면서 발생하는 이벤트(hidden.bs.modal)에 뒤로가기 추가
	*/
//	let msg = '${msg}';
	let msg = '${message}';
	window.onload = function(){
		if(msg != ''){
			document.querySelector(".modal-body").innerHTML = msg;
			
			let myModal = new bootstrap.Modal(document.getElementById('myModal'), {
				  keyboard: false
			});

			myModal.show();
		}
		
		const myModalEl = document.getElementById('myModal')
		myModalEl.addEventListener('hidden.bs.modal', event => {
		  history.go(-1);
		})
	}
	</script>
	<!-- 부트스트랩을 사용하기 위해서 css, js를 추가 합니다. -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>

<!-- Modal -->
<div id="myModal" class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">📢Notice</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
       <!--  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button> -->
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

</body>
</html>











