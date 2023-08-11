<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- 브라우저 탭 제목 -->
    <title>레시피 상세</title>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link href="/resources/css/view.css" rel="stylesheet">
<script src="/resources/js/view.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@100;500&family=Nanum+Gothic&family=Noto+Sans+KR&family=Orbit&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@500&family=Nanum+Gothic&family=Orbit&display=swap" rel="stylesheet">
<style>
	
		#MemberInfoDiv{
		display: flex;
	}
	
	.swal-icon--success__line {
	    height: 5px;
	    background-color: #a5dc86;
	    display: block;
	    border-radius: 2px;
	    position: absolute;
	    z-index: 2;
	}
	
	.recipeFinishIm button{
		  box-shadow: none;
	}
	
	.recipeFinishIm {
		
		display: flex;
	    justify-content: center;
	    border-top: 5px solid #ddd;
	    padding: 40px;
	
	}
	
	#recentlyContainer{
		
		border-top: 5px solid #ddd;
   		padding-top: 30px;
   		
	}
	
	#generalReplyWriteDiv{
		width: 100%;
	}
	
	
	

</style>

 <!-- Header -->
	<%@ include file="../common/header.jsp" %>

<script type="text/javascript">

	window.addEventListener('load', function(){
  			
		const moreButton = document.getElementById('moreButton');
		  const reduceButton = document.getElementById('reduceBtn');
		  const cookingReviewSection = document.getElementById('cookingReviewSection'); // 요리 리뷰 부분의 ID를 추가합니다.

		  moreButton.addEventListener('click', function() {
		    generalCommentDiv.style.display = 'block'; // 댓글 섹션을 보이게 합니다.
		    moreButton.style.display = 'none'; // "댓글 전체보기" 버튼을 숨깁니다.
		    reduceButton.style.display = 'block'; // "댓글 줄이기" 버튼을 보이게 합니다.
		  });

		  reduceButton.addEventListener('click', function() {
		    moreButton.style.display = 'block'; // "댓글 전체보기" 버튼을 보이게 합니다.
		    reduceButton.style.display = 'none'; // "댓글 줄이기" 버튼을 숨깁니다.
			
			  getRecipeReply();

			  cookingReviewSection.scrollIntoView({ behavior: 'auto' });
		  });
		  
		  // 일반댓글 ==============================================
		  
		  const moreGRButton = document.getElementById('moreGRButton');
		  const reduceGRButton = document.getElementById('reduceGRBtn');
		  const generalReplyContainer = document.getElementById('generalReplyContainer'); // 요리 리뷰 부분의 ID를 추가합니다.

		  moreGRButton.addEventListener('click', function() {
			  generalReplyDiv.style.display = 'block'; // 댓글 섹션을 보이게 합니다.
		    moreGRButton.style.display = 'none'; // "댓글 전체보기" 버튼을 숨깁니다.
		    reduceGRButton.style.display = 'block'; // "댓글 줄이기" 버튼을 보이게 합니다.
		  });

		  reduceGRButton.addEventListener('click', function() {
			  moreGRButton.style.display = 'block'; // "댓글 전체보기" 버튼을 보이게 합니다.
			  reduceGRButton.style.display = 'none'; // "댓글 줄이기" 버튼을 숨깁니다.
			
			  getGeneralReply();

			  generalReplyContainer.scrollIntoView({ behavior: 'auto' });
		  });
		  
		
		//=========================================================================================
			
			// 상단 사진 이미지 출력
			getFileList();
			
			// 재료 정보 출력
			getMaterial();
			
			// 요리 순서 출력
			getRecipeStep();
			
			// 댓글 출력 
			getRecipeReply();
			
			// 별점
			initializeStarRatings();
			
			// 일반 댓글 출력
			getGeneralReply();
		 
			// 좋아요 버튼 클릭 시 실행되는 함수
			likeBtn.addEventListener('click', function(){
				
				LikeRecipe();

			});
			
			
			// 최근 본 페이지를 페이지 하단에 출력 할 수 있는 함수 호출
			recentPage();
			

			// 요리후기 중복검사
			ReviewDuplicate();
			
			
			// 작성자 이미지 출력 
			getMemberImg();
				
			
			//파일업로드
			replyPhotoupload_Test.addEventListener('click', function(){
				
				event.preventDefault();
				
				const writerDiv = document.querySelector('#writerDiv').style.display = "none";
				
				let b_no = document.querySelector('#b_no').value;
				
				document.querySelector('#star').value = document.querySelector('.starDiv').dataset.max;
				
				let formData = new FormData(replyPhotoForm_Test);
				
				//console.log("b_no : ", b_no);
				
				//console.log("formData : ", formData);
				
				//console.log("writer : ", writer);
				
				//console.log("reply : ", reply);
				
				document.query
				
				for(var pair of formData.entries()){
					
					if(typeof(pair[1]) == 'object') {
						let fileName = pair[1].name;
						let fileSize = pair[1].fileSize;
						
						//console.log('fileName', fileName);
						//console.log('fileSize', fileSize);
						
					}
					
				}
				
				fetch('/file/photoReview_Test'
						, {
							method : 'post'
							, body : formData
				})
					.then(response => response.json())
					.then(map => fileuploadRes_Test(map));
				
			}); // 
			
			
			// 별점 전송
			  $(".starDiv").score({
			    starColor: "gold",
			    editable: true,
			    integerOnly: true,
			    send: {
			      sendable: true,
			      name: "star",
			    },
			    display: {
			      showNumber: true,
			    },
			  });

		
			
	        });
			
	
		// 일반 댓글 작성 함수
		
		function grWrite(){
			
			event.preventDefault();
			
			let b_no = document.querySelector('#b_no').value;
			let content = document.querySelector('#content').value;
			let replyer = document.querySelector('#replyer').value;
			
			let obj = {b_no : b_no
					, content : content
					, replyer : replyer}
			
			fetchPost('/reply/grWrite', obj, grRes);
			
		}
	
		
		function grRes(map){
			
			getGeneralReply();
			
			if(map.result == 'success'){
				
				
				swal({
		                title: "댓글 저장 완료",
		                text: "",
		                icon: "success",
		                button: "완료",
		                });
				
				//
				
				alertCustomizing();
				
			}else{
				
				 swal ( "앗 ! " ,  "댓글입력중 오류 발생 !" ,  "error" );
				 alertCustomizing();
			} 
			
		}
	
		
		function fileuploadRes_Test(map){
			// 댓글 출력 
			getRecipeReply();
			//console.log(map.result);
			if(map.result == 'success'){
				 swal({
		                title: "요리 후기 작성완료!",
		                text: "",
		                icon: "success",
		                button: "완료",
		                });
				 
				 alertCustomizing();	
				 
			}else{
				 swal ( "앗 !" ,  "후기 작성중 오류 발생 !" ,  "error" );
				 alertCustomizing()
			}
	}
		
		
		// 댓글 작성 함수
	   function replyWrite(){
		
		   event.preventDefault(); // Prevent the default form submission behavior (page refresh)
		   
			let bno = document.querySelector('#b_no').value;
			let reply = document.querySelector('#replyContent').value;
			let writer = document.querySelector('#replyer').value;
			
			let obj = {bno : bno
					, reply : reply
					, writer : writer}
			
			//console.log("bno", bno);
			//console.log("reply", reply);
			//console.log("writer", writer);
			
			// url : /reply/insert : 요청경로
			// obj : json 형식으로 전달할 데이터
			// callback : 응답을 받아 실행할 함수 / 콜백함수
			fetchPost('/reply/write', obj, replyRes);
			
			
			// =========================================================== 파일 업로드 합치기
			
		}
		
			
		function fileuploadRes(map){
	   
	   			//console.log(map.result);
	   			
	   
   		}
		
		
		function fetchPost(url, obj, callback){
			
		try {
			
			fetch(url
					,{method : 'post'
					, headers : {'Content-Type' : 'application/json'}
					, body : JSON.stringify(obj)
			})
			// 요청결과 json 문자열을 javascript 객체로 반환
			.then(response => response.json())
			// 콜백함수 실행
			.then(map => callback(map));
			
		} catch (e) {
			//console.log(e);
		}	
	}
   
	   
	   function replyRes(map){
		      // 성공 : 리스트 조회 및 출력
		      // 실패 : 메세지 출력
		      //console.log('map', map);
		      
		      if (map.result == "success"){
		    	  
		    	  ReviewDuplicate();
		    	  getRecipeReply();
		    	  
		         
		         // 댓글 등록, 수정 후 화면 조회 시 입력창 초기화
		         document.querySelector('#reply').value = "";
		         document.querySelector('#replyer').value = "";
		      } else {
		         alert("다른내용");
		      }
		   }
   
   
   // 레시피 저장 함수
   function LikeRecipe(){
	   
	   	let m_no = document.querySelector('#m_no').value; // 세션 정보에서 m_no 를 받아온다면 저장
		let b_no = document.querySelector('#b_no').value; // 화면에서 게시글의  b_no 를 읽어와서 저장
	   
		let obj = {m_no : m_no
				, b_no : b_no }
		
		//console.log("m_no :" , m_no); // 확인 완료
		//console.log("b_no :" , b_no);
		
		
		fetchPost('/recipe/likeRecipe', obj, LikeRecipeRes);
   }
   
	// 레시피 저장을 알려주는 함수
	   function LikeRecipeRes(map){
	   	
			
		   //swal ( "앗 ! " ,  "이미 저장된 레시피 입니다." ,  "error" );
		  	
		   swal({
		                title: "레시피 찜하기 성공 !",
		                text: "",
		                icon: "success",
		                button: "완료",
		                });
		   
		   alertCustomizing();
	   		
	   }
			
		 
	function getGeneralReply(){
		
		let b_no = document.querySelector('#b_no').value;
   		
		
   		// fetch 사용
   		// 정보를 가져와서 함수에 파라메터로 넣는다.
   		fetch('/reply/generalReply/' + b_no)
   			.then(response => response.json())
   			.then(map => viewGeneralReply(map));
		
	}
	
	
	function viewGeneralReply(map){
		
		//console.log('map.generalReply', map.generalReply)
	
		let content = '';
		
		 let showAll = false;

		  // Function to generate the HTML content for a single item
		  function generateHtml(item) {
		    
			let gr_no = item.gr_no; // comment number
		    let regdate = item.regdate; // Date Created
		    let replyer = item.replyer; // detail
		    let content = item.content; // Writer

		    // Let's take it to the input hidden and make it available when
			// clicking on it.
		    // We need to get the picture associated with the comment later.
		    return (
		    		
	    		'<div class="generalHead margin-B30" style="border-bottom: 1px solid; border-color: #a52a2a52">' 
	            + '<b style="font-size:17px font-size: 14px; margin-bottom: 5px; ">'+replyer+'</b> | <span style="font-size:14px; color: #0000007a;">'+regdate+'</span>'
	            
	            + '<div style="font-size:14px; margin-bottom:5px; margin-top: 10px; margin-left: 5px;" class="generalContent">'+content+'</div>'
	          	+'</div>'
		      
		    );
		    
		  }

		  // Function to display all items in map.replyList
		  function displayGReply() {
		    showAll = true;
		    content = '';
		    map.generalReply.forEach(function (item) {
		      content += generateHtml(item);
		    });
		    generalReplyDiv.innerHTML = content;
		    
		  }

		 
		  
		  // If there is a value specified when putting it to the map in
			// the controller...
		  if (map.generalReply.length > 0) {
		    // Show the first five items initially
		    for (let index = 0; index < Math.min(5, map.generalReply.length); index++) {
		      const item = map.generalReply[index];
		      content += generateHtml(item);
		    }
		    generalReplyDiv.innerHTML = content;
	

		    // Add event listener to the '더보기' button
		    const moreGRButton = document.getElementById('moreGRButton');
		    moreGRButton.addEventListener('click', displayGReply);
		  } else {
		    content = '댓글이 없습니다.. 첫번째 후기를 남길 기회에요!';
		    generalReplyDiv.innerHTML = content;
		  }
		

		}
	
	
	
	//-----------------------------------------------------------------------------------------------
	
	// 이미지 보여주기 
	
	function setThumbnail(event) {
        var reader = new FileReader();

        reader.onload = function(event) {
          var img = document.createElement("img");
          img.setAttribute("src", event.target.result);

          // Remove any previously added images
          var container = document.querySelector("div#image_container");
          while (container.firstChild) {
            container.removeChild(container.firstChild);
          }

          container.appendChild(img);
        };

        reader.readAsDataURL(event.target.files[0]);
      }
	
	
	function ReviewDuplicate(){
		
		//console.log('ReviewDuplicate() 실행 !!!!!!!!!!!!!!!!!!!!!!!!!');
		let writer = document.querySelector('#writer').value;
		let b_no = document.querySelector('#b_no').value;
		
		//console.log("작성자이름 : ", writer)
		
		let writerString = String(writer);
		
		fetch('/reply/photoReply/' + b_no + '/' + writerString)
			.then(response => response.json())
			.then(map => ReviewDuplicateRes(map));

		
	}
	
	function ReviewDuplicateRes(map){
		
		const writerDiv = document.querySelector('#writerDiv');
		
		//console.log("ReviewDuplicateRes(map) 실행 ===========================================================")
		
		console.log('map.member : ', map.member);
		
		// 수정 삭제 처리까지 
		let b_no = document.querySelector('#b_no').value;
		let nickname = document.querySelector('#loginNickname').value;
		
		fetchGet('/reply/edelete/' + b_no + "/" + nickname, edeleteRes);
		
		console.log("===============================")
		console.log('b_no : ', b_no);
		console.log('nickName : ', nickname);
		
		if(map.result == "duplicate"){
			
			writerDiv.style.display = "none";
			
		}else{
			
			return;
		}
		
	}
	
	
	// 수정 삭제 버튼 처리
	function edeleteRes(map){
		
		console.log("edeleteRes ============================ ", map);
		
		document.querySelector('#replyDelete'+map.r_no+'').style.display = "block";
		document.querySelector('#replyEdit'+map.r_no+'').style.display = "block";
		
		
	}
	
	
	// 멤버 이미지 겟또 ~
	function getMemberImg(){
		
			let m_no = document.querySelector('#m_no').value;
			
			fetchGet('/file/getMemberImg/'+ m_no, getMemberImgRes);
	}
	
	function getMemberImgRes(map){
		
		const MemberImg = document.querySelector('#MemberImg');
		
		//console.log("나 여기있어요 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ : ", map.result);
		
		
		if(map.result = "success"){
			
			let savePath = encodeURIComponent(map.memberImg.savePath);
			//console.log("멤버이미지 출력 대작전 : ", savePath);
			
			let imgTag = '<img style="width: 100px; height: 100px; border-radius: 50%;" src="/display?fileName='+ savePath + '">'
		
			MemberImg.innerHTML = imgTag;
			
		}else{
			
			//console.log("멤버이미지 출력 대작전");	
		}
			
		
	}

	

   </script>
<body>

	<script src="https://kit.fontawesome.com/4863a16a12.js"
		crossorigin="anonymous"></script>

	<!-- <div class="viewContainer bor"> -->
	
	
	
	<c:set var="nickname" value="${member.nickname}"></c:set>
	
	<input id="loginNickname" type="text" value="${nickname}">
	<input id="m_no" type="hidden" value="${board.mno }">
	<input id="title" type="hidden" value="${board.title}">
	
	

	<section id="main" class="green" >
		<div class="container">
			<div class="container">
	<!-- 상단 -->
	<div class="header" >
		<!-- Insert representative photo here -->
		<div id="headImgDiv"></div>
		<span><button id="likeBtn">♡<br>찜하기</button></span>
		<div id="headTitle"><h1 id="h1-title" style="margin-top: 30px;">${board.title}</h1></div>
		
		<div id="headIntroDiv">

		<p>${board.intro}</p>
		</div>
		
		<div id="headCookTip">
		<p>${board.cooktip}</p>
		</div>
		
		<div class="videoLinkDiv">
			<iframe width="560" height="315" src="https://www.youtube.com/embed/${board.videoCode}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
		</div>
	</div>


	<!-- 재료 -->
	<div class="material margin-T12">
		<div class="sectionTitle MB40T20"><h3 class="h3FW800">재료 <span class="italicTitle">Material</span></h3></div>
		<div class="materialContent elementsMargin" id="materialContentDiv"></div>
	</div>

	<!-- 조리 순서 -->
	<div class="cooking-order margin-T12">
		<div class="sectionTitle MB40T20"><h3 class="h3FW800">조리순서 <span class="italicTitle">Step</span></h3></div>

		<div class="recipeStep elementsMargin" id="recipeStepDiv"> </div>
		
		<!-- 요리 완성사진 -->
		<div class="recipeFinishIm" id="recipeFinishImg"> </div>

		<div class="regdateDiv regDottd" id="regdate">
			<span style="float:left; margin-top: 10px; margin-left: 10px"><b>작성일</b> : ${board.regdate }&nbsp;<b>|</b>&nbsp;<b>수정일</b> : ${board.updatedate }</span>
		</div>

	</div>

	<!-- 작성자 정보 -->
	<div style="border-bottom: 5px solid;" class="writerInfoDiv margin-T12">
		<div class="sectionTitle MB40T20"><h3 class="h3FW800">레시피 작성자 <span class="italicTitle">Writer</span></h3></div>
		<div id="MemberInfoDiv"><div id="MemberImg"></div> <span style="margin-left: 20px; padding-top: 20px; font-weight: 900;"> ${board.nickname}</span></div>
	</div>

	<div id="replyContainer" style="margin-top: 100px;">
	<!-- 요리후기  -->
	<div id="cookingReviewSection" class="cooking-review margin-T12">
		
		<!-- 포토리뷰 -->
		<div class="photo-review">
			<h3 class="h3FW800">포토리뷰 <span id="photoReviewCnt" class="cntClass"></span></h3>
			<div id="photoReviewDiv"></div>
		</div>
	</div>
	
		<!-- 일반 요리 후기 -->
		<div class="general-commentContainer margin-T12">	
		<div style="margin-left: 60px; margin-bottom: 10px;" class="sectionTitle MB40T20"><h3 class="h3FW800">요리후기 <span id="replyCnt" class="cntClass"></span></h3></div>
			<div class="general-commentContents">
			<div class="general-comment margin-T12" id="generalCommentDiv"></div>
			
			<div class="d-grid gap-2 col-6 mx-auto">
			  <button id="moreButton" type="button" class="btn btn-success">후기 전체보기</button>
			  <button id="reduceBtn" type="button" class="btn btn-success" style="display:none;">후기 줄이기</button>
			</div>
			</div>
		</div>
		
		<!-- 댓글 작성 부분, 사진 첨부 추가 -->
		<!-- <button id="moreButton">더보기</button> -->
		<div id="writerDiv" class="comment-writing margin-T12" style="margin-top: 18px;">
			<form style="height:130px;" id="replyPhotoForm_Test" enctype="multipart/form-data" name="replyPhotoForm_Test">
						
				<div style="position: absolute; margin-top: 110px;" class="starDiv" data-max="5"></div>
					<input id="b_no" name ="b_no" type="hidden" value="${board.b_no}">
					<input type="hidden" id="star">
				
					<input style="display:none;" type="file" name="files" id="image" accept="image/*" onchange="setThumbnail(event);">
				<div id="image_container"></div>			
					<input type="text" id="writer" name="writer" value="${nickname}"> 
				
					<img  src="https://recipe1.ezmember.co.kr/img/pic_none3.gif" alt="파일첨부" width="100" height="100" onclick="document.getElementById('image').click();" style="cursor:pointer; margin-right: 10px; border: 2px solid #ddd;">
					<textarea id="reply" name="reply" class="form-control"
						placeholder="다양한 요리 후기를 작성해주세요!"
						style="height: 100px; resize: none;"></textarea><span ><button class="writeBtn" id="replyPhotoupload_Test" value="나는 후기">작성</button></span>
			
			</form>	
		</div>
		
		<!-- 일반댓글 표시 -->
		<div  class="generalReply margin-T12" id="generalReplyContainer">
			
			<div class="sectionTitle MB40T20"><h3 class="h3FW800">한줄댓글 <span class="italicTitle">Reply</span></h3></div>
			
			<div id="generalReplyDiv"></div>
		
			<div class="d-grid gap-2 col-6 mx-auto">
			  <button id="moreGRButton" type="button" class="btn btn-success">댓글 전체보기</button>
			  <button id="reduceGRBtn" type="button" class="btn btn-success" style="display:none;">댓글 줄이기</button>
			</div>
		
			<div class="generalReplyWrite bodySection ">
				<form id="grForm">
					<input id="b_no" name ="b_no" type="hidden" value="${board.b_no}">
					<div id="generalReplyWriteDiv">
					<div style="display: flex;"><input style="width:30%;" type="text" id="replyer" name="replyer" placeholder="작성자 입력"><span style="margin-left: 300px; color: crimson; margin-top: 10px;"> <b>! 주의 !</b> 아무리 익명이라도 비난 & 욕설 댓글 작성 시 신고 대상이 될 수 있습니다. </span></div>
					<div style="display: flex;"><textarea style=" resize: none; " id="content" class="form-control margin-T12" name="contnet" rows="" cols="" placeholder="댓글을 작성해주세요!"></textarea>
					<button id="grBtn" onclick="grWrite()">댓글작성</button></div>
					</div>
				</form>
			</div>
		</div>
		
	</div>
	
	
	
	
		
	
	<!-- 모달창 -->
	<div id="ingredientModal" class="modal">
		<div style="width: 500px; padding-top: 80px;" class="modal-content ">
			<div class="modal-header" style="margin-bottom: 20px; padding: 0; padding-bottom: 1px; position: absolute; top: 0; background: #d79d7254; left: 0; width: 100%;">
				<h5 style="margin: 0; margin-left: 15px; color:#7c9f46; margin-top: 4px">재료 정보</h5><span class="close" style="margin-left: 0;  margin-right: 15px;" onclick="closeModal()">&times;</span>
			</div> 
			
			<div class="ingreModal_wrap">
			<div class="ingredientImgDiv" id="ingredientTop">
				<!-- 재료 사진 출력  -->
			</div>

			<div class="ingredientInfoDiv" id="ingredientInfoDiv">
				<!-- 재료 정보가 여기에 출력될 것입니다. -->
			</div>
			</div>
		</div>
	</div>

	<div id="photoReviewModal" class="modal">
		<div style="padding-top: 0px; position: relative; width:60%;"class="modal-content">
			<div class="modal-header" style="position: absolute; width: 100%; left: 0; background-color: #d79d7254;">
				<h5 style="margin:0px; color: #7c9f46;">포토리뷰</h5><span style="position: absolute; right: 0px; top: 0; margin-right: 20px; margin-top: 5px;" class="close" onclick="closeModal()">&times;</span>
			</div>
			<div style="display:flex; margin-top: 30px; padding-top: 100px;">
			
			<div id="container">
			
			<div id="photoReviewImgDiv">
			
			</div>
			<div id="photoReviewReplyDiv"></div>
			</div>
		
			<!-- 전체 포토리뷰가 표시되는 부분 -->
			<div id="photoReviewModalList">
			</div>	
			</div>
			</div>
	</div>
	
	<!-- 요리순서 모달창 -->
	<div id="stepModal" class="modal">
		
		
		<div style="width: 1000px; justify-content: center; align-items: center; overflow: hidden; padding-top: 90px;" class="modal-content">
				<div class="modal-header" style="width: 100%; position: absolute; padding-bottom: 40px; margin-bottom: 20px; top:0; background-color: #d79d7254;">
				<span style="color: #aaa; position: absolute; right: 0; top: 0; margin-right: 20px; margin-top: 5px;" class="close" onclick="closeModal()">&times;</span>
			</div>
			
			<div class="stepImgDiv" id="stepImgDiv">
			
			</div>
		</div>
	</div>
	
	<!-- </div> -->
	
	
	<!-- 최근 방문한 레시피 -->
	<div id="recentlyContainer">
		
		<h5 class="h3FW800">최근 본 레시피</h5>
		
		<div id="recentlyViewed" class="recently-viewed">
			<!-- Display recently viewed recipes as clickable images -->
		
			<!-- Add more recently viewed recipes if needed -->
		</div>
	</div>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
			</div>
		</div>
	</section>
	<!-- Footer -->
	<%@ include file="../common/footer.jsp" %>
</body>
</html>
