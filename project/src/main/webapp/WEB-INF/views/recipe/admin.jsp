<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 회원 관리</title>

<script src="/resources/assets/js/jquery-3.7.0.js"></script>
<!-- 부트스트랩을 사용하기 위해서 css, js를 추가 합니다. -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

	<!--  notice의 css   ** recipe_css 로 -->
 	<link rel="stylesheet" type="text/css" href="../resources/recipe_css/notice.css">
    
<script type="text/javascript">
// 선택박스 전체 선택
function toggleCheckboxes() {
    var adminChkBox = document.getElementById('adminChkBox');
    var isChecked = adminChkBox.checked;

    var chkBox = document.getElementsByClassName('chkBox');
    
    var delNmnos = document.getElementsByClassName('delNmno');
	var delYmnos = document.getElementsByClassName('delYmno');
	
	console.log(delNmnos);
	console.log(delYmnos);
	
    for (var i = 0; i < chkBox.length; i++) {
       chkBox[i].checked = isChecked;
    }
  }
  
//페이지 번호를 받아서 페이지를 호출 해주는 함수 
	function goAdmin(page){
		document.searchForm.pageNo.value=page;
		document.searchForm.submit();
	}
	function inputBtnOnclick() {
		location.href = "/recipe/adminInput";
	}
</script>  
 <%@ include file="../common/header.jsp" %>  

</head>
<body>

<!--  검색폼 (회원명, 회원등급명, 탈퇴신청여부)  -->
<form name ="searchForm" method ="get" action="/recipe/admin" >

	<input type="text" name ='pageNo' value ="${pageDto.cri.pageNo}"></input>
	
	<table border ='1' width ="100%" class = "formtable">
		<tr>
		<td align = "center" class = "formtd">
			<select name ="sField">
				<option value = "name"${pageDtoA.cri.SField eq "name" ? "selected" : ""}>회원명</option>
				<option value = "grade"${pageDtoA.cri.SField eq "grade" ? "selected" : ""}>회원등급명</option>
				<option value = "delYN"${pageDtoA.cri.SField eq "delYN" ? "selected" : ""}>탈퇴신청여부</option>
			</select>
			
			<input type="text" name = "sWord" value = "${pageDtoA.cri.SWord}" ></input>
			<input type ="submit" value ="검색하기">
		</td>
		</tr>
	</table>
</form> 	

<!-- 회원 목록 조회 및 삭제 기능 --> 
<p> 총 <b>${totalCnt}</b>개🪐</p>
<div class="list-group w-auto">
<div class="panel-body">
<form action = "/recipe/delMem" method="post">
<input type="submit" id = "deleteBtn"  value="회원 탈퇴">
<input type="button" id = "inputBtn"  value="회원 등록" onclick="inputBtnOnclick()" >
<table width = "100%"  class="table table-striped table-bordered table-hover" id="dataTables-example">

	<thead>
		<tr>
			<th><input id="adminChkBox" type="checkbox" onclick="toggleCheckboxes()"></th>
			<th>#</th>
			<th>이메일</th>
			<th>이름</th>
			<th>닉네임</th>
			<th>전화번호</th>
			<th>가입일</th>
			<th>회원등급</th>
			<th>탈퇴신청여부</th>
		</tr>
	</thead>
	  <!--  회원 목록 출력하기  -->
  <c:forEach items="${list}" var = "member" step="1">
		<c:if test="${empty list}">
		<tr>
			<td colspan = "8" align = "center"> 등록된 회원 목록이 없습니다.</td>
		</tr>
		</c:if>
		<c:if test="${not empty list}">
                <tbody>
                    <tr>
                       <td class = "center">
					 <!--  삭제용 체크 박스 -->
					<div><input type = "checkbox" name = "delMno" class = "chkBox" value = "${member.mno}"></input></div>
						</td>
                       <td>${member.mno}</td>
                        <td>${member.email}</td>
                        <td>${member.name}</td>
                        <td>${member.nickname}</td>
                        <td>${member.pnum}</td>
                        <td>${member.reg_dateStr}</td> 
                        <td>${member.grade}</td>
                        <td>${member.delYNStr}</td>
                    </tr>
                </tbody>
                </c:if>
                </c:forEach>
            </table>
            </form>
	</div>
</div>

<!--  페이지 블럭 생성 -->
            <div class ="div d-md-flex justify-content-md-center">
		<c:set var="pageDtoA" value="${pageDtoA}"/>
		
		<!-- 이전버튼 -->
		<c:if test="${pageDtoA.prev}">
			<input type='button' value='이전' onclick='goAdmin(${pageDtoA.startNo-1})' class="btn">
		</c:if>
		
		<!-- 페이지번호 출력 -->
		<c:forEach begin="${pageDtoA.startNo }" end="${pageDtoA.endNo }" var="i">
			<input type='button' value='${i}' onclick='goAdmin(${i})' class="btn" >
		</c:forEach>
		
		<!-- 다음버튼 -->
		<c:if test="${pageDtoA.next}">
			<input type='button' value='다음' onclick='goAdmin(${pageDtoA.endNo+1})' class="btn">		
		</c:if>
		</div>
		
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
   

 </body>
 </html>
