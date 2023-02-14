<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String userID = null;
	//String userID = request.getParameter("userID");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
		<title>Maumgagym</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../resources/asset/css/bootstrap.min.css" rel="stylesheet" />
	    <link rel="stylesheet" href="../resources/manager/css/bold.css">
	    <link rel="stylesheet" href="../resources/manager/css/perfect-scrollbar.css">
	    <link rel="stylesheet" href="../resources/manager/css/app.css">
	    <link rel="stylesheet" href="../resources/manager/css/Chart.min.css">

	   	<!-- Bootstrap core JS-->
	    <script src="../resources/asset/js/bootstrap.bundle.min.js" ></script>
	    <script src="../resources/manager/js/perfect-scrollbar.min.js"></script>
	    <script src="../resources/manager/js/apexcharts.js"></script>
	    <script src="../resources/manager/js/dashboard.js"></script>
	    <script src="../resources/manager/js/main.js"></script>
	   	<script src="../resources/manager/js/Chart.min.js"></script>
	    <script src="../resources/manager/js/custom_ui-chartjs.js"></script>
	</head>
	
	<body>
	<jsp:include page="../include/headerManager.jsp">
		<jsp:param name="userID" value="<%= userID %>"/>
	</jsp:include>	
	<jsp:include page="./manager_source/managerMainContainer_1.jsp"/>
<%-- 	<jsp:include page="./manager_source/managerMainContainer_2.jsp"/> --%>
	
	
    
	</body>
</html>
