<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- 부트스트랩을 사용하기 위해서 css, js를 추가 합니다. -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script type="text/javascript">

//페이지 번호를 받아서 페이지를 호출 해주는 함수 
function go(page){
	document.searchForm.pageNo.value=page;
	document.searchForm.submit();
}

</script>
</head>
<body>
<!--  공지사항 테이블 조회 o / 등록 버튼 o/ 수정, 삭제 / 공지사항 등록 페이지o / -등록시키기o (구분 option)  -->
<!--  공지사항 목록 테이블o  -->
<!--  공지사항 등록 버튼 클릭시 o> 글쓰기 화면 제공o -->
<!--  공지사항 등록 성공 시, admin.jsp로 이동  -->

<h3> 공지관리</h3>

<!--  검색 폼 -->
<div class="list-group w-auto">
<form name ="searchForm" method ="get" action="/recipe/notice"  class="row g-3 justify-content-center">

<input type="text" name ='pageNo' value ="${pageDto.cri.pageNo}"></input>

  <div class="col-sm-2">
			<select name ="sField" class="form-select" aria-label="Default select example">
				<option value="">전체</option>
				<option value = "1"${pageDto.cri.SField eq "1" ? "selected" : ""}>일반</option>
				<option value = "2"${pageDto.cri.SField eq "2" ? "selected" : ""}>이벤트</option>
				<option value = "3"${pageDto.cri.SField eq "3" ? "selected" : ""}>자주 묻는 질문</option>
			</select>
	</div>
 <%--  <div class="col-sm-3">
			<input type="text"  class="form-control" name = "sWord" value = "${pageDto.cri.SWord}" ></input>
  </div> --%>
  <div class="col-auto">
    <button type="submit" class="btn btn-primary mb-3">검색하기</button>
    </div>
    <div class='col-auto'> 
    </div>
</form> 	
</div>

<!--  공지 목록 -->
<p> 총 <b>${totalNcnt}</b>개🪐</p>
<div class="list-group w-auto">
<div class="panel-body">
<table width = "100%"  class="table table-striped table-bordered table-hover" id="dataTables-example">
	<thead>
		<tr>
			<th>No.</th>
			<th>구분</th>
			<th>제목</th>
			<th>내용</th>
			<th>작성자</th>
			<th>등록일</th>
			<th> 관리 </th>
		</tr>
	</thead>

<c:forEach items="${notList}" var="notice" step="1">
	<c:if test="${empty notList}">
		<tr>
			<td colspan = "7" align = "center"> 등록된 공지사항이 없습니다.</td>
		</tr>
	</c:if>
	<c:if test="${not empty notList}">
		<tbody>
			<tr>
				<td>${notice.nno}</td>
				<td>${notice.gubun}</td>
				<td>${notice.ntitle}</td>
				<td>${notice.ncontent}</td>
				<td>${notice.nwriter}</td>
				<td>${notice.nregdate}</td>
				<td><button type="button" class="btn btn-outline-primary">수정</button>
					<button type="button" class="btn btn-outline-danger">삭제</button>
				</td>
			</tr>
		</tbody>
	</c:if>
</c:forEach>
</table>
</div>
</div>

 <!--  페이지 블럭 생성 -->
            <div class ="div d-md-flex justify-content-md-center">
		<c:set var="pageDto" value="${pageDto}"/>
		
		<!-- 이전버튼 -->
		<c:if test="${pageDto.prev }">
			<input type='button' value='이전' onclick='go(${pageDto.startNo-1})' class="btn">
		</c:if>
		
		<!-- 페이지번호 출력 -->
		<c:forEach begin="${pageDto.startNo }" end="${pageDto.endNo }" var="i">
			<input type='button' value='${i }' onclick='go(${i})' class="btn" >
		</c:forEach>
		
		<!-- 다음버튼 -->
		<c:if test="${pageDto.next }">
			<input type='button' value='다음' onclick='go(${pageDto.endNo+1})' class="btn">		
		</c:if>
		</div>
 
  <!-- 공지 등록 버튼 ver2 -->
<c:set  value="${notList}" var="notice"></c:set>  
  <div class="dropdown d-md-flex justify-content-md-e">
    <button type="button" class="btn btn-outline-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false" data-bs-auto-close="outside">
      공지 등록✍🏻
    </button>

    <input type="hidden" class="form-control" id="nno" name ="nno" placeholder="공지번호" >
    <form class="dropdown-menu p-4" action="/recipe/writeAction" method="post" accept-charset="UTF-8">
      
      <div class="input-group mb-3">
        <span class="input-group-text" id="basic-addon1">작성자</span>
        <input type="text" class="form-control" id="nwriter" name ="nwriter">
      </div>
  
      <div class="input-group mb-3">
        <label class="input-group-text" for="gubun">  구분　</label>
        <select class="form-select" id="gubun" name='gubun'>
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
        <textarea class="form-control" id="ncontent" name = "ncontent" rows="3" placeholder='공지 내용을 입력해주세요' required ></textarea>
      </div>
  <br>
      <div class="mb-3 d-md-flex justify-content-md-center" >
        <button type="submit" class="btn btn-secondary">등록하기</button>
      </div>
    </form>
  </div>
 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
  
</body>
</html>