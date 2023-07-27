<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>searchForm.jsp</title>
</head>
<body>
<%-- pDto.cri.sWord : ${pDto.cri.sWord } 이렇게 클래스 내에 선언한 필드명 그대로 소문자 s라고 썼더니 안 나옴 그런 속성을 찾을 수 없다고함... 엉엉 --%>
	<form action="./list_test" name="searchForm">
		<div class="row g-3 justify-content-center">
		  <div class="col-auto">
		    <!-- 카테고리 종류별 -->
		    <%-- <select name="sField" class="form-select" aria-label="Default select example">
			  <option value="종류별" >종류별</option>
			  <option value="간식" ${pDto.cri.SField eq '간식'? 'selected' : '' }>간식</option>
			  <option value="밥" ${pDto.cri.SField eq '밥'? 'selected' : '' }>밥</option>
			  <option value="면" ${pDto.cri.SField eq '밥'? 'selected' : '' }>면</option>
			</select> --%>
		  <!-- 카테고리 재료별 -->
		    <%-- <select name="sField" class="form-select" aria-label="Default select example">
			  <option value="재료별" >재료별</option>
			  <option value="과일류" ${pDto.cri.SField eq '과일류'? 'selected' : '' }>과일류</option>
			  <option value="달걀/유제품" ${pDto.cri.SField eq '달걀/유제품'? 'selected' : '' }>달걀/유제품</option>
			  <option value="육류" ${pDto.cri.SField eq '육류'? 'selected' : '' }>육류</option>
			</select> --%>
			<select name="sField" class="form-select" aria-label="Default select example">
			  <option value="cateName" >재료명</option>
			 </select>
		  </div>
		  <div class="col-sm-6">
		    <input type="text" name="sWord" class="form-control" value="${pDto.cri.SWord}" placeholder="검색어">
		  </div>
		  <div class="col-auto">
		    <button type="submit" class="btn btn-primary mb-3" onclick="go(1);">검색</button>
			<input type="text" name="pageNo" value="${pDto.cri.pageNo}">
			<input type="text" name="bno" value="">
			<!-- <input type="text" name="pageNo" value="1"> -->
		  </div>
		 </div>
	</form>
</body>
</html>