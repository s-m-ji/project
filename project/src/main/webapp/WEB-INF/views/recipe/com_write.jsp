<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티게시판</title>
</head>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" />

<script type="text/javascript">

//페이지 다시생성
 function resetbtn() {
    const isConfirmed = confirm("정말 취소하시겠습니까?");
    if (isConfirmed) {
      window.location.href = "http://localhost:8080/comboard/list"; 
    }
  }

</script>
</head>
<body>
 <!-- Header -->
	<%@ include file="../common/header.jsp" %>
	
	<section id="main" style="border: 3px dashed #ed786a;">
	<div class="container">
		<div class="container gtco-section">
	<!-- 가운데로 "망한요리게시판" 크게 표시 -->
   <!--  <div style="text-align: center; font-size: 30px; font-weight: bold; margin-bottom: 20px; color: darkred;">
        ♨♨♨ 망한요리게시판 ♨♨♨
    </div> -->
<form action="/comboard/comWriteAction" method="post" enctype="multipart/form-data">	
 
         <div>
              <label for="exampleFormControlInput1">제목</label>
            <input type="text" class="form-control" id="com_title" name="com_title"
             value="${board.com_title }" placeholder="제목을 작성해주세요.">
          </div>
       
          <div>
            <label for="exampleFormControlTextarea1">내용</label>
            <textarea class="form-control" id="com_content" name="com_content" 
            rows="10" placeholder="내용을 작성해주세요. 비속어는 삼가해주세요 ㅠ">${board.com_content }</textarea>
          </div>
          
          <div>
          	<label for="exampleFormControlTextarea1">닉네임</label>
          	<input type="text" class="form-control" id="nickName" name="nickName" 
          	value="${board.nickName }" placeholder="닉네임을 작성해주세요.">
           </div>
      
           
           <div>
          	<label for="exampleFormControlTextarea1">회원번호</label>
          	<input type="text" class="form-control" id="mno" name="mno" 
          	value="${board.mno }" placeholder="고유번호를 작성해주세요.">
           </div>
       
           <div>
           
		        <label for="exampleFormControlInput1">사진 추가</label>
		        <input type="file" name="photos" id="photoInput" class="form-control" 
		        accept="image/jpeg, image/png" multiple="multiple">
    	   </div> 
         
    
    <!-- 썸네일을 보여줄 컨테이너 -->
    <div id="thumbnailContainer" style="display: flex; flex-wrap: wrap;"></div>
    
    
          
          
          
       
          
          <div style="text-align: center;">
		<!-- bno 값이 있으면 수정하기 -->
				<c:if test="${not empty board.com_bno}" var="res">
			    	<input type="hidden" name="com_bno" value="${board.com_bno}">
					<button type="submit" style="color: #fff;"onclick="requestAction('/comboard/editAction')">수정하기</button>
					
				</c:if>
				<!-- 없으면 등록하기 -->
				<c:if test="${not res}">
					<button type="submit" style="color: #fff;">등록하기</button>
				</c:if>
		
		
				<button type="reset" onclick="resetbtn()" style="color: #fff;">취소</button>
		</div>
		
		
          
           
    
    
   
    
          
          </div>
          </div>
    </form>
	</section>
<!-- Footer -->
	<%@ include file="../common/footer.jsp" %>
	
	
	<script>
    // 파일 선택 시 썸네일 미리보기 생성
    const photoInput = document.getElementById('photoInput');
    const thumbnailContainer = document.getElementById('thumbnailContainer');

    photoInput.addEventListener('change', function (event) {
        thumbnailContainer.innerHTML = ''; // 이전 썸네일 제거

        // 선택한 파일들에 대해 썸네일 생성
        for (const file of event.target.files) {
            const thumbnail = document.createElement('img');
            thumbnail.style.width = '100px'; // 썸네일 크기 조정 (원하는 크기로 변경 가능)
            thumbnail.style.height = '100px';
            thumbnail.src = URL.createObjectURL(file); // 파일로부터 썸네일 URL 생성
            thumbnailContainer.appendChild(thumbnail);
        }
    });
</script>
	
</body>
</html>