<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 404 페이지입니다. -->

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style>
    @font-face {
    font-family: 'omyu_pretty';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-01@1.0/omyu_pretty.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

html {
  box-sizing: border-box; 
  
  }

*, *:before, *:after {
  box-sizing: inherit; }

body {
  background: #f7863b36;
  color: #313030;
  font-family: "soleil", Helvetica, sans-serif;
  font-family: 'omyu_pretty';
   }
  
  h1, h3 {
	position: fixed;
    top: 37.5%;
    left: 50%;
    text-align: center;
    transform: translate3d(-50%, -50%, 0);
    font-size: 12em;
    color: #F7863B;
}

h3 {
	top: 60%;
	font-size: 3em;
}
  

@keyframes blurIn {
  0% {
    transform: translate3d(0, -60px, 0) scale(0.9, 2);
    filter: blur(3px);
    opacity: 0; }
  100% {
    transform: translate3d(0, 0, 0) scale(1);
    filter: blur(0);
    opacity: 1; } }

@keyframes blurOut {
  0% {
    transform: translate3d(0, 0, 0) scale(1);
    filter: blur(0);
    opacity: 1; }
  100% {
    transform: translate3d(0, 60px, 0) scale(0.9, 2);
    filter: blur(3px);
    opacity: 0; } }

@keyframes pulseEllipsis {
  0% {
    box-shadow: -3px 0 0 rgba(127, 101, 68, 0.6), -9px 0 0 rgba(127, 101, 68, 0.6), -15px 0 0 rgba(127, 101, 68, 0.6); }
  20% {
    box-shadow: -3px 0 rgba(127, 101, 68, 0.6), -9px 0 0 rgba(127, 101, 68, 0.6), -15px 0 0 #7f6544; }
  40% {
    box-shadow: -3px 0 0 rgba(127, 101, 68, 0.6), -9px 0 0 #7f6544, -15px 0 0 rgba(127, 101, 68, 0.6); }
  60% {
    box-shadow: -3px 0 0 #7f6544, -9px 0 0 rgba(127, 101, 68, 0.6), -15px 0 0 rgba(127, 101, 68, 0.6); } }

@keyframes fadeInOutLong {
  0%, 35% {
    opacity: 0; }
  40%, 85% {
    opacity: 1; }
  90%, 100% {
    opacity: 0; } }

#loader {
  /* background: #f7863b36; */
  width: 400px;
  position: fixed;
  top: 30%;
  left: 50%;
  text-align: center;
  transform: translate3d(-50%, -50%, 0); }
  #loader .emoji, #loader .text {
    animation-name: blurIn;
    animation-duration: 0.3s;
    animation-timing-function: cubic-bezier(0.58, -0.23, 0.3, 1.3);
    animation-fill-mode: both; }
  #loader .emoji {
    display: block;
    font-size: 4em;
    margin-bottom: 0.2em;
    animation-delay: 0.1s; }
  #loader .text {
    line-height: 1;
    color: #7F6544;
    font-size: 1.75em;
    margin-right: -14px; }
    #loader .text:after {
      content: '';
      display: inline-block;
      background: transparent;
      width: 3px;
      height: 3px;
      border-radius: 50%;
      margin-left: 18px;
      box-shadow: -3px 0 0 rgba(127, 101, 68, 0.6), -9px 0 0 rgba(127, 101, 68, 0.6), -15px 0 0 rgba(127, 101, 68, 0.6);
      animation: pulseEllipsis 0.8s infinite both ease-in-out; }
  #loader .animateOut {
    animation-name: blurOut;
    animation-duration: 0.3s;
    animation-timing-function: cubic-bezier(0.58, -0.23, 0.3, 1.3);
    animation-fill-mode: both; }
    



</style>
</head>
<body>
	
	<div id="loader"></div>
	<h1>404</h1>
	<h3>페이지를 찾을 수 없습니다.</h3>
	<script type="text/javascript">
	var LOADER_CONTAINER = $("#loader");
	var LOADER_INTERVAL = 2000;
	var LOADERS = [
		["🌶","고추를 다져요"],
		["🔪","칼을 갈아요"],
		["👩🏽‍🍳","앞치마를 푸려요"],
		["🥒","야채를 볶아요"],
		["🍳","계란을 지지고 볶아요"],
		["🧀","치즈를 자르고요"],
		["🥓","베이컨을 바삭하게 구워요"],
		["🌽","옥수수를 깎아요"],
		["🍚","쌀을 쪄요"],
		["🍷","와인을 따요"],
		["🍽","요리를 접시에 담아요"],
		["🍤","새우를 튀겨요"],
		["🥐","크루아상을 토스트해요"],
		["🍋","레몬의 씨를 빼요"],
		["🥕","당근의 껍질을 벗겨요"],
		["🍲","수프를 저어요"],
		["🐸🍵","차를 쏟아요"],
		["🍕","피자를 오븐에 구워요"],
		["🔥","버너를 켜요"],
		["🥔","감자를 구워요"],
		["🤔","맛을 시험해봐요"],
		["🍊","오렌지를 짜요"],
		["💧","물을 따라요"],
		["🍦","아이스크림을 얼려요"],
		["🍨","디저트를 스쿱해요"],
		["🥗","샐러드를 섞어요"],
		["🥚","계란 껍질을 까요"],
		["🥞","팬케이크를 쌓아요"],
		["🍒","마무리로 체리를 올려요"],
		["🍗","치킨 윙을 양념해요"],
		["🍅","토마토를 으깨요"],
		["🍍","파인애플을 썰어요"],
		["💖","완벽한 무언가를 조금 더해요"],
		["📝","레시피를 씁니다"],
		["🗓","메뉴를 계획해요"],
		["🌰","견과류를 까요"],
		["🍿","팝콘을 튀겨요"],
		["🍾","샴페인을 엽니다"],
		["🍆","가지를 심어요"],
		["🥑","아보카도를 으깨요"],
		["🍌","바나나의 껍질을 벗겨요"],
		["🍔","버거를 뒤집어요"],
		["🍻","잔을 충돌시켜요"],
		["🍴","식기를 닦아요"],
		["🍪","쿠키를 구워요"],
		["🍣","스시를 말아요"],
		["🍶","사케를 데워요"],
		["🍱","벤토 박스에 담아요"],
		["🌯","부리또를 싸요"],
		["☕️","커피를 내려요"],
		["🍏","사과의 씨를 빼요"],
		["🌿","허브를 키워요"],
		["🍰","케이크를 조각내요"],
		["🍟","감자를 튀겨요"],
		["🍑","복숭아의 껍질을 벗겨요"],
		["🍛","카레에 향신료를 넣어요"],
		["🌮","타코를 조립해요"],
		["📸","음식을 촬영해요"],
		["🛎","종을 울려요"],
		["🍫","초콜릿을 녹여요"],
		["🍜","라면을 요리해요"],
		["🥖","바게트를 구워요"],
		["❄️","얼음을 베어요"],
		["🥛","밀크셰이크를 믹스해요"],
		["🍄","버섯을 다져요"],
		["🐟","생선을 데워요"],
		["😋","입을 핥아요"],
		["🤞🏾","손가락을 꼬아요"],
		["👊🏿","주먹을 부딪혀요"],
		["☝🏽","마지막으로 하나 더 더해요"],
		["😙👌","이탈리아 셰프처럼 행동해요"],
		["👃🏻","냄새를 맡아요"],
		["🍹","음료를 혼합해요"],
		["✨","마법을 만들어요"],
		["🌱","씨앗을 심어요"],
		["⚗️","무언가 새로운 것을 실험해요"],
	]

	$(document).ready(function() {
	  
	  var cycleLoader = function() {
	    var index = Math.floor(Math.random() * LOADERS.length);
	    var selected = LOADERS[index];
	    var selectedEmoji = selected[0];
	    var selectedText = selected[1];
	    
	    // First transition out the old loader
	    setTimeout(function(){
	      LOADER_CONTAINER.children().addClass("animateOut");
	    }, LOADER_INTERVAL - 300); // This negative value should be the same as $animation-duration in the CSS
	    
	    // Then remove the animated out divs
	    LOADER_CONTAINER.children(".emoji").last().remove();
	    LOADER_CONTAINER.children(".text").last().remove();
	    
	    // Then animate in the new one
	    LOADER_CONTAINER.append('<div class="emoji">' + selectedEmoji + '</div>');
	    LOADER_CONTAINER.append('<div class="text">' + selectedText + '</div>');
	  }
	  
	  setInterval(cycleLoader, LOADER_INTERVAL);  
	  cycleLoader(); // Run first time without delay
	  
	});
</script>
</body>
</html>