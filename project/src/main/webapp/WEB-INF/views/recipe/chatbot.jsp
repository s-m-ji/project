<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="main-content" class="container" style="">
		<div class="row">
			<div class="col-md-5">
				<form class="form-inline">
					<div class="form-group">
						<!-- <button id="connect" class="btn btn-default" type="submit"> -->
							<img id="connect" src="/resources/img/pingwing-bee_happy.png" style="width:150px; height:150px; position: fixed; right:0; bottom:0;">
						<!-- </button> -->
						<button id="disconnect" class="btn btn-default" type="submit" disabled="disabled" style="display: none">해제</button>
					</div>
				</form>
			</div>
			<div id="chatBox"class="col-md-row" >
				<div class="col-md-6">
					<table id="conversation" class="table table-striped">
						<thead>
							<tr>
								<th>메세지</th>
							</tr>
						</thead>
						<tbody id="showMessage"></tbody>
					</table>
				</div>
				<div class="col-md-7" > <!-- style="position: fixed; bottom: 0;" -->
					<form class="form-inline">
						<div class="form-group" >
							<input type="text" id="msg" class="form-control" placeholder="궁금한 내용을 알려주세요.">
							<button id="send" class="btn btn-default" disabled type="submit" >전송</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>