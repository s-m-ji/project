window.addEventListener("load", function(){
	console.log("-------------- listFile.js 연결 완료! ----------------");
		getFileList();
		
		// ▶ 파일 목록 요청
		function getFileList(){
			fetch('/file/list')
				.then(response => response.json())
				.then(map => viewFileList(map));
		}
		
		// ▶ 파일 목록 조회 
		function viewFileList(map) {
		    let fileList = map.list; // 파일 목록 배열 저장
		    let fileDivs = document.querySelectorAll(".fileDiv"); // 모든 fileDiv 태그 선택

		    fileDivs.forEach(function (fileDiv) {
		        let inputElement = fileDiv.querySelector("input[name='b_no']");
		        if (inputElement !== null) {
		            let bnoValue = inputElement.value;
		            let matchingFile = fileList.find(item => item.b_NO === parseInt(bnoValue));
		            if (matchingFile) {
		                let savePath = encodeURIComponent(matchingFile.savePath); // 원본 파일
		                let imageTag = "<img src='/display?fileName=" + savePath + "' alt='레시피 사진 " + matchingFile.b_NO + "'>";
		                fileDiv.innerHTML = imageTag; // 해당 fileDiv 태그에 이미지 추가
		            } else {
		                fileDiv.innerHTML = '<mark>&nbsp; 등록된 요리 사진이 없습니다. &nbsp;</mark>';
		            }
		        } else {
		            console.log("input[name='b_no']가 없는 fileDiv가 있습니다.");
		        }
		    });
		}

	});