  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//String userID = null;
	String userID = request.getParameter("userID");
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
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
        <!-- Core theme CSS (includes Bootstrap)-->
        
	    <link rel="stylesheet" href="./resources/asset/css/owl.carousel.min.css"/>
	
	    <link rel="stylesheet" href="./resources/asset/css/owl.theme.default.min.css"/>
	
	    <link href="../resources/asset/css/templatemo-pod-talk.css" rel="stylesheet"/>

		<!--  header news -->
		<link rel="stylesheet" href="/resources/asset/css/news.css"/>
 
	</head>
	
	<body>
	<jsp:include page="../include/header.jsp">
		<jsp:param name="userID" value="<%= userID %>"/>
	</jsp:include>	
	<jsp:include page="../main/main_source/main_search.jsp" />
	
	
	<!-- main 컨텐츠 -->
	<jsp:include page="./customerCenter_source/customerCenter_view.jsp"/>
	<jsp:include page="../include/footer.jsp" />
	

    

    <!--Start of Tawk.to Script-->
	<script type="text/javascript">
	var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
	(function(){
	var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
	s1.async=true;
	s1.src='https://embed.tawk.to/63db0dc1474251287910ff29/1go7qrf3g';
	s1.charset='UTF-8';
	s1.setAttribute('crossorigin','*');
	s0.parentNode.insertBefore(s1,s0); 
	})();
	</script>
	<!--End of Tawk.to Script-->
	
	<!--  header news -->
	<script src="/resources/asset/js/news.js"></script> 
	</body>
</html>
