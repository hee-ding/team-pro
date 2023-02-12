<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String id = null;
	
	if( (String) session.getAttribute("id") != null && !"null".equals( (String) session.getAttribute("id") ) ) {
		id = (String) session.getAttribute("id");
	} else {
		id = null;
	}

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
        
	    <link rel="stylesheet" href="./resources/asset/css/owl.carousel.min.css"/>
	
	    <link rel="stylesheet" href="./resources/asset/css/owl.theme.default.min.css"/>
	
	    <link href="./resources/asset/css/templatemo-pod-talk.css" rel="stylesheet"/>
	    
	    <style type="text/css">
	    
	    #news{margin : 10px 0px 0px 150px}
		.alert_list{font-size: 11px; color:grey}
		li.alert_li {
		  font-size: 11px; 
		  color:grey;
		  padding:10px 0px 2px 0px;
		  border-bottom: thin solid #c0c0c0;
		}
		li.alert_li:hover{background-color:#eee}
		.turn_off_alert{float:right;margin-bottom :1px}
		a.alert_message{color : grey}
		a.alert_message:hover{color : grey}
	    
	    </style>
	</head>
	
	<body>
	<jsp:include page="../include/header.jsp">
		<jsp:param name="id" value="<%= id %>"/>
	</jsp:include>	
	
	<jsp:include page="./main_source/main_search.jsp"/>
	
	<jsp:include page="../include/top.jsp" />
	
	<!-- main 컨텐츠 -->

	<jsp:include page="./main_source/main_view.jsp"/>


	<!-- /main 컨텐츠 -->
	<jsp:include page="../include/footer.jsp" />
	
   	<!-- Bootstrap core JS-->
    <script src="./resources/asset/js/bootstrap.bundle.min.js" ></script>
    
    <!-- JAVASCRIPT FILES -->
    <script src="./resources/asset/script/jquery-1.11.1.min.js"></script>
    <script src="./resources/asset/js/owl.carousel.min.js"></script>
    <script src="./resources/asset/js/custom.js"></script>
    
    <script>
    $(document).ready(function(data){
	    $("#news").popover({
    	  'title' : '알림', 
    	  'html' : true,
    	  'placement' : 'bottom',
    	  'content' : $(".alert_list").html()
    	});
    });
	</script>
	</body>
</html>
