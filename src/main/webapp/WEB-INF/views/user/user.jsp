<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

	String id = null;
	
	if( session.getAttribute("id") != null ) {
		id = ( String ) session.getAttribute("id");
	} else {
		id = null;
	}
	
	String type = null;
	
	if( session.getAttribute("type") != null ) {
		type = ( String ) session.getAttribute("type");
	} else {
		type = null;
	}
	
	String nickname = null;
	
	if( session.getAttribute("nickname") != null ) {
		nickname = ( String ) session.getAttribute("nickname");
	} else {
		nickname = null;
	}
	
	
  	if( id == null || type == null ||  nickname == null ) {
		out.println( "<script type = 'text/javascript'>");
		out.println( "alert( '로그인을 하셔야 합니다.'); " );
		out.println( "location.href='./loginPage.jsp';" );
		out.println( "</script>" );
	} 
	 

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마음가짐 일반회원 마이페이지</title>
	<link href="../resources/asset/css/bootstrap.min.css" rel="stylesheet" />
	<link href="../resources/asset/css/user.css" rel="stylesheet" />
	<link href="../resources/asset/css/review.css" rel="stylesheet" />
    <!-- Bootstrap icons-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
	
	<!-- review css -->
	<link href="../resources/asset/css/review.css" rel="stylesheet" />
	
	<link href="/resources/asset/css/templatemo-pod-talk.css" rel="stylesheet"/>
	<!--  header news -->
	<link rel="stylesheet" href="/resources/asset/css/news.css"/>
	
	
</head>
<body>
	
	<!-- header -->
	<jsp:include page="../include/header.jsp"/>
	
	<jsp:include page="../main/main_source/main_search.jsp" />
	
	<!-- 마이페이지 -->
	<jsp:include page="./user_source/user_content.jsp"/>
	
	<!-- modal -->
	<jsp:include page="./user_modal/memberModify_modal.jsp" />
	<jsp:include page="./user_modal/review_modal.jsp" />
	<jsp:include page="./user_modal/register_modal.jsp" />
	<jsp:include page="./user_modal/mypage_modify_modal.jsp" />
	
	<!-- footer -->
	<jsp:include page="../include/footer.jsp" />
	
	<!-- script -->
    <script src="../resources/asset/js/bootstrap.bundle.min.js" ></script>
	<script src="../resources/asset/script/jquery-1.11.1.min.js"></script>
    <script src="../resources/asset/js/owl.carousel.min.js"></script>
    <script src="../resources/asset/js/user.js"></script>
    
    <!--  header news -->
	<script src="/resources/asset/js/news.js"></script>
    
</body>
</html>