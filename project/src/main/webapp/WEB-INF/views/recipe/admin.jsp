<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 회원 관리</title>
    <!-- Header -->
	<%@ include file="../common/header.jsp" %>

<!--  admin (지수) css -->
  <style>
  .memImgDiv{
    padding: 10px;
  }
  .memImg{
    border: 1px solid rgb(255, 255, 255);
    border-radius: 50%;
  }
  .memInfo{
    padding-top: 0px;
    padding-left: 10px;
  }
  #memInputBtn{
  	display: flex;
  	align-items: center;
  }
  #memInputBtn input[type='button'], #memInputBtn input[type='submit']{
    border: none;
    background-color: #f7863b3f;
    border-radius: 3px ;
    padding: 7px;
    font-size: small;
  }
  #memInputBtn input[type='button']:hover, #memInputBtn input[type='submit']:hover{
    border: none;
    background-color: #f79e62;
    border-radius: 3px ;
    padding: 7px;
    font-size: small;
  }
  .memName{
    padding: 10px;
    font-size: 1.2em;
  }
  .memName .d-block{
    padding-top: 5px;
  }
  .checkboxLine{
    padding-top: 10px;
  }
  .searchBox{
  	display: flex;
  	padding-left: 370px;
  	margin-top: 50px;
  }
  .searchField{
  	width: 200px;
  	margin-right: 10px;
  }
  .searchText{
  	color: white;
  }
  
</style>
<script src="/resources/assets/js/jquery-3.7.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

<script type="text/javascript">
window.addEventListener("load", function(){
	console.log("-------------- adminFileList 연결 완료! ----------------");
		getAmindFileList();

		// ▶ 파일 목록 요청
		function getAmindFileList(){
			fetch('/recipe/adminList')
				.then(response => response.json())
				.then(map => adminFileList(map));
		}

		// ▶ 파일 목록 조회 
		function adminFileList(map) {
		    let fileList = map.FileList; // 파일 목록 배열 저장
		    let fileDivs = document.querySelectorAll(".fileDiv"); // 모든 fileDiv 태그 선택

		    fileDivs.forEach(function (fileDiv) {
		        let inputElement = fileDiv.querySelector("input[name='mno']");
		        if (inputElement !== null) {
		            let mnoValue = inputElement.value;
		            let matchingFile = fileList.find(item => item.mno === parseInt(mnoValue));
		            if (matchingFile) {
		                let savePath = encodeURIComponent(matchingFile.savePath); // 원본 파일
		                let imageTag = "<img src='/recipe/displayAdmin?filename=" + savePath + "' alt='회원 사진 " + matchingFile.mno + "'  style='width: 100px; height: 100px;'class='memImg'>";
		                fileDiv.innerHTML = imageTag; // 해당 fileDiv 태그에 이미지 추가
		            } else {
		                fileDiv.innerHTML = '<mark>회원사진 미등록</mark>';
		            }
		        } else {
		            console.log("input[name='mno']가 없는 fileDiv가 있습니다.");
		        }
		    });
		}
	});

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

</head>
<body>
<!-- Main -->
<section id="main">
	<div class="container">
	
<!--  검색폼 (회원명, 회원등급명, 탈퇴신청여부)  -->
<form name ="searchForm" method ="get" action="/recipe/admin" >

	<input type="hidden" name ='pageNo' value ="${pageDtoA.cri.pageNo}"></input>
	
	<table border ='1' width ="100%" class = "formtable">
		<tr>
		<td align = "center" class = "formtd searchBox">
			<select name ="sField" class="searchField">
				<option value="">전체</option>
				<option value = "name"${pageDtoA.cri.SField eq "name" ? "selected" : ""}>회원명</option>
				<option value = "grade"${pageDtoA.cri.SField eq "grade" ? "selected" : ""}>회원등급명</option>
				<option value = "delYN"${pageDtoA.cri.SField eq "delYN" ? "selected" : ""}>탈퇴신청여부</option>
			</select>
			
			<input type="text" name = "sWord" value = "${pageDtoA.cri.SWord}" style="width: 200px; margin-right: 10px;"></input>
			<input type ="submit" value ="검색하기" class="searchText" style="font-weight:300;">
		</td>
		</tr>
	</table>
</form> 	

<!-- 회원 목록 조회 및 삭제 기능 --> 
<div style="padding-left: 1111px;">
<p> with💕<b>${totalCnt}</b>명의 회원💕</p>
</div>
  <div class="my-3 p-3 bg-body rounded shadow-sm">
    <h6 class="border-bottom pb-2 mb-0">
    </h6>
    <h6 class="border-bottom pb-2 mb-0 checkboxLine">
      <form action = "/recipe/delMem" method="post">
        <div id='memInputBtn'>
            <input type="checkbox" class="form-check-input" id="adminChkBox" onclick='toggleCheckboxes()' style="margin-right: 10px;">
            <label class="form-check-label" for="same-address"></label>
          <input type='button' id='deleteBtn' value='회원등록'onclick='inputBtnOnclick()' style="margin-right: 6px;" >
          <input type='submit' id='inputBtn' value='회원탈퇴'  >
        </div>
      </h6>

      <c:forEach items="${list}" var = "member" step="1">
        <c:if test="${empty list}">
          <div class="d-flex text-muted pt-3">
            등록된 회원 목록이 없습니다.
          </div>
        </c:if>

        <c:if test="${not empty list}">
    <div class="d-flex text-muted pt-3">
      <div class="form-check">
        <!-- 삭제용 체크 박스 -->
        <input type="checkbox" name='delMno' class="form-check-input chkBox" value='${member.mno}'>
        <label class="form-check-label" for="same-address"></label>
      </div>
      <div class='memImgDiv'>
        <div class="fileDiv">
          <input id="mno" class='memImg' type="text" name="mno" value="${member.mno}" placeholder="추후 hidden처리" class='memImg' >
          </div>
<!--       <img src='../modals/image/pic01.jpg' width='100px' height='100px' class='memImg'> -->
    </div>
      <div class="pb-3 mb-0 small lh-sm border-bottom w-100">

        <div class='memName'>
        <strong class="text-gray-dark" style='color: #F7863B;'>${member.nickname}</strong>
        <span class="d-block">${member.name}</span>
      </div>

   <div class='memInfo'>
        <i class="fa-solid fa-envelope"> ${member.email}</i>
       　<i class="fa-solid fa-phone"> ${member.pnum}</i>
       　<i class="fa-solid fa-calendar"> ${member.reg_dateStr}</i>
        <br>
        <i class="fa-solid fa-award"> ${member.grade}</i>
        　<i class="fa-solid fa-user-xmark"> ${member.delYNStr}</i>
      </div>

      </div>
    </div>
  </c:if>
  </c:forEach>
  </div>
</form>


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
	</div>
</section>
<!-- Footer -->
	<%@ include file="../common/footer.jsp" %>
