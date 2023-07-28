<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
    <title>Bulletin Board Detail Page</title>
    
   <link href="/resources/css/view.css" rel="stylesheet">
   <style>

        .material-span {
    /* Add some padding on the right side of the text "Eggs" */
    padding-left: 150px;
    /* Alternatively, you can use margin to create a gap between the text and <span> */
    /* margin-right: 10px; */
}

/* 모달창 스타일 */
.modal {
  display: none;
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
  background-color: #fefefe;
  margin: 15% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

    </style>
   <script type="text/javascript">
   
   	
   		window.addEventListener('load', function(){
   		
   			
   			// 상단 사진 이미지 출력
   			getFileList();
   			
   			// 재료 정보 출력
   			getMaterial();
   			
   			// 요리 순서 출력
   			getRecipeStep();
   			
   			// 댓글 출력 
   			
   			getRecipeReply();
   			
   		})
   		
   		
   		function getFileList(){
   		
   		
   		let bno = '${board.b_no}';
   		
   		// fetch 사용
   		// 정보를 가져와서 함수에 파라메터로 넣는다. 
   		fetch('/file/list/' + bno)
   			.then(response => response.json())
   			.then(map => viewFileList(map));
   			
   		}
   		
   		// 상단 img ======================================================================
   		
   		function viewFileList(map){
   			
   			// 잘 들어왔는지 확인
   			console.log('map 출력 :', map);
   			let content = '';
   			
   			if(map.list.length > 0) {
   				
   				map.list.forEach(function(item, index){
   					
   					let savePath = encodeURIComponent( item.savePath);
   					console.log('savePath : ', savePath);
   					
   					content +=
   						
   						'<a><img src="/display?fileName=' + savePath +'"></a>';
   				})
   				
   				
   			}else { 
   				content = '등록된 파일이 없습니다.';
   			}
   			
   			headImgDiv.innerHTML = content;
  
   		}
   		
   		
   		// 재료정보출력 ======================================================================== 
   		
   		function getMaterial(){
   			
   			let bno = '${board.b_no}';
   	   		
   	   		// fetch 사용
   	   		// 정보를 가져와서 함수에 파라메터로 넣는다. 
   	   		fetch('/recipe/material/' + bno)
   	   			.then(response => response.json())
   	   			.then(map => viewMaterialList(map));
   	   			
   	   		}
   		
   		
   		function viewMaterialList(map){
   				
   			console.log('재료정보 map 출력 : ', map);
   			let content = '<b>[재료]</b>';
   			// Controller 에서 map 에 put 할때 지정한 값이 있다면..
   			
   			if(map.materialList.length > 0){
   				
   				map.materialList.forEach(function(item, index){
   					
   					let i_name = item.i_name;
   					let materialCnt = item.materialcnt;
   					// input hidden 으로 가지고 간다음 클릭하면 넘어갈때 가져갈 수 있도록 해보자
   					var i_no = item.i_no;
   					
   					
   						
					content +=   						
   						
						'<input type="hidden" value="'+i_no+'">'
   						+'<div>'
    					
    					+'<ul>'
        				+'<li class="">' + i_name +'&nbsp;<i class="fa-solid fa-circle-info" style="color: #374967;" onclick="goModal(' + i_no + ')"></i>'
        				+'</i><span class="material-span">'+materialCnt+'개</span></li>'
        				+'</ul>'
						+'</div>'
   				})
   				
   				
   			}else{
   				content='재료 정보를 불러오지 못했습니다.';
   			}
   			
   			
   			materialContentDiv.innerHTML = content;
   		}
   		
   		
   		
   		// 버튼을 클릭하면 모달창 출력
   		function goModal(i_no){
   			
   			console.log('goMoal 출력 : ', i_no);
   			
   			
   			
   		// fetch 사용
   	   		// 정보를 가져와서 함수에 파라메터로 넣는다. 
   	   		fetch('/recipe/modal/ingredientModal/' + i_no)
   	   			.then(response => response.json())
   	   			.then(map => viewIngredientsModal(map));
   	   			
   	   		}
   			
   		
   		
   		
   		
   		function viewIngredientsModal(map){
   			
   			console.log('모달창 재료 정보 map 출력 : ', map)
   			
   		 	const modal = document.getElementById("ingredientModal");
   		  	const ingredientInfoDiv = document.getElementById("ingredientInfoDiv");

   		  	let content = '';
   		  	if (map.ingredient) {
   		    content +=
   		      '<p><b>재료명: </b>' + map.ingredient.i_name + '</p>' 
   		      	+ '<p><b>효능: </b>' + map.ingredient.i_power + '</p>'
   		   		+ '<p><b>잘맞는 음식: </b>' + map.ingredient.i_friendfood + '</p>' 
   				+ '<p><b>손질법: </b>' + map.ingredient.i_repair + '</p>'
   				+ '<p><b>관련요리: </b>' + map.ingredient.i_cook + '</p>';
   		  } else {
   		    content = '재료 정보를 가져오지 못했습니다.';
   		  }

   		  ingredientInfoDiv.innerHTML = content;
   		  modal.style.display = "block";
   		}

   		
   		function closeModal() {
   		  const modal = document.getElementById("ingredientModal");
   		  modal.style.display = "none";
   		}
   			
   			
   		
   		
   		
   		//--------------------------------------------------------------------------------------
   			
   		// 요리 순서 출력
   		function getRecipeStep(){
   			
   			let bno = '${board.b_no}';
   	   		
   	   		// fetch 사용
   	   		// 정보를 가져와서 함수에 파라메터로 넣는다. 
   	   		fetch('/recipe/recipeStep/' + bno)
   	   			.then(response => response.json())
   	   			.then(map => viewRecipeStep(map));
   	   			
   	   		}
   		
   		
   		function viewRecipeStep(map) {
   		    console.log('조리순서 map 출력 : ', map);
   		    let content = '';
   		    // Controller 에서 map 에 put 할때 지정한 값이 있다면..

   		    if (map.recipeStep.length > 0) {
   		        map.recipeStep.forEach(function (item, index) {
   		            let step_content = item.step_content;
   		            var s_no = item.s_no;

   		            // map.list에서 s_no와 일치하는 이미지를 가져오도록 루프를 사용합니다.
   		            let matchedImage = map.list.find(function (imageItem) {
   		                return imageItem.s_no === s_no;
   		            });

   		            content +=
   		                '<input type="text" value="' + s_no + '">'
   		                + '<div>'
   		                + '<ul>'
   		                + '<li class="">' + step_content + '</li>';

   		            if (matchedImage) {
   		                let savePath = encodeURIComponent(matchedImage.savePath);
   		                content +=
   		                    '<li id="stepImg"><a><img src="/display?fileName=' + savePath + '"></a></li>';
   		            }

   		            content += '</ul>'
   		                + '</div>';
   		        });
   		    } else {
   		        content = '재료 정보를 불러오지 못했습니다.';
   		    }

   		    recipeStepDiv.innerHTML = content;
   		}


   		

   		
   		
   		// 댓글 정보 출력 =================================================================
   		
   		function getRecipeReply(){
   			
		let bno = '${board.b_no}';
   	   		
   	   		// fetch 사용
   	   		// 정보를 가져와서 함수에 파라메터로 넣는다. 
   	   		fetch('/recipe/replyList/' + bno)
   	   			.then(response => response.json())
   	   			.then(map => viewReplyList(map));
   			
   		}
   		
   		function viewReplyList(map){
   			
   			console.log('댓글리스트 map 출력 : ', map);
   			
   			
   			let content = '';
   			// Controller 에서 map 에 put 할때 지정한 값이 있다면..
   			
   			if(map.replyList.length > 0){
   				
   				map.replyList.forEach(function(item, index){
   					
   					let r_no = item.r_no; // 댓글번호
   					let replydate = item.replydate; // 작성일
   					let reply = item.reply; // 내용
   					let writer = item.writer; // 작성자
   					
   					// input hidden 으로 가지고 간다음 클릭하면 넘어갈때 가져갈 수 있도록 해보자.
   					// 나중에 댓글과 연결된 사진 가져와야함.
					
   					content +=   						
						
   					'<div class="media-body">'
   				    +'<h4 class="media-heading">'
   				    +'<b class="info_name_f">'+writer+'</b>'+replydate+'<span class="reply_list_star"></span>'
				    +'</h4>'
   				    +'<p class="reply_list_cont">'+reply+'</p></div>';
   				    
   				})
   				
   				
   			}else{
   				content='재료 정보를 불러오지 못했습니다.';
   			}
   			
   			
   			generalCommentDiv.innerHTML = content;
   					
   			
   		}
   			
   		
   		
   
   </script>  		

<body>
	
	<script src="https://kit.fontawesome.com/4863a16a12.js" crossorigin="anonymous"></script>

	board.b_no : 
	<input type="text" value="${board.b_no}">
	<br>
	param.b_no : 
	<input type="text" value="${param.b_no}">
	
    <!-- 상단 -->
    <div class="header" >
        <!-- Insert representative photo here -->
        <div id="headImgDiv" ></div>
        
        <h1>${board.title }</h1>
        
        <p>${board.intro }</p>       
	</div>        




    <!-- 재료 -->
       
    
    <div class="material">
    <h2>재료</h2>
    
    
    <div  id="materialContentDiv">
    	
   	
	
    </div>
    </div>
    
    
    
    <!-- 모달창 -->
<div id="ingredientModal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal()">&times;</span>
    <h2>재료 정보</h2>
    <div id="ingredientInfoDiv">
      <!-- 재료 정보가 여기에 출력될 것입니다. -->
    </div>
  </div>
</div>
    
    
    

    <!-- 조리 순서 -->
    <div class="cooking-order" >
       	<h2>조리순서</h2> 
       	
       	<div id="recipeStepDiv">
       	
       	</div>
       	
       
    </div>
    
    <!-- 작성자 정보 -->
    
    <div>
    <h2>레시피 작성자</h2>
    <div id="MemberInfoDiv">
    	${board.nickname}
    </div>
    </div>

    <!-- 요리후기  -->
    <div class="cooking-review">
    	<h2>요리후기 ${replyCnt}건</h2>
        <!-- 포토리뷰 -->
        <div class="photo-review">
        <h3>포토리뷰</h3>
        
            <!-- Display only images here -->
            <img src="path/to/image1.jpg" alt="Review Image 1">
            <img src="path/to/image2.jpg" alt="Review Image 2">
            <!-- Add more images if needed -->
        </div>

        <!-- 일반 요리 후기 -->
        <div class="general-comment" id="generalCommentDiv">
           		
           	
           		
        </div>

        <!-- 댓글 작성 부분, 사진 첨부 추가 -->
        <div class="comment-writing">
        <form id="replyWriteForm" method="post">
            <textarea id="cmt_tx_content1" onclick="EZ.ATLogin(); return false;" 
            	name="frm[cmt_tx_content]" class="form-control" placeholder="다양한 요리 후기를 작성해주세요!" 
            	style="height:100px; width:100%; resize:none;"></textarea>
       	</form>
        </div>
    </div>

    <!-- 최근 방문한 레시피 -->
    <div class="recently-viewed">
        <!-- Display recently viewed recipes as clickable images -->
        <a href="link-to-recipe1"><img src="path/to/recipe1.jpg" alt="Recipe 1"></a>
        <a href="link-to-recipe2"><img src="path/to/recipe2.jpg" alt="Recipe 2"></a>
        <!-- Add more recently viewed recipes if needed -->
    </div>
</body>
</html>