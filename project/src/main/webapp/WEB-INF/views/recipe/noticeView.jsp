<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지</title>
	
	<script src="/resources/assets/js/jquery-3.7.0.js"></script>
	
	<!-- 부트스트랩을 사용하기 위해서 css, js를 추가 합니다. -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
 	<!--  notice의 css  -->
 	<link rel="stylesheet" type="text/css" href="../resources/css/notice.css">
    <!--  fontawesome -->    
    <script src="https://kit.fontawesome.com/59843f4445.js" crossorigin="anonymous"></script>
    
<script type="text/javascript">

function dis(element){
 
    var $item = $(element).closest('li');
    if($item.find('.show').is(':hidden')){
      $item.find('.show').show();
    }else{
      $item.find('.show').hide();
    }
  }
  
//페이지 번호를 받아서 페이지를 호출 해주는 함수 
	 function goNotice(page){
	document.noticeForm.pageNo.value=page;
	document.noticeForm.submit();
} 

</script>

</head>
<body>

<!--  검색 폼 -->
<div class="list-group w-auto">
<form name ="noticeForm" method ="get" action="/recipe/noticeView"  class="row g-3 justify-content-center">

<input type="text" name ='pageNo' value ="${pageDtoN.cri.pageNo}"></input>

  <div class="col-sm-2">
			<select name ="sField" class="form-select" aria-label="Default select example"  onchange="this.form.submit();" >
				<option value="">전체</option>
				<option value = "일반"${pageDtoN.cri.SField eq "일반" ? "selected" : ""}>일반</option>
				<option value = "이벤트"${pageDtoN.cri.SField eq "이벤트" ? "selected" : ""}>이벤트</option>
				<option value = "자주 묻는 질문"${pageDtoN.cri.SField eq "자주 묻는 질문" ? "selected" : ""}>자주 묻는 질문</option>
			</select>
	</div>
</form> 	
</div>


<!--  공지 사항 목록  -->
<p> 총 <b>${totalNcnt}</b>개📝</p>
<form  method="post" accept-charset="UTF-8" name="editForm">
                <section class="NoticeContentstyle__Container-sc-12y37o4-0 ihesfa">
                    <div class="NoticeContentstyle__TitleBox-sc-12y37o4-1 laHiqv">
                        <h2>공지사항 -수정 페이지📝</h2>
                    </div>
               
                    <c:forEach items="${notList}" var="notice" step="1">
                     <c:if test="${empty notList }">
                    <p>등록된 공지사항이 없습니다.</p>
                    </c:if>
             
                <ul id="nList">
                        <li>
                    <button type="button" class="ServiceItemstyle__ContainerBtn-sc-1omzxdj-0 hziaxr" id = 'btn' onclick='dis(this)'>
                        <p>${notice.gubun }</p>
                        <div class="ServiceItemstyle__CenterBox-sc-1omzxdj-1 iUcEVv">
                            <p>${notice.ntitle }</p>
                            <p>${notice.nregdate }</p>
                        </div>
                        
                        <span style="box-sizing:border-box;display:inline-block;overflow:hidden;width:initial;height:initial;background:none;opacity:1;border:0;margin:0;padding:0;position:relative;max-width:100%">
                            <span>
                                <i class="fa-solid fa-plus " style="color: #4f6996; box-sizing:border-box;display:inline-block;overflow:hidden;width:initial;height:initial;background:none;opacity:1;border:0;margin:0;padding:10;position:relative;max-width:100%; transform: translateY(-3px);"></i>
                            </span>
                        </span>
                    </button>
                    
                    <div class="ServiceItemstyle__ContentsBox-sc-1omzxdj-2 fEPIbI show" >
                    <h6> 수정하실 내용을 작성해주세요!  </h6>
                       <ul>
                <li>
	  				 <label for="writer" class="form-label">작성자</label>
	 				 <input type="text" class="form-control" id="writer" name ="writer" value = "${notice.nwriter}" readonly="readonly"></input>
				</li>
             	 <li>    
	 				 <label for="ntitle" class="form-label">제목</label>
	 				 <input type="text" class="form-control"  id="ntitle"  name ="ntitle" value = "${notice.ntitle }"></input>
				</li>
				
				<li>
	  				<label for="ncontent" class="form-label">내용</label>
	  				<textarea class="form-control" id="ncontent" name = "ncontent" rows="3">${notice.ncontent}</textarea>
			   </li>
			
		<%-- 		<li>
				 <label for="ntitle" class="form-label">구분</label>
				        <select class="form-select" id="gubun" name='gubun'> 
				          <option selected value="선택입력">${notice.gubun }</option>
				          <option value="선택입력">선택입력</option>
				          <option value="일반">일반</option>
				          <option value="이벤트">이벤트</option>
				          <option value="자주 묻는 질문">자주 묻는 질문</option>
				        </select>
				</li> --%>
			 		<div class="d-grid gap-2 d-md-flex justify-content-md-center">
                        <button type='button' class="btn btn-primary" id="btnEdit">완료 </button>
                        <button type='reset' class="btn btn-outline-primary" id="btnDel"> 초기화 </button>
                        </div>
                       </ul>
                    </div>
               		  </li>
                </ul>
                </c:forEach>     
                </section>
</form>
                
 <!--  페이지 블럭 생성 -->
            <div class ="div d-md-flex justify-content-md-center">
		<c:set var="pageDtoN" value="${pageDtoN}"/>
		
		<!-- 이전버튼 -->
		<c:if test="${pageDtoN.prev }">
			<input type='button' value='이전' onclick='goNotice(${pageDtoN.startNo-1})' class="btn">
		</c:if>
		
		<!-- 페이지번호 출력 -->
		<c:forEach begin="${pageDtoN.startNo}" end="${pageDtoN.endNo }" var="i">
			<input type='button' value='${i}' onclick='goNotice(${i})' class="btn" >
		</c:forEach>
		
		<!-- 다음버튼 -->
		<c:if test="${pageDtoN.next }">
			<input type='button' value='다음' onclick='goNotice(${pageDtoN.endNo+1})' class="btn">		
		</c:if>
		</div>
                

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
                
</body>
</html>