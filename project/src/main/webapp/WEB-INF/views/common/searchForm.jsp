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
		type = $('#c1').val();
		select = $('#c2').val();

		chnQnaType(type, select);
	});

	function chnQnaType(type, select) {

		$('#c2').empty();
		$('#c2').append('<option value="" >카테고리2 선택</option>');

		if (type == '1') {
			$('#c2').append("<option value='11'  ${ param.c2 eq '11' ? 'selected' : '' } >국/탕/찌개</option>'");
			$('#c2').append("<option value='12'  ${ param.c2 eq '12' ? 'selected' : '' } >면/국수/파스타</option>'");
			$('#c2').append("<option value='13'  ${ param.c2 eq '13' ? 'selected' : '' } >밥/죽</option>'");
			$('#c2').append("<option value='14'  ${ param.c2 eq '14' ? 'selected' : '' } >빵/떡</option>'");
			$('#c2').append("<option value='15'  ${ param.c2 eq '15' ? 'selected' : '' } >반찬</option>'");
			$('#c2').append("<option value='16'  ${ param.c2 eq '16' ? 'selected' : '' } >샐러드</option>'");
			$('#c2').append("<option value='17'  ${ param.c2 eq '17' ? 'selected' : '' } >소스</option>'");
			$('#c2').append("<option value='18'  ${ param.c2 eq '18' ? 'selected' : '' } >차/음료/술</option>'");
		} else if (type == '2') {
			$('#c2').append("<option value='21'  ${ param.c2 eq '21' ? 'selected' : '' } >육류</option>'");
			$('#c2').append("<option value='22'  ${ param.c2 eq '22' ? 'selected' : '' } >해물류</option>'");
			$('#c2').append("<option value='23'  ${ param.c2 eq '23' ? 'selected' : '' } >과일류</option>'");
			$('#c2').append("<option value='24'  ${ param.c2 eq '24' ? 'selected' : '' } >달걀/유제품</option>'");
			$('#c2').append("<option value='25'  ${ param.c2 eq '25' ? 'selected' : '' } >채소류</option>'");
			$('#c2').append("<option value='26'  ${ param.c2 eq '26' ? 'selected' : '' } >견과류</option>'");
			$('#c2').append("<option value='27'  ${ param.c2 eq '27' ? 'selected' : '' } >쌀/밀가루</option>'");
		} else if (type == '3') {
			$('#c2').append("<option value='31'  ${ param.c2 eq '31' ? 'selected' : '' } >간식</option>'");
			$('#c2').append("<option value='32'  ${ param.c2 eq '32' ? 'selected' : '' } >안주</option>'");
			$('#c2').append("<option value='33'  ${ param.c2 eq '33' ? 'selected' : '' } >파티</option>'");
			$('#c2').append("<option value='34'  ${ param.c2 eq '34' ? 'selected' : '' } >캠핑</option>'");
			$('#c2').append("<option value='35'  ${ param.c2 eq '35' ? 'selected' : '' } >도시락</option>'");
			$('#c2').append("<option value='36'  ${ param.c2 eq '36' ? 'selected' : '' } >이유식</option>'");
			$('#c2').append("<option value='37'  ${ param.c2 eq '37' ? 'selected' : '' } >초스피드</option>'");
		} else if (type == '4') {
			$('#c2').append("<option value='41'  ${ param.c2 eq '41' ? 'selected' : '' } >볶음</option>'");
			$('#c2').append("<option value='42'  ${ param.c2 eq '42' ? 'selected' : '' } >조림</option>'");
			$('#c2').append("<option value='43'  ${ param.c2 eq '43' ? 'selected' : '' } >비빔</option>'");
			$('#c2').append("<option value='44'  ${ param.c2 eq '44' ? 'selected' : '' } >절임</option>'");
			$('#c2').append("<option value='45'  ${ param.c2 eq '45' ? 'selected' : '' } >튀김</option>'");
			$('#c2').append("<option value='46'  ${ param.c2 eq '46' ? 'selected' : '' } >삶기</option>'");
			$('#c2').append("<option value='47'  ${ param.c2 eq '47' ? 'selected' : '' } >굽기</option>'");
			$('#c2').append("<option value='48'  ${ param.c2 eq '48' ? 'selected' : '' } >끓이기</option>'");
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
		<!-- view.jsp를 위한 게시글 번호 -->
		<input type="text" name="b_no" value="${param.b_no}" placeholder="param.b_no -> 추후  hidden 처리">
		<div class="container text-center">
			<div class="d-flex justify-content-between">
				<div class="p-2 flex-fill" >
					<select name="c1" id="c1"
						onChange="chnQnaType(this.value)">
						<option value="">카테고리1 선택</option>
						<option value="1" ${ param.c1 eq '1' ? "selected" : "" }>종류별</option>
						<option value="2" ${ param.c1 eq '2' ? "selected" : "" }>재료별</option>
						<option value="3" ${ param.c1 eq '3' ? "selected" : "" }>상황별</option>
						<option value="4" ${ param.c1 eq '4' ? "selected" : "" }>방법별</option>
					</select>
				</div>
				<div class="p-2 flex-fill">
					<select id="c2" name="c2"></select>
				</div>
				<div class="p-2 flex-fill">
					<input type="text" name="sWord" class="form-control" value="${pDto.cri.SWord}" placeholder="검색어">
				</div>
				<div class="p-2 ms-auto">
					<button type="submit" class="btn btn-primary mb-3" onclick="go(1);">검색</button>
				</div>
			</div>
		</div>
		<div class="container text-center">
			<input type="hidden" name="pageNo" value="${pDto.cri.pageNo}">
				<div class="d-flex justify-content-between listMenuBtm">
				<div class="p-2">
					<select class="form-control" name="amount"
						onchange="changePageSize(this.value)">
						<option value="10" ${ param.amount eq '10' ? "selected" : "" }>10개씩 보기  </option>
						<option value="25" ${ param.amount eq '25' ? "selected" : "" }>25개씩 보기</option>
						<option value="50" ${ param.amount eq '50' ? "selected" : "" }>50개씩 보기</option>
					</select>
				</div>
				<div class="p-2">
					<div id="gtco-counter" class="gtco-section">
						<div class="gtco-container">
							<div class="row">
								<div class=" animate-box" data-animate-effect="fadeInUp">
									<div class="feature-center">
									<p style="font-size:20px"> 총
										<span class="counter js-counter" data-from="0" data-to="${tCnt}" data-speed="1000" data-refresh-interval="50">1</span>
										 개의 맛있는  레시피가 있습니다.</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="p-2">
					<button type="button" id="orderByRG" class="btn btn-success" onclick="changeOrderBy(true)">최신순</button>
				    <button type="button" id="orderByBU" class="btn btn-success" onclick="changeOrderBy(false)">추천순</button>
				    <input type="hidden" id="orderByInput" name="orderBy" value="false">
				</div>
				</div>
				<!-- 최신/추천순 정렬 js -->
				<script type="text/javascript">
				    function changeOrderBy(orderByRegidateFlag) {
				        document.getElementById("orderByRG").disabled = orderByRegidateFlag;
				        document.getElementById("orderByBU").disabled = !orderByRegidateFlag;
				
				        // 버튼 클릭 시 orderBy 값 변경
				        document.getElementById("orderByInput").value = orderByRegidateFlag;
				
				        // 폼 제출 (페이지 새로고침)
				        document.searchForm.submit();
				    }
				</script>
		</div>
	</form>
</body>
</html>