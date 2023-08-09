<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>searchForm.jsp</title>
</head>
<body>
	<form action="./com_list" name="searchForm">
		<!-- view.jsp를 위한 게시글 번호 -->
		<input type="text" name="b_no" value="${param.b_no}" placeholder="param.b_no -> 추후  hidden 처리">
		<div class="container text-center">
			<div class="d-flex justify-content-between">
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
						<option value="10" ${ param.amount eq '10' ? "selected" : "" }>10개씩
							보기  </option>
						<option value="30" ${ param.amount eq '30' ? "selected" : "" }>30개씩
							보기</option>
						<option value="50" ${ param.amount eq '50' ? "selected" : "" }>50개씩
							보기</option>
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
										 개의 재밌는 이야기가 있습니다.</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="p-2">
					<button type="button" id="orderByRG" class="btn btn-success" onclick="changeOrderBy(true)">최신순</button>
				    <button type="button" id="orderByBU" class="btn btn-success" onclick="changeOrderBy(false)">추천순</button>
				    <input type="hidden" id="orderByInput" name="orderByCom" value="true">
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