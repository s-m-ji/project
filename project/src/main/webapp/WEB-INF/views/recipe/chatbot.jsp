<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- <i class="fa fa-lock" aria-hidden="true" style="color:#2353a5;font-size:100px;"></i> -->
<body>
<div class="welcome-content">
	<i class="fa-solid fa-comment"></i>
	안녕하세요!<br>
	사이트 이용 중 궁금하거나 문의 사항이 있으신가요?<br>
	24시간 운영되는 저희 챗봇을 만나보세요!<br>
	<button onclick="startChat()">챗봇 시작하기</button>
</div>

<div id="main-content" class="container" style="display: none">
		<div class="row">
			<div class="col-md-5">
				<form class="form-inline">
					<!-- <div class="form-group">
						<button id="connect" class="btn btn-default" type="submit">
							<img id="connect" src="/resources/img/pingwing-bee_happy.png" style="width:150px; height:150px; position: fixed; right:0; bottom:0;">
						</button>
						<button id="disconnect" class="btn btn-default" type="submit" disabled="disabled" style="display: none">해제</button>
					</div> -->
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
<script>
var stompClient = null;
 
function startChat(){
	 $("#main-content").toggle();
	 $(".welcome-content").hide();
}
 
function setConnected(connected) {
	//prop("disabled", connected);
	$("#connect").prop("disabled", connected);
	$("#disconnect").prop("disabled", !connected);
	$("#send").prop("disabled", !connected);
	if (connected) {
		$("#conversation").show();
	} else {
		$("#conversation").hide();
	}
	$("#msg").html("");
	}

function connect() {
	var socket = new SockJS('/ws');
	stompClient = Stomp.over(socket);
	stompClient.connect({}, function(frame) {
		setConnected(true);
		//console.log('Connected: ' + frame);
		stompClient.subscribe('/topic/public', function(message) {
			let receiveMessage = message.body;
			showMessage2(receiveMessage); //서버에 메시지 전달 후 리턴받는 메시지
		});
	});
}

function disconnect() {
	if (stompClient !== null) {
		stompClient.disconnect();
	}
	setConnected(false);
	console.log("Disconnected");
}

function sendMessage() {
	let sendMessage = $("#msg").val()
	showMessage1(sendMessage);	//내가 입력한 메세지에요!
	stompClient.send("/app/sendMessage", {}, JSON.stringify(sendMessage)); //내가 입력한 메세지를 서버로 보내요!
}

function showMessage1(sendMessage) {
	$("#showMessage").append("<tr><td style='text-align: right;'>" + sendMessage + "</td></tr>");
}

function showMessage2(receiveMessage) {
	$("#showMessage").append("<tr><td style='text-align: left;'>" + receiveMessage + "</td></tr>");
}

$(function() {
	$("form").on('submit', function(e) {
		e.preventDefault();
	});
	$("#connect").click(function() {
		connect();
	});
	$("#disconnect").click(function() {
		disconnect();
	});
	$("#send").click(function() {
		sendMessage();
	});
	
	$('#connect').click(function() {
		if ($(".col-md-row").css("display") == "none") {
			$('.col-md-row').show();
			//$('.col-md-6').show();
			$('#connect').hide();
		}
	});
});	
</script>
</html>