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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <link href="../resources/asset/css/community.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../resources/asset/script/jquery-1.11.1.min.js"> </script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	  
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 
	 
	 <!--  header news -->
	<link rel="stylesheet" href="/resources/asset/css/news.css"/>
	
</head>
<body>

	<!--  header -->
	<jsp:include page="../include/header.jsp">
		<jsp:param name="id" value="<%= id %>"/>
	</jsp:include>
	
	<!--  search  -->
	<jsp:include page="../main/main_source/main_search.jsp" />
	
	<!-- modify 페이지 -->
	<jsp:include page="../community/community_source/community_delete_container1.jsp"/>
	

	<!-- footer -->
	<jsp:include page="../include/footer.jsp" />
	
	 	
	<script type = "text/javascript"> 
			window.onload = function () {
				document.getElementById('dbtn').onclick = function() {
				if (document.dfrm.password.value.trim() == ''){ // Javascript 
					alert('비밀번호를 입력하셔야 합니다.');
					return false;
				}
				document.dfrm.submit(); //검사가 따 끝나면submit 해서 다음으로 넘어가!
			};
		}
	</script>
	
	<!--  header news -->
	<script src="/resources/asset/js/news.js"></script>

</body>
</html>