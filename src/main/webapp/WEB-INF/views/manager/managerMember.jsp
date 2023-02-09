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
        <link href="./resources/asset/css/bootstrap.min.css" rel="stylesheet" />
			
	    <link rel="stylesheet" href="./manager/manager_source/resources/css/perfect-scrollbar.css">
	    <link rel="stylesheet" href="./manager/manager_source/resources/css/app.css">
	    
	    <link rel="stylesheet" href="./manager/manager_source/resources/css/style.css">

	</head>
	
	<body>
	<jsp:include page="../include/headerManager.jsp">
		<jsp:param name="userID" value="<%= userID %>"/>
	</jsp:include>	
	

	<jsp:include page="./manager_source/managerMemberTable.jsp"/>

	
   	<!-- Bootstrap core JS-->
    <script src="./resources/asset/js/bootstrap.bundle.min.js" ></script>
    

    <script src="./manager/manager_source/resources/js/perfect-scrollbar.min.js"></script>

    <script src="./manager/manager_source/resources/js/simple-datatables.js"></script>
    
    <script src="./manager/manager_source/resources/js/main.js"></script>
    
    <script>
       // Simple Datatable
        let table1 = document.querySelector('#table1');
        let dataTable = new simpleDatatables.DataTable(table1);
    </script>
    
	</body>
</html>
