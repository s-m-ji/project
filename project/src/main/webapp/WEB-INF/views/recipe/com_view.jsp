<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Header -->
	<%@ include file="../common/header.jsp" %>
	
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<script type="text/javascript">

window.addEventListener('load',function(){
	
	// 수정페이지로 이동
	btnEdit.addEventListener('click',function(){
		viewForm.action='/comboard/edit';
		viewForm.submit();
	});
	

	btnDelete.addEventListener('click', function(){
	    if (confirm("정말로 삭제하시겠습니까?")) {
	        viewForm.action='/comboard/delete'; // 수정된 부분
	        viewForm.submit();
	    }
	    alert('정상적으로 삭제되었습니다.')
	});

	document.getElementById("btnList").addEventListener('click', function(){
	    viewForm.action='/comboard/postList';
	    viewForm.submit();
	});
	
	
	
	
	
	
	


document.getElementById("btnReplyWrite").addEventListener("click", function() {
    // 댓글 내용을 가져옵니다.
    var replyContent = document.getElementById("replyContent").value;

    // 댓글 데이터를 담을 객체를 생성합니다.
    var replyData = {
        com_bno: "${board.com_bno}", // 게시물 번호를 여기에 입력합니다. 이 부분은 서버에서 게시물 번호를 받아오는 방법으로 수정해야 합니다.
        reply: replyContent
    };

    // AJAX를 이용하여 서버로 댓글 데이터를 전송합니다.
    $.ajax({
        url: '/comboard/replyInsert',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(replyData),
        success: function(response) {
            // 서버 응답을 처리합니다. 댓글이 성공적으로 추가되었음을 알리는 메시지를 띄웁니다.
            if (response.result === 'success') {
                alert('댓글이 성공적으로 등록되었습니다.');
                // 댓글 등록 후 페이지를 새로고침하여 새로운 댓글이 보이도록 합니다.
                location.reload();
            } else {
                // 댓글 추가에 실패한 경우에 대한 처리를 여기에 추가합니다.
                alert('댓글 등록에 실패하였습니다.');
            }
        },
        error: function(xhr, status, error) {
            // 에러 처리를 여기에 추가합니다.
            alert('댓글 등록 중 오류가 발생하였습니다.');
        }
    });
});


function editReply(replyNumber) {
    // 댓글 수정 버튼이 클릭되었을 때 실행되는 함수입니다.
    // replyNumber를 통해 수정할 댓글의 정보를 서버에서 가져오는 AJAX 요청을 보냅니다.
    $.ajax({
        url: '/comboard/getReply', // 서버에서 댓글 정보를 가져올 엔드포인트 URL로 수정해야 합니다.
        type: 'POST',
        data: { replyNumber: replyNumber },
        success: function(response) {
            if (response.result === 'success') {
                // 서버로부터 받아온 댓글 정보를 이용하여 수정할 댓글을 표시하는 로직을 작성합니다.
                // 예를 들어, 모달 창에 댓글 내용을 입력할 수 있는 폼을 표시하는 방식으로 구현할 수 있습니다.
                // 이때, 댓글 내용을 수정하는 서버 요청을 보내는 로직도 포함되어야 합니다.
            } else {
                alert('댓글 정보를 가져오는데 실패하였습니다.');
            }
        },
        error: function(xhr, status, error) {
            alert('댓글 정보를 가져오는 중 오류가 발생하였습니다.');
        }
    });
}




function deleteReply(replyNumber) {
    if (confirm("정말로 삭제하시겠습니까?")) {
        $.ajax({
            url: '/comboard/deleteReply',
            type: 'POST',
            data: { R_NO: replyNumber }, // 댓글 번호를 'R_NO'라는 이름으로 파라미터 전달
            success: function(response) {
                // 성공적으로 삭제된 경우
                if (response.result === 'success') {
                    alert('댓글이 정상적으로 삭제되었습니다.');
                    location.reload();
                } else {
                    alert('댓글 삭제에 실패하였습니다.');
                }
            },
            error: function(xhr, status, error) {
                alert('댓글 삭제 중 오류가 발생하였습니다.');
            }
        });
    }
}







	
   
	
});
	 

</script>
</head>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" />
<body>


	
	<section id="main" style="border: 3px dashed #ed786a;">

<div style="text-align: center; font-size: 30px; font-weight: bold; margin-bottom: 20px; color: darkred;">
        ♨♨♨ 망한요리게시판 상세보기 ♨♨♨
    </div>

<input type="text" value="${board.com_bno}">
<form method="post" name="viewForm">

	<div class="mb-3">
	  <label for="title" class="form-label">제목</label>
	  <input name="com_title" id="com_title" 
	  type="text" readonly class="form-control" value='${board.com_title }'>
	</div>
	
	
	<div class="mb-3">
	  <label for="content" class="form-label">내용</label>
	  <textarea class="form-control" id="com_content" readonly
	  			 name="com_content" rows="3">${board.com_content }</textarea>
	</div>
	
	
	
         <c:if test="${not empty vo}">
		    <!-- 이미지 표시 -->
		    <div>
		        <label for="exampleFormControlInput1">사진</label><br>
		        <img src="${vo.uploadpath}" alt="Image">
		    </div>
		</c:if>
            
            
	
		 <div style="text-align: center;">
	        <button type="button" id="btnEdit">수정</button>
			<button type="submit" id="btnDelete">삭제</button>
			<button type="button" id="btnList">리스트</button>
          </div>
	
	<input type="hidden" name="com_bno" value="${board.com_bno}">
	
	
	
	
</form>


<input type="text" id="replyer" value="" placeholder="닉네임표시" style="width: 100px;">
<!-- 좋아요순 체크박스 -->
좋아요순 <input type="checkbox" id="likeSortCheckbox">

<!-- 최신순 체크박스 -->
최신순 <input type="checkbox" id="latestSortCheckbox">
 
  
  <div class="input-group">
  <span class="input-group-text">답글작성</span>
  	<input type="text" aria-label="First name" class="form-control" id="replyContent" placeholder="댓글을 입력하세요...">
	<button type="button" id="btnReplyWrite" aria-label="Last name"class="input-group-text"  >등록</button>
  </div>
  
     
  


<c:choose>
    <c:when test="${empty myReplies}">
        <p>댓글이 없습니다.</p>
    </c:when>
    <c:otherwise>
        <table class="table text-break text-center">
            <thead>
                <tr>
                    <th scope="col" class="col-1">#</th>
                    <th scope="col" class="col-9">댓글</th>
                    <th scope="col" class="col-2">작성자</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${myReplies}" var="reply">
				    <tr>
				        <td>${reply.getR_NO()}</td>
				        <td>
				            ${reply.getReply()}
				            <button type="button" class="btn btn-primary" onclick="editReply(${reply.getR_NO()})">수정</button>
				            <button type="button" class="btn btn-danger" onclick="deleteReply(${reply.getR_NO()})">삭제</button>
				        </td>
				        <td>${reply.getMno()}</td>
				    </tr>
				</c:forEach>
            </tbody>
        </table>
    </c:otherwise>
</c:choose>
</section>

<!-- Footer -->
	<%@ include file="../common/footer.jsp" %>
	
	
	
	
</body>
</html>