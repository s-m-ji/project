<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지</title>
	
	<script src="/resources/assets/js/jquery-3.7.0.js"></script>
	
	<!--  모달 창 js -->
	<script type="text/javascript" src="/resources/recipe_js/modal.js"></script>
	
	<!-- 부트스트랩을 사용하기 위해서 css, js를 추가 합니다. -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
 	
 	<!--  notice의 css   ** recipe_css 로 -->
 	<link rel="stylesheet" type="text/css" href="/resources/recipe_css/notice.css">
    
    <!--  fontawesome -->    
    <script src="https://kit.fontawesome.com/59843f4445.js" crossorigin="anonymous"></script>
    
 <%@ include file="../common/header.jsp" %> 
 

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
/* // 공지 클릭 > 상세 
function dis(element){
 
    var $item = $(element).closest('li');
    if($item.find('.show').is(':hidden')){
      $item.find('.show').show();
    }else{
      $item.find('.show').hide();
    }
  }
   */
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



<!--검색 폼 -->
<div class="list-group w-auto searchDiv">
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

<!--공지 등록   -->

<div style="padding-left: 910px;" > 
<p style="margin-bottom: 0px;"> 오늘의 공지<b> ${totalNcnt}</b> 개🪐</p>
</div>
<c:set  value="${notList}" var="notice"></c:set>  
  <div class="dropdown d-md-flex justify-content-md-end">
    <button type="button" class="btn btn-outline-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false" data-bs-auto-close="outside">
      공지 등록
    </button>


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
  
<!-- 공지 사항 목록  -->
<form method="get" name="viewForm" accept-charset="UTF-8" >
 	
                <section class="NoticeContentstyle__Container-sc-12y37o4-0 ihesfa">
                    <div class="NoticeContentstyle__TitleBox-sc-12y37o4-1 laHiqv"
                    style="
    margin-top: 0px;
    margin-left: 0px;
    margin-right: 0px;
    padding-right: 860px;
    margin-left: 30px;">
                        <h2>공지사항</h2>
                    </div>
               
                    <c:forEach items="${notList}" var="notice" step="1">
                       	<input type="hidden" name="nno" value="${notice.nno}" data-nno="${notice.nno}" >
                       	
                     <c:if test="${empty notList }">
                    <p>등록된 공지사항이 없습니다.</p>
                    </c:if>
             
                <ul id="nList">
                        <li>
                    <button type="button" class="ServiceItemstyle__ContainerBtn-sc-1omzxdj-0 hziaxr" id = 'btn' onclick='dis(this)'>
                        
                        <p>${notice.gubun }</p>
                        <p>${notice.nno}</p>
                       
                        <div class="ServiceItemstyle__CenterBox-sc-1omzxdj-1 iUcEVv">
                            <p>${notice.ntitle }</p>
                            <p>${notice.nregdate }</p>

                        </div>
                    <!--     <span style="box-sizing:border-box;display:inline-block;overflow:hidden;width:initial;height:initial;background:none;opacity:1;border:0;margin:0;padding:0;position:relative;max-width:100%">
                            <span>
                                <i class="fa-solid fa-plus " style="color: #4f6996; box-sizing:border-box;display:inline-block;overflow:hidden;width:initial;height:initial;background:none;opacity:1;border:0;margin:0;padding:10;position:relative;max-width:100%; transform: translateY(-3px);"></i>
                            </span>
                        </span> -->
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
                       <%--  <c:if test="${sessionScope.admin == 'y'}"> --%>
                        	<button type="button" class="btn btn-outline-primary" name="modify" value="${notice.nno }" data-bs-toggle="modal" data-bs-target="#myModal2"> 수정 </button>
                        	<button type='button' class="btn btn-outline-primary btnDelN" data-nno = "${notice.nno}"> 삭제 </button>
                       <%--  </c:if> --%>
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
<!-- 수정 -Modal -->
<div id="myModal2" class="modal fade" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"  role="dialog" style="background: transparent;">
  <div class="modal-dialog" style="padding: 0; background: transparent;">
    <div class="modal-content">
      <div class="modal-header">
       <!--  <h1 class="modal-title fs-5" id="exampleModalLabel"></h1> -->
    	  <h4 id="modal-title" class="modal-title" style='padding-left: 183px;'></h4>
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

<!-- 페이지 블럭 생성 -->
            <div class ="div d-md-flex justify-content-md-center">
		<c:set var="pageDto" value="${pageDtoN}"/>
		
		<!-- 이전버튼 -->
		<c:if test="${pageDtoN.prev}">
			<input type='button' value='이전' onclick='goNotice(${pageDtoN.startNo-1})' class="btn">
		</c:if>
		
		<!-- 페이지번호 출력 -->
		<c:forEach begin="${pageDtoN.startNo }" end="${pageDtoN.endNo }" var="i">
			<input type='button' value='${i}' onclick='goNotice(${i})' class="btn" >
		</c:forEach>
		
		<!-- 다음버튼 -->
		<c:if test="${pageDtoN.next }">
			<input type='button' value='다음' onclick='goNotice(${pageDtoN.endNo+1})' class="btn">		
		</c:if>
		</div>

    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
            
</body>
</html>