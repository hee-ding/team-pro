<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String userID = null;
	//String userID = request.getParameter("userID");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="./resources/asset/css/bootstrap.min.css" rel="stylesheet" />
	<link href="./resources/asset/css/facility_list.css" rel="stylesheet" />
    <!-- Bootstrap icons-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <!-- script -->
    <script src="./resources/asset/js/bootstrap.bundle.min.js" ></script>
	<script src="./resources/asset/script/jquery-1.11.1.min.js"></script>
    <script src="./resources/asset/js/owl.carousel.min.js"></script>
    
    <!-- Summernote -->
	<script src="./facility/facility_source/summernote/summernote-lite.js"></script>
	<script src="./facility/facility_source/summernote/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="./facility/facility_source/summernote/summernote-lite.css">  
</head>
<body>
	
	<!-- header -->
	<jsp:include page="../include/header.jsp">
		<jsp:param name="userID" value="<%=userID%>" />
	</jsp:include>
	<jsp:include page="../main/main_source/main_search.jsp">
		<jsp:param name="userID" value="<%=userID%>" />
	</jsp:include>
	
	<!-- 운동시설 글쓰기 -->
	<jsp:include page="./facility_source/facility_write.jsp" />
	
	<!-- footer -->
	<jsp:include page="../include/footer.jsp" />
	
    
    <script>
	    $('#summernote').summernote({
	        height: 400,
	        lang: "ko-KR"
	    });
    </script>
    
</body>
</html>