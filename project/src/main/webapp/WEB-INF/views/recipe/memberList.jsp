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
  
  alert("${param.message}");
  
</script>
</head>
<body>

<form action = "/recipe/delMem" method="post">
	<!-- 탈퇴 삭제 버튼 -->
<input type="submit" id = "deleteBtn"  value="회원 탈퇴">
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