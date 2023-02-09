<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>Maumgagym</title>
	    <link href="./resources/asset/css/login_custom.css" rel="stylesheet"/>
	    
	    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	    
	    <script>
			Kakao.init('2f293c216237addee3e388f7900b458a'); //발급받은 키 중 javascript키를 사용해준다.
			console.log(Kakao.isInitialized()); // sdk초기화여부판단
			//카카오로그인
			function kakaoLogin() {
			    Kakao.Auth.login({
			      success: function (response) {
			        Kakao.API.request({
			          url: '/v2/user/me',
			          success: function (response) {
			        	  console.log(response);
			        	  
			        	  // 전달받은 json에서 정보 추출 가능
			        	  // var id = res.id;
			 			  // scope : 'account_email';
						  // alert('로그인성공');
             			  // location.href="callback주소
			        	  
			          },
			          fail: function (error) {
			            console.log(error)
			          },
			        })
			      },
			      fail: function (error) {
			        console.log(error)
			      },
			    })
			  }
			//카카오로그아웃  
			function kakaoLogout() {
			    if (Kakao.Auth.getAccessToken()) {
			      Kakao.API.request({
			        url: '/v1/user/unlink',
			        success: function (response) {
			        	console.log(response)
			        },
			        fail: function (error) {
			          console.log(error)
			        },
			      })
			      Kakao.Auth.setAccessToken(undefined)
			    }
			  }  
		</script>
	    
	</head>
	
	<body>

	<jsp:include page="./login_source/login_form.jsp"/>

    <script src="./resources/asset/script/jquery-1.11.1.min.js"></script>
   	<!-- Bootstrap core JS-->
    <script src="./resources/asset/js/bootstrap.bundle.min.js" ></script>
    
    <!-- 카카오 로그인 -->
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script>
    window.Kakao.init("972704b56a1c38fb7342842529694de9"); //설정한 마음가짐 javascript 고유키

	function kakaoLogin() {
	    //1. 로그인 시도
	    Kakao.Auth.login({
	    	scope : 'profile_nickname, account_email',
	        success: function(authObj) {
	        	console.log(authObj);
		        var token = authObj.access_token;
	          //2. 로그인 성공시, API 호출
	          Kakao.API.request({
	            url: '/v2/user/me',
	            success: res => {
	              console.log(res);
	              var account = res.kakao_account;
	              $('#form-kakao-login input[name=email]').val(account.email);
				  $('#form-kakao-login input[name=name]').val(account.profile.nickname);
	              var kakao_nickname = account.profile.nickname;
	              var kakao_email = account.email;
	              console.log(kakao_nickname);
	             console.log(kakao_email);
	             document.querySelector('#form-kakao-login').submit();
				 //alert('로그인성공');
	              //location.href="./logininfo.jsp";
	        		}
	         	 })
	        },
	        fail: function(err) {
	          alert(JSON.stringify(err));
	        }
	     });
	    
	}

</script>

<script>
	$(document).ready(function(){
	    $("#loginBtn").click(function(){        
	        $("#loginForm").submit(); 
	    });
	});
</script>
</body>
</html> 