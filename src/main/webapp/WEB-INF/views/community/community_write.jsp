<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String id = (String) session.getAttribute("id");
	String nickname = (String) session.getAttribute("nickname");
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
    <link href="./resources/asset/css/community.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="./resources/asset/script/jquery-1.11.1.min.js"> </script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	  
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 
	 <!-- 서머노트를 위해 추가해야할 부분  -->
	 <script src="./community/summerNote/summernote-lite.js"></script>
	 <script src="./community/summerNote/summernote-ko-KR.js"></script>
	 <link rel="stylesheet" href="./community/summerNote/summernote-lite.css">
</head>
<body>

	<!--  header -->
	<jsp:include page="../include/header.jsp">
		<jsp:param name="id" value="<%= id %>"/>
	</jsp:include>
	
	<!--  search  -->
	<jsp:include page="./community_source/main_search.jsp"/>
	
	<!-- write 페이지 -->
	<jsp:include page="./community_source/community_write_container1.jsp">
			<jsp:param name="id" value="<%= nickname %>"/>
	</jsp:include>

	<!-- footer -->
	<jsp:include page="../include/footer.jsp" />
	
	
	
	<script> // Jquery
		$('#summernote').summernote({
			  height: 450,
			  lang: "ko-KR"
			});
	 </script>
	 
	<script type = "text/javascript"> // Jquery
		   $("select[name=category]").change(function(){
			      
			    console.log( $("#category option:checked").text() );
			    console.log( $("#category option:checked").val() );
			    $("#category_seq").val($("#category option:checked").val());
			   });
	</script>
	
	<script type = "text/javascript"> 
		window.onload = function () {
			document.getElementById('wbtn').onclick = function() {
			// 필수 입력항목 검사 (not null인 목록들을 검사)
			
			//if ($("#category".val == '')){ //Jquery
			//	alert('카테고리를 선택하셔야 합니다.');
			//	return false;
			//}
			if (document.wfrm.subject.value.trim() == ''){ // Javascript 
				alert('제목을 입력하셔야 합니다.');
				return false;
			}
			document.wfrm.submit(); //검사가 따 끝나면submit 해서 다음으로 넘어가!
		};
	}
</script>
	

</body>
</html>