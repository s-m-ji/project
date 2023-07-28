<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>searchForm.jsp</title>
<!-- 다중 셀렉스 테스트 -->
		<script type="text/javascript">
			$(function(){
		    // 질문유형을 선택한다.
		    	chnQnaType('1' , '11');
			});
			
			function chnQnaType(type , select) {
			    
			    $('#c2depth').empty();
			    
			    if(type == '1') { 
			        $('#c2depth').append("<option value='11' >밥</option>'");
			        $('#c2depth').append("<option value='12' >면</option>'");
			        $('#c2depth').append("<option value='13' >간식</option>'");
			    } else if (type == '2') {  
			        $('#c2depth').append("<option value='21' >과일류</option>'");
			        $('#c2depth').append("<option value='22' >달걀/유제품</option>'");
			        $('#c2depth').append("<option value='23' >육류</option>'");
			    } else if ( type == '3') {  
			        $('#c2depth').append("<option value='31' >명절</option>'");
			        $('#c2depth').append("<option value='32' >도시락</option>'");
			        $('#c2depth').append("<option value='33' >안주</option>'");
			    }
			    document.getElementById("c2depth").style.display = "";
			    
			    if ($.trim(select) != "") {
			        $('#select1').val(type);
			        $('#c2depth').val(select);
			    }
			}
		</script>
</head>
<body>
<%-- pDto.cri.sWord : ${pDto.cri.sWord } 이렇게 클래스 내에 선언한 필드명 그대로 소문자 s라고 썼더니 안 나옴 그런 속성을 찾을 수 없다고함... 엉엉 --%>
	<form action="./list_test" name="searchForm">
	<div class="container text-center">
	  <div class="row">
	    <div class="col">
	      <select name="c1depth" id="c1depth" onChange="chnQnaType(this.value)" >
			    <option value="1">종류별</option>
			    <option value="2">재료별</option>
			    <option value="3">상황별</option>
			</select>
		    </div>
		    <div class="col">
		      <select id="c2depth" name="c2depth" ></select>
		    </div>
		    <div class="col">
		     <input type="text" name="sWord" class="form-control" value="${pDto.cri.SWord}" placeholder="검색어">
		    </div>
		    <div class="col">
		     <button type="submit" class="btn btn-primary mb-3" onclick="go(1);">검색</button>
		    </div>
		  </div>
		</div>
		<div class="container text-center">
	  		<div class="row">
			    <div class="col">
			    	pDto.cri.pageNo : <input type="text" name="pageNo" value="${pDto.cri.pageNo}">
			    </div>
			    <div class="col">
					param.b_no : <input type="text" name="b_no" value="${param.b_no}">
			    </div>
			    <div class="col">
				    <select class="form-control" name="amount" onchange="changePageSize(this.value)">
			           	<option value="10" ${ param.amount eq '10' ? "selected" : "" }>10개씩 보기</option>
			           	<option value="20" ${ param.amount eq '20' ? "selected" : "" }>20개씩 보기</option>
			           	<option value="30" ${ param.amount eq '30' ? "selected" : "" }>30개씩 보기</option>
		          </select>
			    </div>
		    </div>
		</div>
	</form>
</body>
</html>