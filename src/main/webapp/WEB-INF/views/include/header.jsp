<%@page import="com.maumgagym.dto.NewsTO"%>
<%@page import="org.springframework.web.server.session.InMemoryWebSessionStore"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
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
		if(type.equals("A")) {
			pageContext.forward("/manager/main");
		}
	}   
	
%>  
	<nav class="navbar navbar-expand-lg navbar-light bg-white text-black">
	    <div class="container px-3 px-lg-5">
	        <a class="navbar-brand" href="/home"><img src="../resources/asset/images/logo_1.jpg" height="36"></a>
	        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
	        <div class="collapse navbar-collapse" id="navbarSupportedContent">
	            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
	                <li class="nav-item px-4 "><a class="nav-link" href="/home">홈</a></li>
	                <li class="nav-item px-4"><a class="nav-link" href="./notificationPage.jsp">공지 / 이벤트</a></li>
	                <li class="nav-item px-4"><a class="nav-link" href="/community/list">커뮤니티</a></li>
				<%	
					if( type == null || !( type.equals( "C" ) ) ) { 
				%>                
	                <li class="nav-item px-4"><a class="nav-link" href="./cartPage.jsp">회원권 만들기</a></li>
	            <%	
	            	}  
	            %>	                
	                <li class="nav-item px-4"><a class="nav-link" href="'./customerCenter_viewPage.jsp'">고객센터</a></li>
	            </ul>
	            <%
	            	if( id == null ) {
	            %>
	            <a class="navbar-brand ps-3" href="/member/login">
	              <button type="button" class="btn btn-primary rounded-pill"><span style="font-size:smaller;">로그인</span></button>
	            </a>
	            <a class="navbar-brand ps-3" href="/member/createAccountPage">
	              <button type="button" class="btn btn-light rounded-pill"><span style="font-size:smaller;">회원가입</span></button>
	            </a>
       	        <%
	            	} else { 
	            		if( ( type.equals( "M" ) ) ) {
	            %>
	            
	            <a class="navbar-brand ps-3" id="news" class="btn">
	              <i class="bi bi-chat-left-dots"></i>
	              <span id="unreadNews" style="position: relative; top: -15px; right: 5px; font-size: 13px;" class="badge bg-primary rounded-pill">0</span>
	            </a>

				<div id="" style="display:none; font-size: 10px;" class="alert_list">
				  <ul id="newsList" class="list-group"> </ul>
				</div>
	            
	            <a class="navbar-brand ps-3" href="/mypage/<%=id%>">
	              <i class="bi bi-person"></i>
	            </a>
	          	<button type="button" class="btn btn-light rounded-pill" onclick="location.href='/member/logout'"><span style="font-size:smaller;">로그아웃</span></button>
	            
       	        <%
	            		} else {
	            %>
	            
	            <a class="navbar-brand ps-3" id="news" class="btn">
	              <i class="bi bi-chat-left-dots"></i>
	              <span id="unreadNews" style="position: relative; top: -15px; right: 5px; font-size: 13px;" class="badge bg-primary rounded-pill">0</span>
	            </a>

				<div id="" style="display:none; font-size: 10px;" class="alert_list">
				  <ul id="newsList" class="list-group"> </ul>
				</div>
	            
	            <a class="navbar-brand ps-3" href="./facilityUserPage.jsp">
	              <i class="bi bi-person"></i>
	            </a>
	          	<button type="button" class="btn btn-light rounded-pill" onclick="location.href='/member/logout'"><span style="font-size:smaller;">로그아웃</span></button>
	            
	            <%
	            		}
	            	}
	            %>
	        </div>
	    </div>
	</nav>
