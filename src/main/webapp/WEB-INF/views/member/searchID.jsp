<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
		<title>Maumgagym</title>
	    <link href="../resources/asset/css/search_custom.css" rel="stylesheet"/>
	    <script src="http://code.jquery.com/jquery-latest.js"></script> 
	</head>
	
	<body>
	<jsp:include page="./searchID_source/searchID_form.jsp"/>
	</body>
	
	<script>
	$(document).ready(function(){ 
   	 $("#loginBtn").click(function() {
   		 $("#fIdFrm").submit(); 
   		 });
 	 });
	</script>
	
</html> 