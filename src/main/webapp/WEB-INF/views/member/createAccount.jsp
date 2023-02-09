<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
		<title>Maumgagym</title>
	    <link href="./resources/asset/css/createAccount_custom.css" rel="stylesheet"/>
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
	    
        <!-- jquery-->
        <script src="http://code.jquery.com/jquery-latest.js"></script> 
        <!-- 다음 우편번호찾기 API -->
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
		    function execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		
		                var addr = ''; // 주소 변수
		                var extraAddr = ''; // 참고항목 변수
		                var detailAddress = ''; // 상세
		
		                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R' || data.userSelectedType === 'J') { // 사용자가 도로명,지번 주소를 선택했을 경우
		                	addr = data.sido+" "+data.sigungu+" "+data.bname;
		                } 
		                if (data.userSelectedType === 'R' || data.userSelectedType === 'J') { // 사용자가 도로명,지번 주소를 선택했을 경우
		                	detailAddress = data.roadAddress;
		                } 
		                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		                if(data.userSelectedType === 'R'){
		                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있고, 공동주택일 경우 추가한다.
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                    // 조합된 참고항목을 해당 필드에 넣는다.
		                    document.getElementById("extraAddress").value = extraAddr;
		                
		                } else {
		                    document.getElementById("extraAddress").value = '';
		                }
		
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('postcode').value = data.zonecode;
		                document.getElementById("address").value = addr;
		                document.getElementById("detailAddress").value = detailAddress;
		                // 커서를 상세주소 필드로 이동한다.
		                //document.getElementById("detailAddress").focus();
		            }
		        }).open();
		    }
		</script>
		
		</head>
		<body>
		<jsp:include page="./createAccount_source/createAccount_form.jsp"/>
		
	    <script src="./resources/asset/script/jquery-1.11.1.min.js"></script>
	   	<!-- Bootstrap core JS-->
	    <script src="./resources/asset/js/bootstrap.bundle.min.js" ></script>
	   
	   <!-- 비밀번호 일치 검사 & 정규식 -->
	    <script type="text/javascript">
		
	    function check_pw(){
            var pw = document.getElementById('pw').value;
            var SC = ["!","@","#","$","%"];
            var check_SC = 0;
 
            if(pw.length < 6 || pw.length>16){
                window.alert('비밀번호는 6글자 이상, 16글자 이하만 이용 가능합니다.');
                document.getElementById('pw').value='';
            }
            for(var i=0;i<SC.length;i++){
                if(pw.indexOf(SC[i]) != -1){ //특수기호가 들어가 있으면 
                    check_SC = 1; //정상
                }
            }
            if(check_SC == 0){
                window.alert('!,@,#,$,% 의 특수문자가 들어가 있지 않습니다.')
                document.getElementById('pw').value='';
            }
            if(document.getElementById('pw').value !='' && document.getElementById('pw2').value!=''){
                if(document.getElementById('pw').value==document.getElementById('pw2').value){
                    document.getElementById('check').innerHTML='비밀번호가 일치합니다.'
                    document.getElementById('check').style.color='blue';
                }
                else{
                    document.getElementById('check').innerHTML='비밀번호가 일치하지 않습니다.';
                    document.getElementById('check').style.color='red';
                }
            }
        }
	    
	    <!-- 공백인 상태에서 회원가입 버튼 클릭시 alert 창-->
	    $(document).ready(function(){ 
	    	 $("#joinBtn").click(function() {
	    		 if(  $( "#nickName" ).val() == '' || $( "#id" ).val() == '' ||   $( "#pw" ).val() == '' 
	    			 ||  $( "#name" ).val() == '' ){
			    		alert("빈칸을 다 입력해주세요. ※이메일은 아이디/비밀번호 찾기시 필수 인증 단계입니다. 꼭 정확한 입력해주세요.");
			    		return false;
	    		 }
	    	 });
	   });
	    
	    
	    
		</script>
	   
		</body>
</html> 