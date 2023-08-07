window.addEventListener("load", function(){
	console.log("-------------- listFile.js 연결 완료! ----------------");
		getFileList();
		
		// ▶ 파일 목록 요청
		function getFileList(){
			fetch('/file/recList')
				.then(response => response.json())
				.then(map => viewFileList(map));
		}
		
		
		// ▶ 파일 확장자 체크
		function checkExtention(fileName, fileSize){
			
			// 정규표현식 : 특정 규칙을 가진 문자열을 검색하거나 치환할 때 사용
			// 문자열에 정규식 패턴을 만족하는 값이 있으면 true, 아니면 false를 리턴.
			// .exe, .sh, .zip, .alz로 끝나는 문자열을 판단함 		
			let regex = new RegExp("(.*?)\.(mp4)$"); 
			if(regex.test(fileName)){
				alert("어우 이런 파일 형식은 안돼 얘");
				return false;
			}
			
			// 최대 크기를 넘어서는 파일을 업로드 시도할 경우 false를 리턴.
			let maxSize = 1024 * 1024 * 1000;
			if(maxSize <= fileSize){
				alert("어우 파일이 너무 크다 얘");
				return false;
			}
			return true; // 이렇게 조건 만족 후 true를 반환해야 !!! 정상적으로 파일을 업로드할 수 있음
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
		                let fileExtension = matchingFile.savePath.split('.').pop(); // 파일 확장자 추출
		                if (fileExtension === "mp4") {
		                  let videoTag = "<video autoplay playsinline mute width='100%' height='auto'><source src='/recListdisplay?fileName=" + savePath + "' type='video/mp4'></video>";
		                  fileDiv.innerHTML = videoTag; // 해당 fileDiv 태그에 동영상 추가
		                } else {
		                  let imageTag = "<img src='/recListdisplay?fileName=" + savePath + "' alt='레시피 사진 " + matchingFile.b_NO + "'>";
		                  fileDiv.innerHTML = imageTag; // 해당 fileDiv 태그에 이미지 추가
		                }
		            }
		        } else {
		            console.log("input[name='b_no']가 없는 fileDiv가 있습니다.");
		        }
		    });
		}

	});









