<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="login_form">
	<div id = "logoContainer">
		<a href="/home"><img id = "logo" src="../resources/asset/images/logo_1.jpg"/></a>
	<form action="/member/loginAction" method="post" id="loginForm" >
	<input type="hidden" name=type value="M"/>
		<div class="int-area">
			<input type="text" name="id" id="id" autocomplete="off" required>
			<label for="id">아이디</label>
		</div>
		<div class="int-area">
			<input type="password" name="password" id="password" autocomplete="off" required>
			<label for="pw">비밀번호</label>
		</div>
		<div class="btn-area">
			<button id="loginBtn" class="custom-btn btn-12" type="button"><span>로그인!</span><span>로그인 하기</span></button>
 		</div>
	</form>
	<div class="caption">
		<a href="/member/createAccountPage">고객 회원가입</a> | <a href="/member/createAccountPagePartner">기업 회원가입</a>
	</div>
	
	<div class="caption">
		<a href="/member/searchid">아이디 찾기</a> | <a href="/member/searchpassword">비밀번호 찾기</a>
		</div><br/>
		<div class="kakao-login">
			<form id="form-kakao-login" method="post" action="/member/kakaologin">
				<input type="image" src="../resources/asset/images/kakao_login_medium_wide.png" style width="300px;" name="button" onclick="javascript:kakaoLogin();return false;">
				<input type="hidden" name="email"/>
				<input type="hidden" name="nickname"/>
				<input type="hidden" name="type" value="M"/>
			</form>	
		</div>
		<!-- 
	<form id="form-kakao-login" action="./member/Action/loginKakaoAction.jsp" method="post">
		<img src="./member/login_source/kakao_login_medium_wide.png" style width="100%;"> 
		<input type="hidden" name="email"/>
		<input type="hidden" name="name"/>
		<a href="javascript:kakaoLogin();"><img src="./member/login_source/kakao_login_medium_wide.png" style width="100%;"></a>
	</form> 
	-->
</div>