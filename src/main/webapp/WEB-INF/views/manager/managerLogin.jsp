<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>Maumgagym</title>
	    <link href="../resources/asset/css/login_custom.css" rel="stylesheet"/>
	    
	    
	</head>
	
	<body>

	<jsp:include page="./manager_source/managerLoginForm.jsp"/>
	
    <script src="../resources/asset/script/jquery-1.11.1.min.js"></script>
   	<!-- Bootstrap core JS-->
    <script src="../resources/asset/js/bootstrap.bundle.min.js" ></script>
    

<script>
	$(document).ready(function(){
	    $("#loginBtn").click(function(){        
	        $("#loginForm").submit(); 
	    });
	});
</script>
</body>
</html> 