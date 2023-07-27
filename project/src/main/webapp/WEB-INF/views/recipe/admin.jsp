<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<script src="/resources/assets/js/jquery-3.7.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var delNmnos = $('#delNmnosInput').val();
		var delYmnos = $('#delYmnosInput').val();
		console.log(delNmnos);
		console.log(delYmnos);
		
		var delBtnClicked = false; // 삭제 버튼을 눌렀는지 저장하는 변수 
		
		 $('#deleteBtn').click(function(){
			 delBtnClicked=true;  // 삭제 버튼 클릭 시 이벤트 처리 
		if(delNmnos && delBtnClicked){
			alert("탈퇴 미신청 회원입니다. 삭제할 수 없습니다." + delNmnos);
			console.log(delNmnos);
			console.log(delYmnos);
		}else if(delYmnos && delBtnClicked){
			alert("탈퇴 신청 회원입니다." + delYmnos);
		}else{
			alert("존재하지 않는 회원입니다.");
		}
	     });
		
	});
	
	// 전체 체크박스 선택/해제 
	function toggleCheckboxes() {
    var adminChkBox = document.getElementById('adminChkBox');
    var isChecked = adminChkBox.checked;

    var chkBox = document.getElementsByClassName('chkBox');

    for (var i = 0; i < chkBox.length; i++) {
       chkBox[i].checked = isChecked;
    }
  }
</script>
</head>
<body>

<form action = "/recipe/delMem" method="post">
<input type = "text" id="delNmnosInput" value= ${param.delNmnos }>
<input type = "text" id="delYmnosInput" value= ${param.delYmnos }>


	<!-- 탈퇴 삭제 버튼 -->
<input type="submit" id = "deleteBtn" value="회원 탈퇴">
<table border="1">
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
					<input type = "checkbox" name = "delMno" class = "chkBox" value = "${member.mno}"></input>
						</td>
                       <td>${member.mno}</td>
                        <td>${member.email }</td>
                        <td>${member.name}</td>
                        <td>${member.nickname }</td>
                        <td>${member.pnum }</td>
                        <td>${member.reg_dateStr }</td> 
                        <td>${member.grade }</td>
                        <td>${member.delYNStr }</td>
                    </tr>
                </tbody>
                </c:if>
                </c:forEach>
            </table>
		
</form>
</body>
</html>