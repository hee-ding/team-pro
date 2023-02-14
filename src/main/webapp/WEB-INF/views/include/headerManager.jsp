<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
		
	request.setCharacterEncoding( "utf-8" );
	
	String id = null;
	String type = null;
	// get id	
	if( session.getAttribute("id") != null ) {
		id = ( String ) session.getAttribute("id");
	}

	 if( session.getAttribute("type") != null ) {
		type = ( String ) session.getAttribute( "type" );
	}   
	
%>      
    <!-- header navbar -->

	<nav class="navbar navbar-expand-lg navbar-light bg-white text-black">
	    <div class="container px-3 px-lg-5">
	        <a class="navbar-brand" href="/manager/main"><img src="../resources/asset/images/logo_1.jpg" height="36"></a>
	        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
	        <div class="collapse navbar-collapse" id="navbarSupportedContent">
	            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
	                <li class="nav-item px-4 "><a class="nav-link" href="/manager/main">홈</a></li>
	                <li class="nav-item px-4"><a class="nav-link" href="/manager/facilityboard">운동시설관리</a></li>
	                <li class="nav-item px-4"><a class="nav-link" href="/manager/board">게시물관리</a></li>
	                <li class="nav-item px-4"><a class="nav-link" href="/manager/comment">댓글관리</a></li>
	                <li class="nav-item px-4"><a class="nav-link" href="/manager/member">회원관리</a></li>
	       <!--          <li class="nav-item px-4"><a class="nav-link" href="#!">접속통계</a></li> -->
	            </ul>
	     	          	<button type="button" class="btn btn-light rounded-pill" onclick="location.href='/manager/login'"><span style="font-size:smaller;">로그아웃</span></button>
	        </div>
	    </div>
	</nav>

	<!-- /header navbar -->