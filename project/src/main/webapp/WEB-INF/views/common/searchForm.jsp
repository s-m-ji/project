<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>searchForm.jsp</title>
<!-- 다중 셀렉스 테스트 -->
<script type="text/javascript">
	$(function() {
		// 질문유형을 선택한다.
		type = $('#c1').val();
		select = $('#c2').val();

		//chnQnaType('1' , '11');
		chnQnaType(type, select);
	});

	function chnQnaType(type, select) {

		$('#c2').empty();
		$('#c2').append('<option value="" >카테고리2 선택</option>');

		if (type == '1') {
			$('#c2')
					.append(
							"<option value='11'  ${ param.c2 eq '11' ? 'selected' : '' } >국/탕</option>'");
			$('#c2')
					.append(
							"<option value='12'  ${ param.c2 eq '12' ? 'selected' : '' } >면</option>'");
			$('#c2')
					.append(
							"<option value='13'  ${ param.c2 eq '13' ? 'selected' : '' } >밥/죽</option>'");
		} else if (type == '2') {
			$('#c2')
					.append(
							"<option value='21'  ${ param.c2 eq '21' ? 'selected' : '' } >육류</option>'");
			$('#c2')
					.append(
							"<option value='22'  ${ param.c2 eq '22' ? 'selected' : '' } >해물류</option>'");
			$('#c2')
					.append(
							"<option value='23'  ${ param.c2 eq '23' ? 'selected' : '' } >과일류</option>'");
		} else if (type == '3') {
			$('#c2')
					.append(
							"<option value='31'  ${ param.c2 eq '31' ? 'selected' : '' } >안주</option>'");
			$('#c2')
					.append(
							"<option value='32'  ${ param.c2 eq '32' ? 'selected' : '' } >도시락</option>'");
			$('#c2')
					.append(
							"<option value='33'  ${ param.c2 eq '33' ? 'selected' : '' } >간식</option>'");
		}
		document.getElementById("c2").style.display = "";

		if ($.trim(select) != "") {
			$('#c1').val(type);
			$('#c2').val(select);
		}
	}
</script>
</head>
<body>
	<%-- pDto.cri.sWord : ${pDto.cri.sWord } 이렇게 클래스 내에 선언한 필드명 그대로 소문자 s라고 썼더니 안 나옴 그런 속성을 찾을 수 없다고함... 엉엉 --%>
	<form action="./list_test" name="searchForm">
		<div class="container text-center">
			<div class="row">
				<div class="col">
					<select name="c1" id="c1"
						onChange="chnQnaType(this.value)">
						<option value="">카테고리1 선택</option>
						<option value="1" ${ param.c1 eq '1' ? "selected" : "" }>종류별</option>
						<option value="2" ${ param.c1 eq '2' ? "selected" : "" }>재료별</option>
						<option value="3" ${ param.c1 eq '3' ? "selected" : "" }>상황별</option>
					</select>
				</div>
				<div class="col">
					<select id="c2" name="c2"></select>
				</div>
				<div class="col">
					<input type="text" name="sWord" class="form-control"
						value="${pDto.cri.SWord}" placeholder="검색어">
				</div>
				<div class="col">
					<button type="submit" class="btn btn-primary mb-3" onclick="go(1);">검색</button>
				</div>
			</div>
		</div>
		<div class="container text-center">
			<div class="row">
				<div class="col">
					pDto.cri.pageNo : <input type="text" name="pageNo"
						value="${pDto.cri.pageNo}">
				</div>
				<div class="col">
					param.b_no : <input type="text" name="b_no" value="${param.b_no}">
				</div>
				<div class="col">
					<select class="form-control" name="amount"
						onchange="changePageSize(this.value)">
						<option value="10" ${ param.amount eq '10' ? "selected" : "" }>10개씩
							보기</option>
						<option value="20" ${ param.amount eq '20' ? "selected" : "" }>20개씩
							보기</option>
						<option value="30" ${ param.amount eq '30' ? "selected" : "" }>30개씩
							보기</option>
					</select>
				</div>
				
			</div>
		</div>
	</form>
</body>
</html>