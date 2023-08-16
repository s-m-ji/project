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
	
	
	// 글 삭제
	btnDelete.addEventListener('click', function(){
	    if (confirm("정말로 삭제하시겠습니까?")) {
	        viewForm.action='/comboard/delete'; 
	        viewForm.submit();
	    }
	    alert('정상적으로 삭제되었습니다.')
	});
	
	// 리스트 페이지 이동
	document.getElementById("btnList").addEventListener('click', function(){
	    viewForm.action='/comboard/postList';
	    viewForm.submit();
	});
	
	
	
	
	
	
	

// 댓글 목록
document.getElementById("btnReplyWrite").addEventListener("click", function() {
    // 댓글 내용을 가져옵니다.
    var replyContent = document.getElementById("replyContent").value;

    // 댓글 데이터를 담을 객체를 생성합니다.
    var replyData = {
        com_bno: "${board.com_bno}",
        reply: replyContent
    };

    $.ajax({
        url: '/comboard/replyInsert',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(replyData),
        success: function(response) {
            if (response.result === 'success') {
                alert('댓글이 성공적으로 등록되었습니다.');
                location.reload();
            } else {
                alert('댓글 등록에 실패하였습니다.');
            }
        },
        error: function(xhr, status, error) {
            alert('댓글 등록 중 오류가 발생하였습니다.');
        }
    });
});



function replyDelete(R_NO){
	console.log('R_NO', R_NO )
	fetchPost('/comboard/replyDelete/' + R_NO, replyRes);
}













	
   
	
});
	 

</script>
</head>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" />
<body>


	
	

<div style="text-align: center; font-size: 30px; font-weight: bold; margin-bottom: 20px; color: darkred;">
        ♨ 망했어요 ♨
    </div>

<input type="hidden" value="${board.com_bno}">
<form method="post" name="viewForm">

	<div class="mb-3">
	  <label for="title" class="form-label">제목</label>
	  <input name="com_title" id="com_title" 
	  type="text" readonly class="form-control" value='${board.com_title }' style="width:200px;">
	</div>
	
	
	<div class="mb-3">
	  <label for="content" class="form-label">망하게 된 사연...</label>
	  <textarea class="form-control" id="com_content" readonly
	  			 name="com_content" rows="3" style="width:500px; height: 300px;">${board.com_content }</textarea>
	</div>
	
	
	<!-- 이미지 출력 -->
	<div>
    <img src="/comboard/comFile?filename=${comFile.filename}" alt="Image">
</div>
	
	
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
                    <th scope="col" class="col-1" style="text-align: center;">#</th>
                    <th scope="col" class="col-9" style="text-align: center;">댓글</th>
                    <th scope="col" class="col-2" style="text-align: center;">작성자</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${myReplies}" var="reply">
				    <tr>
				        <td>${reply.getR_NO()}</td>
				        <td>
				            ${reply.getReply()}
				            
				            <i class="fa-regular fa-pen-to-square" onclick="replyEdit(${reply.getR_NO()})"></i>
							<i class="fa-regular fa-trash-can" onclick="replyDelete(${reply.getR_NO()})"></i>
				        </td>
				        <td>${reply.getMno()}</td>
				    </tr>
				</c:forEach>
            </tbody>
        </table>
    </c:otherwise>
</c:choose>


<!-- Footer -->
	<%@ include file="../common/footer.jsp" %>
	
	
	
	
</body>
</html>