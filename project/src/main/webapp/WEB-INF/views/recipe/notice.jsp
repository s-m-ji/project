<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지</title>
	
	<script src="/resources/assets/js/jquery-3.7.0.js"></script>
	
	<!-- 부트스트랩  -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
 	
 	<!-- notice.css (지수) -->
 	<link rel="stylesheet" type="text/css" href="/resources/recipe_css/notice.css">
    
    <!-- pageNavi css -->	
 	<link rel="stylesheet" href="/resources/recipe_css/mimi.css">
	
    <!--  fontawesome -->    
    <script src="https://kit.fontawesome.com/59843f4445.js" crossorigin="anonymous"></script>
   
   <!--  Header -->
 	<%@ include file="../common/header.jsp" %> 
 
	
	<!--  모달 창 js -->
	<script type="text/javascript" src="/resources/recipe_js/modal.js"></script>
	

<script type="text/javascript">
window.addEventListener('load', function(){

	var btnDel = document.getElementsByClassName('btnDelN');
	
	console.log("삭제" , btnDel);
	
	function btnDelClick(nno){
		return function(){
				  var url = '/recipe/noticeDel?nno=' + nno;
				  window.location.href = url;
		}			
	}
	
	for(var i=0; i<btnDel.length; i++){
		 var nno = btnDel[i].getAttribute('data-nno');
		 console.log("del 실행 할 때  의 nno : " , nno);
		 btnDel[i].addEventListener('click', btnDelClick(nno));
	}
});

//페이지 번호를 받아서 페이지를 호출 해주는 함수 
	 function goNotice(page){
	document.noticeForm.pageNo.value=page;
	document.noticeForm.submit();
} 
</script>

</head>
<body>
 <!-- Main -->
<section id="main">
	<div class="container">

	<div class="container">

<!--검색 폼 -->
<%-- <div class="list-group w-auto searchDiv">
<form name ="noticeForm" method ="get" action="/recipe/notice"  class="row g-3 justify-content-center">

<input type="hidden" name ='pageNo' value ="${pageDtoN.cri.pageNo}"></input> 

  <div class="col-sm-2">
			<select name ="sField" class="form-select" aria-label="Default select example" style="width: 200px;"  onchange="this.form.submit();" >
				<option value="">전체</option>
				<option value = "일반"${pageDtoN.cri.SField eq "일반" ? "selected" : ""}>일반</option>
				<option value = "이벤트"${pageDtoN.cri.SField eq "이벤트" ? "selected" : ""}>이벤트</option>
				<option value = "자주 묻는 질문"${pageDtoN.cri.SField eq "자주 묻는 질문" ? "selected" : ""}>자주 묻는 질문</option>
			</select>
	</div>
</form> 	
</div> --%>

<!--공지 총 개수   -->
<div style="display: flex;justify-content: flex-end;" > 
<%-- <p style="margin: 0px;"> 오늘의 공지<b style="font-size: 1.8em">${totalNcnt}</b>개📜</p>
 --%></div>
<c:set  value="${notList}" var="notice"></c:set>  

<!--  관리자 adminRole 이 포함되어있으면 보여주고 아니면 x  -->
<!-- 공지 등록 -->
<c:if test="${not empty member.role}">
  <div class="dropdown d-md-flex justify-content-md-end">
    <button type="button" class="btn btn-outline-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false" data-bs-auto-close="outside">
      공지 등록
    </button>
</c:if>

    <input type="hidden" class="form-control" id="nno" name ="nno" placeholder="공지번호" >
    <form class="dropdown-menu p-4" action="/recipe/writeAction" method="post" accept-charset="UTF-8">
       <div>
       <h4 style='line-height: center; text-align: center;'> 공지사항📝</h4>
      <div class="input-group mb-3">
        <span class="input-group-text" id="basic-addon1">작성자</span>
        <input type="text" class="form-control" id="nwriter" name ="nwriter" value = "admin">
      </div>
  
      <div class="input-group mb-3" style="padding-top: 10px;">
        <label class="input-group-text" for="gubun" >  구분　</label>
        <select class="form-select" id="gubun" name='gubun' style="margin-bottom: 15px;">
          <option selected>선택입력</option>
          <option value="일반">일반</option>
          <option value="이벤트">이벤트</option>
          <option value="자주 묻는 질문">자주 묻는 질문</option>
        </select>
      </div>
      
      <div class="mb-4">
        <input type="text" class="form-control" id="ntitle" name ="ntitle" placeholder="제목" required>
      </div>
  
      <div class="mb-10">
        <textarea class="form-control" id="ncontent" name = "ncontent" rows="10" placeholder='공지 내용을 입력해주세요' required ></textarea>
      </div>
  <br>
      <div class="mb-3 d-md-flex justify-content-md-center" >
        <button type="submit" class="btn btn-secondary">작성완료</button>
        </div>
      </div>
    </form>

  </div> 
<!-- 공지 목록  -->
<form method="get" name="viewForm" accept-charset="UTF-8" >
 	
                <section class="NoticeContentstyle__Container-sc-12y37o4-0 ihesfa">
                    <div class="NoticeContentstyle__TitleBox-sc-12y37o4-1 laHiqv">
                        <h2>공지사항</h2>
                        <div class="list-group w-auto searchDiv" style="display: inline-block;padding-left: 480px;">
<form name ="noticeForm" method ="get" action="/recipe/notice"  class="row g-3 justify-content-center">

<input type="hidden" name ='pageNo' value ="${pageDtoN.cri.pageNo}"></input> 

  <div class="col-sm-2">
			<select name ="sField" class="form-select" aria-label="Default select example" style="width: 200px;"  onchange="this.form.submit();" >
				<option value="">전체</option>
				<option value = "일반"${pageDtoN.cri.SField eq "일반" ? "selected" : ""}>일반</option>
				<option value = "이벤트"${pageDtoN.cri.SField eq "이벤트" ? "selected" : ""}>이벤트</option>
				<option value = "자주 묻는 질문"${pageDtoN.cri.SField eq "자주 묻는 질문" ? "selected" : ""}>자주 묻는 질문</option>
			</select>
	</div>
</form> 	
</div>
                        <p style="display: inline-block;padding-left: 400px;"> 오늘의 공지<b style="font-size: 1.8em">${totalNcnt}</b>개📜</p>
       
                    </div>
               
                    <c:forEach items="${notList}" var="notice" step="1">
                       	<input type="hidden" name="nno" value="${notice.nno}" data-nno="${notice.nno}" >
                       	
                     <c:if test="${empty notList }">
                    <p>등록된 공지사항이 없습니다.</p>
                    </c:if>
             
                <ul id="nList">
                        <li>
                    <button type="button" name="disBtn" class="ServiceItemstyle__ContainerBtn-sc-1omzxdj-0 hziaxr" id = 'btn' onclick='dis(this)'>
                       <c:if test="${notice.gubun eq '일반'}">
                        <p id="first">${notice.gubun}</p> 
                       </c:if>
                       <c:if test="${notice.gubun eq '이벤트'}">
                        <p id="second">${notice.gubun}</p> 
                       </c:if>
                      <c:if test="${notice.gubun eq '자주 묻는 질문'}">
                        <p id="third">${notice.gubun}</p> 
                       </c:if>
                       
                       
                      <%--   <p>${notice.nno}</p> --%>
                      <p>${notice.ntitle }</p>
                       
                        <div class="ServiceItemstyle__CenterBox-sc-1omzxdj-1 iUcEVv">
                           <%--  <p>${notice.ntitle }</p> --%>
							<p style="margin-right: 55px;">${notice.nwriter }</p>
                            <p>${notice.nregdate }</p>
                        </div>
                    </button>
                    
                    <div class="ServiceItemstyle__ContentsBox-sc-1omzxdj-2 fEPIbI show" >
                       	<table>
                       	<tr id="tr${notice.nno}">
						<td class="writerTD" style="display: none;">${notice.nwriter}</td>
						<td class="titleTD" style="display: none;">${notice.ntitle}</td> 
						<td class="contentTD">${notice.ncontent}</td>
						<td class="gubunTD"  style="display: none;">${notice.gubun}</td>
                        <td>
                       	  <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                        	              <!-- 관리자일 경우 수정, 삭제 버튼 보여지도록 함  -->
                       	<c:if test="${not empty member.role}">
                  			<button type="button" class="btn btn-outline-secondary" name="modify" value="${notice.nno }" data-bs-toggle="modal" data-bs-target="#myModal2"> 수정 </button>
                        	<button type='button' class="btn btn-outline-secondary btnDelN" data-nno = "${notice.nno}"> 삭제 </button>
             				  </c:if>
                        </div>
                        </td>
                        </tr>
                        </table>
                    </div>
               		  </li>
                </ul>
                </c:forEach>     
                </section>
              </form>
<!-- 공지 수정 (modal.js) -->
<div id="myModal2" class="modal fade" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"  role="dialog" style="background: transparent;">
  <div class="modal-dialog" style="padding: 0; background: transparent;">
    <div class="modal-content">
      <div class="modal-header">
       <!--  <h1 class="modal-title fs-5" id="exampleModalLabel"></h1> -->
    	  <h4 id="modal-title" class="modal-title" style="padding-left: 150px;"></h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       <table class="table">
       <tbody>
 					<tr>
						<td>작성자</td>
						<td><input class="form-control" id="nwriterN" type="text"> </td>
					</tr>
					
					<tr>
					<td>구분</td>
                        <td><select class="form-control" id="gubunN" name='gubun'>
                          <option selected>선택입력</option>
                          <option value="일반">일반</option>
                          <option value="이벤트">이벤트</option>
                          <option value="자주 묻는 질문">자주 묻는 질문</option>
                        </select>
					</td>
                    </tr>		
					<tr>
						<td>제목</td>
						<td><input class="form-control" id="ntitleN" type="text"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea class="form-control" id="ncontentN" rows="10"></textarea></td>
					</tr>
				</table>
      </div>
      <div class="modal-footer justify-content-center">
          <button type="button" id="modalSubmit" class="btn btn-warning">수정</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>


<!-- 페이지 블럭  -->
<c:set var="pageDto" value="${pageDtoN}"/>
<div class="text-center pageNavi" style="padding: 10px;">
	<nav aria-label="Page navigation example">
	  <ul class="pagination justify-content-center">
	    <li class="page-item ${pageDtoN.prev? '' : 'disabled'}">
	      <a class="page-link" onclick="goNotice(1)" href="#"><i class="bi bi-chevron-double-left"></i></a>
	    </li>
	    <li class="page-item ${pageDtoN.prev? '' : 'disabled'}" >
	      <a class="page-link" <c:if test="${pageDtoN.prev}"> onclick="goNotice(${pageDtoN.startNo - 1})"</c:if>  href="#"><i class="bi bi-chevron-left"></i></a>
	    </li>
	     <c:forEach begin="${pageDtoN.startNo}" end="${pageDtoN.endNo}" step="1" var="i">
   		 <li class="page-item ${i eq pageDtoN.cri.pageNo ? 'active' : ''}">
   		 	<a class="page-link ${i eq pageDtoN.cri.pageNo ? 'active' : ''}" onclick="goNotice(${i})" href="#"><c:out value="${i}"></c:out></a>
   		 </li>
	    </c:forEach>
	    <li class="page-item ${pageDtoN.next? '' : 'disabled'}">
	      <a class="page-link" <c:if test="${pageDtoN.next}"> onclick="goNotice(${pageDtoN.endNo + 1})"</c:if> href="#"><i class="bi bi-chevron-right"></i></a>
	    </li>
	    <li class="page-item ${pageDtoN.next? '' : 'disabled'}">
	      <a class="page-link" onclick="goNotice(${pageDtoN.realEndNo})" href="#"><i class="bi bi-chevron-double-right"></i></a>
	    </li>
	  </ul>
	</nav>
	</div>
		</div>
	</div>
</section>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<!-- Footer -->
	<%@ include file="../common/footer.jsp" %>
            