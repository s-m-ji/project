// window.onload = (e) => {
	  	 
	 // ▶▶▶  게시글 삭제 관련
	 function deleteBook() {
		 const delList = document.querySelectorAll('[name=bno]:checked');
		 let delNo = Array.from(delList).map(e => e.value).join(',');
		 console.log(delNo);
		 
		 const delNoInput = document.getElementById('delNoInput');
		 delNoInput.value = delNo;
		 
		 const deleteForm = document.getElementById('deleteForm');
		 deleteForm.submit();
	 }
	 
	 
	// 체크박스들을 모두 선택/해제하는 함수
	 function toggleCheckboxes() {
	   var adminChkBox = document.getElementById('adminChkBox');
	   var isChecked = adminChkBox.checked;

	   var chkBox = document.getElementsByClassName('chkBox');

	   for (var i = 0; i < chkBox.length; i++) {
		   chkBox[i].checked = isChecked;
	   }
	 }
	 
	 
	 // ▶▶▶  게시글 등록/수정 관련
	function action(url) {
		postForm.action = url;
		postForm.submit();
	}

	 // ▶▶▶  게시글 페이지네이션
	function go(page){
		//e.preventDefault();
		document.searchForm.action = "./list_test";
		document.searchForm.pageNo.value=page;
		document.searchForm.submit();
	}
	
	function requestAction(url, b_no) {
		//e.preventDefault();
		searchForm.action = url;
		searchForm.b_no.value = b_no;
		searchForm.submit();
	}
	
	// 한 페이지에 보여지는 리스트 개수 조정
	function changePageSize(value) {
    	var searchForm = document.forms.searchForm;
    		searchForm.amount.value = value;
    		searchForm.submit();
	}
	
	// 페이지 위로 가기 버튼
	/*var goToTop = function() {

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
	
	};*/
// }


