<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  	<script type ="text/javascript">
  	
	var IMP = window.IMP; // 생략 가능 
    IMP.init("imp40652523");

    	
    	function requestPay() {
    	
        // IMP.request_pay(param, callback) 결제창 호출
        IMP.request_pay({ // param
        	 pg: "kcp.T0000",
            pay_method: "card",
            merchant_uid: "11",
            name: "시청 비나이더피트니스",
            amount: "210,000",
            buyer_email: "gildong@gmail.com",
            buyer_name: "홍길동",
            buyer_tel: "010-4242-4242",
            buyer_addr: "서울특별시 강남구 신사동",
            buyer_postcode: "01181"
        }, function(rsp) {
			console.log(rsp);
		    if ( rsp.success ) {
		    	var msg = '결제가 완료되었습니다.';
		        msg += '고유ID : ' + rsp.imp_uid;
		        msg += '상점 거래ID : ' + rsp.merchant_uid;
		        msg += '결제 금액 : ' + rsp.paid_amount;
		        msg += '카드 승인번호 : ' + rsp.apply_num;
		    } else {
		    	 var msg = '결제에 실패하였습니다.';
		         msg += '에러내용 : ' + rsp.error_msg;
		    }
		    alert(msg);
		});
	} 
	</script>