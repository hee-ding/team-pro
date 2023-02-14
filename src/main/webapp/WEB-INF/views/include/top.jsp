<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int bannerNumber = (int)(Math.random() * 6 ) + 1;
%>    
    
<header class="bg-white py-1">
  <img src="./resources/asset/images/main_view/main_top/main_banner<%= bannerNumber %>.png" class="img-fluid rounded mx-auto d-block w-100" alt="Responsive image" />
</header>