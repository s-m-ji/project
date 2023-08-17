<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 등록</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" />
	
	<!-- css 추가 설정 (MI, 2023/08/17) -->
	<link rel="stylesheet" href="/resources/recipe_css/mimi.css">
	<!-- 파비콘 설정 -->
	<link rel="icon" href="/resources/images/favicon.ico">
	
	
<!-- Bootstrap JavaScript 로드 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

	
   
	// 재료추가버튼 함수
	let counter = 1;

function addMaterial() {
    var container = document.getElementById('dd');
    var newInputsContainer = document.createElement('div');
    newInputsContainer.innerHTML =
        `
        <div>
            <input type="text" name="I_NAME" id="I_NAME" style="display: inline-block; width: 280px;" placeholder="예) 돼지고기">
            <input type="text" name="materialCnt" id="materialCnt" style="display: inline-block; width: 280px;" placeholder="예) 300g">
        </div>
        <br>
        `;
    container.appendChild(newInputsContainer);

    // 재료 추가 버튼을 새로 생성된 폼 뒤에 추가
    container.appendChild(document.querySelector('button'));
    counter++;
}
    
    
	// 순서추가버튼 함수

function addCookStep() {
	let step = 1;
    var cookStep = document.getElementById('cookStep');
    var newCookstep = document.createElement('div');

    newCookstep.innerHTML =
        `
        <p>step ${step + 1}</p>
        <textarea placeholder="예) 떡볶이는 미리 물에 담궈놔 주세요~" name="step_content" style="display: inline-block; width: 450px; resize: none;">${stepvo.step_content}</textarea>
        <input type="file" name="Sphotos" multiple="multiple" style="display: inline-block;" ><br>
        `;

    cookStep.appendChild(newCookstep);

    step++;
}
	// 페이지 다시생성
	function redirectToRecipeWrite() {
	    window.location.href = "http://localhost:8080/recipe1/rec_write"; // 새로운 페이지로 이동할 URL을 입력하세요.
	  }
	
	
	
	// 카테고리
	$(function() {
		type = $('#c1').val();
		select = $('#c2').val();

		chnQnaType(type, select);
	});

	function chnQnaType(type, select) {

		$('#c2').empty();
		$('#c2').append('<option value="" >카테고리2 선택</option>');

		if (type == '1') {
			$('#c2').append("<option value='11'  ${ param.c2 eq '11' ? 'selected' : '' } >국/탕/찌개</option>'");
			$('#c2').append("<option value='12'  ${ param.c2 eq '12' ? 'selected' : '' } >면/국수/파스타</option>'");
			$('#c2').append("<option value='13'  ${ param.c2 eq '13' ? 'selected' : '' } >밥/죽</option>'");
			$('#c2').append("<option value='14'  ${ param.c2 eq '14' ? 'selected' : '' } >빵/떡</option>'");
			$('#c2').append("<option value='15'  ${ param.c2 eq '15' ? 'selected' : '' } >반찬</option>'");
			$('#c2').append("<option value='16'  ${ param.c2 eq '16' ? 'selected' : '' } >샐러드</option>'");
			$('#c2').append("<option value='17'  ${ param.c2 eq '17' ? 'selected' : '' } >소스</option>'");
			$('#c2').append("<option value='18'  ${ param.c2 eq '18' ? 'selected' : '' } >차/음료/술</option>'");
		} else if (type == '2') {
			$('#c2').append("<option value='21'  ${ param.c2 eq '21' ? 'selected' : '' } >육류</option>'");
			$('#c2').append("<option value='22'  ${ param.c2 eq '22' ? 'selected' : '' } >해물류</option>'");
			$('#c2').append("<option value='23'  ${ param.c2 eq '23' ? 'selected' : '' } >과일류</option>'");
			$('#c2').append("<option value='24'  ${ param.c2 eq '24' ? 'selected' : '' } >달걀/유제품</option>'");
			$('#c2').append("<option value='25'  ${ param.c2 eq '25' ? 'selected' : '' } >채소류</option>'");
			$('#c2').append("<option value='26'  ${ param.c2 eq '26' ? 'selected' : '' } >견과류</option>'");
			$('#c2').append("<option value='27'  ${ param.c2 eq '27' ? 'selected' : '' } >쌀/밀가루</option>'");
		} else if (type == '3') {
			$('#c2').append("<option value='31'  ${ param.c2 eq '31' ? 'selected' : '' } >간식</option>'");
			$('#c2').append("<option value='32'  ${ param.c2 eq '32' ? 'selected' : '' } >안주</option>'");
			$('#c2').append("<option value='33'  ${ param.c2 eq '33' ? 'selected' : '' } >파티</option>'");
			$('#c2').append("<option value='34'  ${ param.c2 eq '34' ? 'selected' : '' } >캠핑</option>'");
			$('#c2').append("<option value='35'  ${ param.c2 eq '35' ? 'selected' : '' } >도시락</option>'");
			$('#c2').append("<option value='36'  ${ param.c2 eq '36' ? 'selected' : '' } >이유식</option>'");
			$('#c2').append("<option value='37'  ${ param.c2 eq '37' ? 'selected' : '' } >초스피드</option>'");
		} else if (type == '4') {
			$('#c2').append("<option value='41'  ${ param.c2 eq '41' ? 'selected' : '' } >볶음</option>'");
			$('#c2').append("<option value='42'  ${ param.c2 eq '42' ? 'selected' : '' } >조림</option>'");
			$('#c2').append("<option value='43'  ${ param.c2 eq '43' ? 'selected' : '' } >비빔</option>'");
			$('#c2').append("<option value='44'  ${ param.c2 eq '44' ? 'selected' : '' } >절임</option>'");
			$('#c2').append("<option value='45'  ${ param.c2 eq '45' ? 'selected' : '' } >튀김</option>'");
			$('#c2').append("<option value='46'  ${ param.c2 eq '46' ? 'selected' : '' } >삶기</option>'");
			$('#c2').append("<option value='47'  ${ param.c2 eq '47' ? 'selected' : '' } >굽기</option>'");
			$('#c2').append("<option value='48'  ${ param.c2 eq '48' ? 'selected' : '' } >끓이기</option>'");
		}
		document.getElementById("c2").style.display = "";

		if ($.trim(select) != "") {
			$('#c1').val(type);
			$('#c2').val(select);
		}
		
	}
    
	
 
   
	
		
	
  </script>
  
  <!-- css 추가 설정 (MI, 2023/08/17) -->
  <style>
  .form-control {
  	padding: 30px;
  }
  
  .form-control label {
	  font-weight: 800;
	font-size: 1.75rem;
	position: relative;
	display: inline-block;
	}
  
  .form-control label:after {
  	position: absolute;
	bottom: 0;
	display: block;
	content: "";
	width: 100%;
	height: 10px;
	background: #f7863b50;
  }
  </style>
  
</head>
<body>
	<!-- Header -->
	<%@ include file="../common/header.jsp"%>

<!-- Main -->
	<section id="main">
	<div class="container">
		<div class="container gtco-section">
		<!-- 타이틀 제목 -->
		<!-- <div
			style="text-align: center; font-size: 30px; font-weight: bold; margin-bottom: 20px; color: pink;">
			♡♡♡ 레시피 게시판 ♡♡♡
		</div> -->



		<form class="form-control" method="post" action="/recipe/postWrite" enctype="multipart/form-data"> 	
  		
  		 <input type="hidden" name="mno" value="${mno}">
  		<input type="hidden" name="nickName" value="${nickName}">
		<!-- 제목 입력란  -->
			<div class="rec_title">
				<label>레시피 제목 </label> 
				<input type="text" name="title" placeholder="예) 학교앞 분식집 떡볶이 만들기" value="${board.title}">
			</div>
			
			<br><br>

		<!-- 요리소개  -->
			<div class="rec_intro">
				<label >요리 소개</label>
				<textarea
					placeholder="이 레시피의 탄생배경을 적어주세요. 예)어릴적 학교앞 분식집에서 먹던 떡볶이 맛이 그리우셨다면 한번 만들어보세요~"
					name="intro" style="resize: none;">${board.intro }</textarea>
			</div>
			
			<br><br>
			
			
			
			
			
		<!-- 대표사진 파일첨부  -->
			<div>
			    <label style="display: inline;">대표사진설정하기</label>
			    <i class="bi bi-image" style="display: inline; color: pink;"></i>
			    <input type="file" name="photos" class="" multiple="multiple">
			</div>
			
		
			
			<br><br>
			
		<!-- 동영상 링크  -->
			<div>
				<label  style="display: inline;">동영상</label>
				<i class="bi bi-camera-reels" style="display: inline; color: pink;"></i>
			</div>
			<textarea
				placeholder="동영상이 있으면 주소를 입력하세요. 예)http://youtu.be/lA0Bxo3IZmM" name="videolink"
				style="height: 50px; width: 100%; resize: none;">${board.videolink }</textarea>
				
				
				
			
			<%-- //	<div class="rec_title">
				//	<label>카테고리 </label> 
				/	<input type="text" name="title" placeholder="카테고리1" value="${board.c_no1}">
				
					<input type="text" name="title" placeholder="카테고리2" value="${board.c_no2}">
				</div> --%>
				
				
				
				
				
				
				
				
				
				
				
			<br><br>
			
		
		<div>
			<label style="display: inline;">카테고리</label>
			<i class="bi bi-tags" style="display: inline; color: pink;"></i><br>
		</div>
		<div class="text-center">
			<div class="d-flex justify-content-between">
				<div class="p-2 flex-fill" >
					<select name="c_no1" id="c1" class=""
						onChange="chnQnaType(this.value)">
						<option value="">카테고리1 선택</option>
						<option value="1" ${ param.c1 eq '1' ? "selected" : "" }>종류별</option>
						<option value="2" ${ param.c1 eq '2' ? "selected" : "" }>재료별</option>
						<option value="3" ${ param.c1 eq '3' ? "selected" : "" }>상황별</option>
						<option value="4" ${ param.c1 eq '4' ? "selected" : "" }>방법별</option>
					</select>
				</div>
				<div class="p-2 flex-fill">
					<select id="c2" name="c_no2" class=""></select>
				</div>
				
			</div>
		</div>
		
		

			<br><br>
			
			<!-- 재료 ( 재료명 / 계량 ) -->
			

				<div id="dd">
				    <label for="exampleFormControlInput1" style="display: inline">재료 (재료이름과 정확한계량을 입력해주세요!!)</label>
				    <i class="bi bi-egg-fried" style="display: inline; color:pink;"></i>
				    <div>
				        <input type="text" name="I_NAME"  id="I_NAME1" style="display: inline-block; width: 48.5%;" 
				        placeholder="예) 돼지고기" value="${matvo1.I_NAME}">
				        <input type="text" name="materialCnt" id="materialCnt1" style="display: inline-block; width:  48.5%;" 
				        placeholder="예) 300g" value="${matvo1.materialCnt}">
				    </div>
				    <br>
				    <div>
				        <input type="text" name="I_NAME"  id="I_NAME2" style="display: inline-block; width: 48.5%;" 
				        placeholder="예) 양배추" value="${matvo2.I_NAME}">
				        <input type="text" name="materialCnt" id="materialCnt2" style="display: inline-block; width: 48.5%;" 
				        placeholder="예) 1/2개" value="${matvo2.materialCnt}">
				    </div>
				    <br>
				    <div>
				        <input type="text" name="I_NAME"  id="I_NAME3" style="display: inline-block; width: 48.5%;" 
				        placeholder="예) 참기름" value="${matvo3.I_NAME}">
				        <input type="text" name="materialCnt" id="materialCnt3" style="display: inline-block; width: 48.5%;" 
				        placeholder="예) 1T" value="${matvo3.materialCnt}">
				    </div>
				    <br>
				    <!-- 재료추가 버튼을 누르면 박스2개 생성! -->
				    <button type="button" onclick="addMaterial()">
				        <span style="color: #fff;">재료추가</span>
				    </button>
				</div>


			<!-- 요리순서 -->
			
    	<!-- 요리순서 -->
    	<br>
			<label>요리순서</label>
			<div id="cookStep">
			    <p>step 1</p>
			    <textarea placeholder="예) 떡볶이는 미리 물에 담궈놔 주세요~" name="step_content" style="display: inline-block; width: 100%; resize: none;">${stepvo.step_content}</textarea>
			    <input type="file" name="Sphotos" multiple="multiple" style="display: inline-block; margin-bottom: 50px;"><br>
			</div>
			
			<!-- 순서추가 버튼 -->
			<div>
			    <button type="button" onclick="addCookStep()" style="color: #fff;">순서추가</button>
			</div>
				
				<br><br>
			
			
			<!--  요리팁  -->
			<div>
				<label>요리팁</label> <input type="text" 	name="cookTip"
					placeholder="떡이 얼려져있다면 미리 해동시켜주세요!!" value="${board.cookTip}">
			</div>
			
			
			<br><br>
			
			
			<div>
				<label>요리 완성사진</label>
				<input type="file" name="Fphotos" id="photoInput" class="" 
					multiple="multiple" >
			</div>
			
			
			
			

			
			
			<!-- 등록, 미리보기 , 취소 버튼 -->			
			<div style="text-align: center; margin: 50px 0;">
				<button type="submit" class="btn btn-success">등록</button>
				<button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#previewModal">미리보기</button>
				<button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#cancelModal">취소</button>
			</div>
			
			<!-- 미리보기용 모달 창 -->
			<div class="modal fade" id="previewModal" tabindex="-1" aria-labelledby="previewModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-xl">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="previewModalLabel">레시피 미리보기</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
						    <!-- 미리보기 내용 -->
						    <iframe src="http://localhost:8080/recipe/view?b_no=${board.b_no}" width="100%" height="600"></iframe>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 취소 확인 모달 창 -->
			<div class="modal fade" id="cancelModal" tabindex="-1" aria-labelledby="cancelModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="cancelModalLabel">정말 취소하시겠습니까?</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			        <button type="button" class="btn btn-danger" onclick="redirectToRecipeWrite()">확인</button>
			      </div>
			    </div>
			  </div>
			</div>
			



		</form>
</div>
	</div>


	</section>

	<!-- Footer -->
	<%@ include file="../common/footer.jsp"%>

	
</body>
</html>