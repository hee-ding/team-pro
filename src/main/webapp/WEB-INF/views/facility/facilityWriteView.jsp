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
	<link href="../resources/asset/css/bootstrap.min.css" rel="stylesheet" />
	<link href="../resources/asset/css/facility_list.css" rel="stylesheet" />
    <!-- Bootstrap icons-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <!-- script -->
    <script src="../resources/asset/js/bootstrap.bundle.min.js" ></script>
	<script src="../resources/asset/script/jquery-1.11.1.min.js"></script>
    <script src="../resources/asset/js/owl.carousel.min.js"></script>
    
    <!-- Summernote -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
	
	<link href="/resources/asset/css/templatemo-pod-talk.css" rel="stylesheet"/>
	<!--  header news -->
	<link rel="stylesheet" href="/resources/asset/css/news.css"/>
</head>
<body>
	
	<!-- header -->
	<jsp:include page="../include/header.jsp">
		<jsp:param name="userID" value="<%=userID%>" />
	</jsp:include>
	<jsp:include page="../main/main_source/main_search.jsp" />
	
	<!-- 운동시설 글쓰기 -->
	<jsp:include page="./facility_source/facility_write.jsp" />
	
	<!-- footer -->
	<jsp:include page="../include/footer.jsp" />
	
    
    <script>
	    $('#summernote').summernote({
	        height: 400,
	        lang: "ko-KR",
	        callbacks: {	//이미지 파일 첨부
	        	onImageUpload: function(files, editor, welEditable) {	
	        		// 다중 업로드를 위해 반복문 사용
	        		for( var i=files.length-1 ; i>=0 ; i--){
	        			uploadSummernoteImageFile(files[i], this);
	        		}
	        	},
	        	onPaste: function(e) {
	        		var clipboardData = e.originalEvent.clipboardData;
	        		if (clipboardData && clipboardData.items && clipboardData.items.length) {
	        			var item = clipboardData.items[i];
	        			if( item.kind == 'file' && item.type.indexOf( 'image/')!== -1) {
	        				e.preventDefault();
	        			}
	        		}
	        		
	        	} 
	        }
	    });
	    

		/**
		* 이미지 파일 업로드
		*/
 		function uploadSummernoteImageFile(file, editor) {
			data = new FormData();
			data.append("file", file);
			$.ajax({
				data : data,
				type : "POST",
	            cache: false,
	            contentType:false,
				url : "/uploadOk",
	            enctype: 'multipart/form-data',
				contentType : false,
				processData : false,
				success : function(data) {
	            	//항상 업로드된 파일의 url이 있어야 한다.
					$(editor).summernote('insertImage', data.url);
				}
			});
		}	 
    </script>
    
    <!--  header news -->
	<script src="/resources/asset/js/news.js"></script>
    
</body>
</html>