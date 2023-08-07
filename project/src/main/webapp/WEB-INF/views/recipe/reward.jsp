<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>리워드관리</title>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<!-- 부트스트랩을 사용하기 위해서 css, js를 추가 합니다. -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

 	<!--  notice의 css   ** recipe_css 로 -->
 	<link rel="stylesheet" type="text/css" href="../resources/recipe_css/notice.css">
 	
<script type="text/javascript">
window.addEventListener('load', function(){
	
	btnDate.addEventListener('click', function(){
		getRewardList();
	})
	
	
});
//리스트 조회 
function getRewardList(){
	let startDate = document.querySelector("#startDate").value;
	let endDate = document.querySelector("#endDate").value;

	fetchGet('/recipe/reward/list/' + startDate + '/' + endDate, rewardView);

	console.log("startDate : ", startDate, "endDate", endDate);
/* 	.then(response => response.json())
	.then(map => rewardView(map)); */
}

// 리스트 조회-콜백함수 
function rewardView(map){
	let rewardList = map.rewardList;
	console.log("rewardView 함수  : ",rewardList);
	
	if(rewardList.length == 0){
		rewardDiv.innerHTML = '검색결과가 없습니다.';
	}else{
		let rewardDivStr = 
			'리워드목록'
		+ '  <table width = "100%"  class="table table-striped table-bordered table-hover" id="dataTables-example" border="1">'
		+ '<thead>'
		+'<tr>'
		+'<th>회원 번호</th>'
		+'<th>이름</th>'
        +'<th>닉네임</th>'
        +'<th>누적 조회수</th>'
        +'<th>게시글 등록일</th>'
        +'<th>회원 등급</th>'
        +'<th>등급 변경</th>'
        +'<th>혜택</th>'
		+'<tr>'
		+'</thead>'
		+'<tbody>';
		
		rewardList.forEach(reward => {
			rewardDivStr += 
				'<tr>'
				+'<td>'+reward.mno+'</td>'
				+'<td>'+reward.name+'</td>'
				+'<td>'+reward.nickname+'</td>'
				+'<td>'+reward.viewcnt+'</td>'
				+'<td>'+reward.regdate+'</td>'
				+'<td>'+reward.grade+'</td>'
				+'<td>'
				+'<select class="form-select" id="reward'+reward.mno+'" onchange="gradeUpdate(' + reward.mno +')">'
				+'<option selected>선택입력</option>'
				+'<option value="1" >cook Helper</option>'
				+'<option value="2">cook Manager</option>'
				+'<option value="3">sous chef</option>'
				+'<option value="4">head chef</option>'
				+'</select>'
				+'</td>'
				+'<td>'+reward.benefit+'</td>'
				+'</tr>';
		});
		rewardDivStr += '</tbody>'
			+'</table>';
		rewardDiv.innerHTML = rewardDivStr;
		
	}
}

// 리워드 수정 
function gradeUpdate(mno){
	let gno =  document.querySelector('#reward' + mno).value;
	let obj = {
			mno : mno
			, gno : gno
	}
	
	fetchPost('reward/gradeUpdateAction', obj, updateView);
	console.log("obj", obj);
	console.log("gno", gno);
}

function updateView(){
	getRewardList();
}


//get방식 요청
function fetchGet(url, callback){
	try{
		// url 요청
		fetch(url)
			// 요청결과 json문자열을 javascript 객체로 반환
			.then(response => response.json())
			// 콜백함수 실행
			.then(map => callback(map));			
	}catch(e){
		console.log('fetchGet',e);
	}
}

// post방식 요청
function fetchPost(url, obj, callback){
	try{
		// url 요청
		fetch(url
				, {
					method : 'post'
					, headers : {'Content-Type' : 'application/json'}
					, body : JSON.stringify(obj)
				})
			// 요청결과 json문자열을 javascript 객체로 반환
			.then(response => response.json())
			// 콜백함수 실행
			.then(map => callback(map));			
	}catch(e){
		console.log('fetchPost', e);
	}
}
 

</script>
</head>
<body>

<!--  검색 조건 -->
<div class="duration">

<input type="date" id="startDate" name="startDate"/>
<input type="date" id="endDate" name="endDate" />
<input type="button" id="btnDate" value="기간조회">
</div>

<div id = "rewardDiv">
</div>
  
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
 
</body>
</html>
