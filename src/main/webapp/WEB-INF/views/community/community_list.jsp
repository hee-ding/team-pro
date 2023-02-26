<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String id = request.getParameter("id");
	String nickname = request.getParameter("nickname");
%>   
<!DOCTYPE html>
<html>
<head>
	<link rel="icon" href="data:;base64,iVBORw0KGgo=">
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0, maximum-scale=1.0"/>
	<title>Maumgagym</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Bootstrap icons-->
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <link href="../resources/asset/css/community.css" rel="stylesheet" type="text/css" />
	<style type ="text/css">
	</style>
	<script type="text/javascript" src="../resources/asset/script/jquery-1.11.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<!--  header news -->
	<link rel="stylesheet" href="/resources/asset/css/news.css"/>
</head>
<body>
    
    <!--  header -->
	<jsp:include page="../include/header.jsp" />
	<!--  search  -->
	<jsp:include page="../main/main_source/main_search.jsp" />

	<!-- 공지/이벤트 list 템플릿 -->
	<jsp:include page="../community/community_source/community_list_container1.jsp"/>
	
	<!-- footer -->
	<jsp:include page="../include/footer.jsp" />
	
	<!-- Bootstrap core JS-->
    <script src="/resources/asset/js/bootstrap.bundle.min.js" ></script>
	
	<!-- JAVASCRIPT FILES -->
    <script src="/resources/asset/script/jquery-1.11.1.min.js"></script>
    <script src="/resources/asset/js/owl.carousel.min.js"></script>
	
	<!--  header news -->
	<script src="/resources/asset/js/news.js"></script>
	
	 <script type = "text/javascript"> 
		 document.getElementById("search").onclick = function(){
			 let category = document.getElementsByName("searchtype")[0].value;
			 let keyword = document.getElementsByName("keyword")[0].value;
			 
			 if(category === "분류 선택"){
				 alert('분류를 선택하셔야 합니다.');
				 return;
			 }
			 
			location.href = "/community/searchkeyword?pageNum=1" + "&keyword=" + keyword + "&category=" + category;
		};
	</script>
</body>
</html>