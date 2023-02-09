<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<button onclick = "refund()">환불하기</button>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script><!-- jQuery CDN --->
	<script type="text/javascript">
	$(document).ready(function(){
	  function refund() {
	    jQuery.ajax({
	      "url": "{환불요청을 받을 서비스 URL}", // 예: http://www.myservice.com/payments/cancel
	      "type": "POST",
	      "contentType": "application/json",
	      "data": JSON.stringify({
	      }),
	      "dataType": "json"
	    });
	  }
	});
	</script>
</body>
</html>