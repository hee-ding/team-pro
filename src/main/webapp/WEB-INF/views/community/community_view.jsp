<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String id = (String) session.getAttribute("id");
%> 
<!DOCTYPE html>
<html>
<head>
	<link rel="icon" href="data:;base64,iVBORw0KGgo=">
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0, maximum-scale=1.0"/>
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Bootstrap icons-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <link href="./resources/asset/css/notification.css" rel="stylesheet" type="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>Document</title>
	<style type ="text/css">
	</style>
	<script type="text/javascript" src="./resources/asset/script/jquery-1.11.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<script type ="text/javascript">
	</script>
	<script src="https://kit.fontawesome.com/38f6d5c6ab.js" crossorigin="anonymous"></script>
	
</head>
<body>

	<!--  header -->
	<jsp:include page="../include/header.jsp">
		<jsp:param name="id" value="<%= id %>"/>
	</jsp:include>
	
	<!--  search  -->
	<jsp:include page="./community_source/main_search.jsp"/>
	
	<!-- view 페이지 -->
	<jsp:include page="./community_source/community_view_container1.jsp"/>
	
 	<script>
        var i = 0;
        $('i').on('click',function(){
            if(i==0){
                $(this).attr('class','bi-heart-fill');
                i++;
            }else if(i==1){
                $(this).attr('class','bi-heart');
                i--;
            }

        });

    </script>
	<!-- footer -->
	<jsp:include page="../include/footer.jsp" />

</body>
</html>