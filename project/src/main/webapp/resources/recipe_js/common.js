/**
 *  공통으로 쓸 코드 모음
 */

console.log("-------------- common.js 연결 완료! ----------------");

// Get방식 fetch : 요청(url)과 함수(callback)를 매개변수로 함
	function fetchGet(url, callback){
		try{
		fetch(url)
			.then(response => response.json())
			.then(map => callback(map));
		} catch(e){
			console.log('fetchGet', e);
		}
	}

	
	// Post방식 fetch : 요청(url)과  객체(obj) 그리고 함수(callback)를 매개변수로 함
	function fetchPost(url, obj, callback){
		try{
			fetch(url
					, {method : 'post' 
						, headers : {'Content-Type' : 'application/json'}
						, body : JSON.stringify(obj)})
				.then(response => response.json())
				.then(map => callback(map));
		} catch(e){
			console.log('fetchPost', e);
		}
	}
	
	
		// 페이지 상단으로 이동하는 버튼
		var goToTop = function() {

			$('.js-gotop').on('click', function(event){
				
				event.preventDefault();

				$('html, body').animate({
					scrollTop: $('html').offset().top
				}, 500, 'easeInOutExpo');
				
				return false;
			});

			$(window).scroll(function(){
				var $win = $(window);
				if ($win.scrollTop() > 200) {
					$('.js-top').addClass('active');
				} else {
					$('.js-top').removeClass('active');
				}

			});
		};
		
		// 함수 호출 추가
		goToTop();
		
