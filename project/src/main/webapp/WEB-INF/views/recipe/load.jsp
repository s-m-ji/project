<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>welcome</title>
<!-- <link href="/resources/assets/sass/load.css" rel="stylesheet"> -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style>
html {
  box-sizing: border-box; }

*, *:before, *:after {
  box-sizing: inherit; }

body {
  background: #F6F4E8;
  color: #313030;
  font-family: "soleil", Helvetica, sans-serif; }

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
  background: #F6F4E8;
  width: 400px;
  position: fixed;
  top: 50%;
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
    font-size: 3.5em;
    margin-bottom: 0.2em;
    animation-delay: 0.1s; }
  #loader .text {
    line-height: 1;
    color: #7F6544;
    font-size: 20px;
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
	<div id="loader">
	</div>
	<script type="text/javascript">
	var LOADER_CONTAINER = $("#loader");
	var LOADER_INTERVAL = 1600;
	var LOADERS = [
	  ["🌶","Dicing peppers"],
	  ["🔪","Sharpening knives"],
	  ["👩🏽‍🍳","Starching aprons"],
	  ["🥒","Sautéing veggies"],
	  ["🍳","Frying eggs"],
	  ["🧀","Cutting cheese"],
	  ["🥓","Crisping bacon"],
	  ["🌽","Shucking corn"],
	  ["🍚","Steaming rice"],
	  ["🍞","Baking bread"],
	  ["🍷","Uncorking wine"],
	  ["🍽","Plating dishes"],
	  ["🍤","Frying shrimp"],
	  ["🥐","Toasting croissants"],
	  ["🍋","Deseeding lemons"],
	  ["🥕","Peeling carrots"],
	  ["🍲","Stirring soups"],
	  ["🐸🍵","Spilling tea"],
	  ["🍕","Firing pizzas"],
	  ["🔥","Lighting burners"],
	  ["🥔","Roasting potatoes"],
	  ["🤔","Testing tastes"],
	  ["🍊","Squeezing oranges"],
	  ["💧","Pouring water"],
	  ["🍦","Freezing ice cream"],
	  ["🍨","Scooping desserts"],
	  ["🥗","Mixing salads"],
	  ["🥚","Cracking eggs"],
	  ["🥞","Stacking pancakes"],
	  ["🍒","Putting a cherry on top"],
	  ["🍗","Seasoning wings"],
	  ["🍅","Crushing tomatoes"],
	  ["🍍","Chunking pineapples"],
	  ["💖","Adding a pinch of something perfect"],
	  ["📝","Writing recipes"],
	  ["🗓","Planning menus"],
	  ["🌰","Cracking nuts"],
	  ["🍿","Popping popcorn"],
	  ["🍾","Popping champers"],
	  ["🍆","Planting eggs"],
	  ["🥑","Mashing avocados"],
	  ["🍌","Peeling bananas"],
	  ["🍔","Flipping burgers"],
	  ["🍻","Clinking glasses"],
	  ["🍴","Polishing silverware"],
	  ["🍪","Baking cookies"],
	  ["🍣","Rolling sushi"],
	  ["🍶","Warming sake"],
	  ["🍱","Boxing bento"],
	  ["🌯","Wrapping burritos"],
	  ["☕️","Brewing coffee"],
	  ["🍏","Coring apples"],
	  ["🌿","Growing herbs"],
	  ["🍰","Slicing cakes"],
	  ["🍟","Frying fries"],
	  ["🍑","Peeling peaches"],
	  ["🍛","Spicing curry"],
	  ["🌮","Assembling tacos"],
	  ["📸","Photographing plates"],
	  ["🛎","Dinging bells"],
	  ["🍫","Melting chocolate"],
	  ["🍜","Cooking ramen"],
	  ["🥖","Baking baguettes"],
	  ["❄️","Shaving ice"],
	  ["🥛","Blending milkshakes"],
	  ["🍄","Chopping mushrooms"],
	  ["🐟","Searing fish"],
	  ["😋","Licking lips"],
	  ["🤞🏾","Crossing fingers"],
	  ["👊🏿","Bumping fists"],
	  ["☝🏽","Throwing in one last thing"],
	  ["😙👌","Doing that Italian chef thing"],
	  ["👃🏻","Smellin’ smells"],
	  ["🍹","Mixing drinks"],
	  ["✨","Making magic"],
	  ["🌱","Planting seeds"],
	  ["⚗️","Testing something new"],
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