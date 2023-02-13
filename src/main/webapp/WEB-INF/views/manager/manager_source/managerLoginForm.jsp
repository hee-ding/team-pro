<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="login_form">
	<div id = "logoContainer">
		<a href="/"><img id = "logo" src="../resources/asset/images/logo_1.jpg"/></a>
	<form action="/manager/loginAction" method="post" id="loginForm" >
	<input type="hidden" name=type/>
		<div class="int-area">
			<input type="text" name="id" id="id" autocomplete="off" required>
			<label for="id">아이디</label>
		</div>
		<div class="int-area">
			<input type="password" name="password" id="password" autocomplete="off" required>
			<label for="pw">비밀번호</label>
		</div>
		<div class="btn-area">
			<button id="loginBtn" class="custom-btn btn-12" type="button"><span>로그인</span><span>로그인 하기</span></button>
 		</div>
	</form>
	
	
	<div class="caption">
		<a href="/member/searchid">아이디 찾기</a> | <a href="/member/searchpassword">비밀번호 찾기</a>
		</div><br/>
</div>