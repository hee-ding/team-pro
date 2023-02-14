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
	
	
	
%>
 
<!DOCTYPE html>
<html>
   <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
		<title>Maumgagym</title>
  		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
  	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
		<script type ="text/javascript">
		</script>
        <!-- Bootstrap icons-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
	    <link rel="stylesheet" href="../resources/asset/css/owl.carousel.min.css"/>
	    <link rel="stylesheet" href="../resources/asset/css/owl.theme.default.min.css"/>
	    <link href="../resources/asset/css/templatemo-pod-talk.css" rel="stylesheet"/>
	    <!-- nav bar -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
        <!-- kakao  -->
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2f293c216237addee3e388f7900b458a&libraries=services"></script>
        <!-- icon -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
		<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Sharp:opsz,wght,FILL,GRAD@48,400,0,0" />
		<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
		<!-- star -->
		<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<!-- iamport.payment.js -->
		<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
		
		<link href="/resources/asset/css/templatemo-pod-talk.css" rel="stylesheet"/>
		<!--  header news -->
		<link rel="stylesheet" href="/resources/asset/css/news.css"/>
	        
	</head>
		
	<body>
		<jsp:include page="../include/header.jsp">
			<jsp:param name="id" value="<%= id %>"/>
		</jsp:include>	
		<jsp:include page="../main/main_source/main_search.jsp" />
		
		<jsp:include page="../pay/pay.jsp"/>
		
		<!-- main 컨텐츠 -->
	
		<jsp:include page="./view_source/view.jsp"/>
		<jsp:include page="../include/footer.jsp" />
		
		<!-- 세션값 전달 -->
		<jsp:include page="./view_source/pay.jsp">
			<jsp:param name="id" value="<%= id %>"/>
			<jsp:param name="type" value="<%= type %>"/>
			<jsp:param name="nickname" value="<%= nickname %>"/>
		</jsp:include>
	    
	    <script src="../resources/asset/js/view_jquery.js"></script>
	    
	    <!-- JAVASCRIPT FILES -->
	    <script src="../resources/asset/script/jquery-1.11.1.min.js"></script>
	    <script src="../resources/asset/js/owl.carousel.min.js"></script>
	    <script src="../resources/asset/js/custom.js"></script>
	    <script src="../resources/asset/js/facilityViewMap.js"></script>
	    
	    <!--  header news -->
		<script src="/resources/asset/js/news.js"></script>
		
	</body>
</html>
    