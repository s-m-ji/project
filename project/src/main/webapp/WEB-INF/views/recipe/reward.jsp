<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

</head>
<body>

<div class="duration">
    <span>기간</span>
 <input type="date" id="startDate" name="startDate"/>
<input type="date" id="endDate" name="endDate" />
<input type="button" id="btnDate" onclick="btnDateAction()" value="조회">
<table>
<thead>
<tr>			
			<th>회원번호</th>
			<th>이름</th>
			<th>닉네임</th>
			<th>게시물등록일</th>
			<th>조회수</th>
			<th>회원등급</th>
			<th>기본혜택</th>
		</tr>
	</thead>
	  <!--  회원 목록 출력하기  -->
  <c:forEach items="${rewardList}" var = "rewardList" step="1">
		<c:if test="${empty rewardList}">
		<tr>
			<td colspan = "8" align = "center"> 등록된 회원 목록이 없습니다.</td>
		</tr>
		</c:if>
		<c:if test="${not empty rewardList}">
                <tbody>
                    <tr>
                       <td>${rewardList.mno}</td>
                        <td>${rewardList.name}</td>
                        <td>${rewardList.nickname}</td>
                        <td>${rewardList.regdate}</td>
                        <td>${rewardList.viewcnt}</td>
                        <td>${rewardList.grade}</td> 
                        <td>${rewardList.benefit}</td>
                    </tr>
                </tbody>
                </c:if>
                </c:forEach>
            </table>
   
	</div>

<!--  테이블 목록 (ajax) -->



<!-- 
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<script>
$(function () {
    $('#startDate').daterangepicker({
        "singleDatePicker": true, // 단일 날짜 선택
        "locale": {
            "format": "YYYY-MM-DD",
            "applyLabel": "확인",
            "cancelLabel": "취소",
            "weekLabel": "W",
            "daysOfWeek": ["월", "화", "수", "목", "금", "토", "일"],
            "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            "firstDay": 1
        },
        "startDate": $('input[name="startDate"]').val(),
        "drops": "down"
    }, function (start, end, label) {
        $('input[name = "startDate"]').val(start.format("YYYY-MM-DD"));
        console.log('New date selected: ' + start.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
    });
	/* $('#startDate').daterangepicker("setDate", new Date()); */
    
    $('#endDate').daterangepicker({
        "singleDatePicker": true, // 단일 날짜 선택
        "locale": {
            "format": "YYYY-MM-DD",
            "applyLabel": "확인",
            "cancelLabel": "취소",
            "weekLabel": "W",
            "daysOfWeek": ["월", "화", "수", "목", "금", "토", "일"],
            "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            "firstDay": 1
        },
        "endDate": $('input[name="endDate"]').val(),
        "drops": "down"
    }, function (start, end, label) {
        $('input[name = "endDate"]').val(start.format("YYYY-MM-DD"));
        console.log('New date selected: ' + start.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
    });
});
 -->

</script>
</body>
</html>
