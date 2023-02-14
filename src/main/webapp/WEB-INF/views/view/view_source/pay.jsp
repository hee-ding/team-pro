<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<script type="text/javascript">
	
	$(document).ready(function(){
		$('#payBtn').on( 'click', function(){
			if( document.getElementById("memberShip").selectedIndex == 0 ) {
			    alert("회원권을 선택해주세요.");
			    return false;
				}
			$('#myModal').modal("show");
		});
		
		$("#paymentOk").on( 'click', function(){
			requestPayInfo();
		  });
		
		$("#paymentcancle").on( 'click', function(){
			alert("결제 취소를 눌렀습니다.");
		  });
		
		 const IMP = window.IMP; // 생략 가능
		 IMP.init("imp48848665"); // 예: imp00000000a
		 let msg;
		 let merchant_uid
		 let name
		 let amount
		 let buyer_seq
		 let buyer_email
		 let buyer_name
		 let buyer_tel
		 let buyer_addr
		 let buyer_postcode
		 let membership_seq
		  
		  function requestPayInfo() {
			let type = '<%=request.getParameter("type")%>';
			if(type=="null"){ 
		         alert("로그인 해주세요.");
		         return false;
		      } else if ( type == "C"){
			      alert("기업 회원은 불가능 합니다. 일반 회원만 가능합니다.");
			      return false;
		      }
			$.ajax({
				url: '/pay/information',
				type: 'get',
				data: {
					buyer_nickname : '<%=request.getParameter("nickname")%>',
					membership_seq : $("#memberShip option:checked").val()
				},
				dataType: 'json',
				success: function( jsonData ) {
					if( jsonData.flag == 0 ) {
					    //console.log( jsonData.flag );
						merchant_uid = jsonData.merchant_uid;
						name = jsonData.name;
						amount = jsonData.amount;
						buyer_seq = jsonData.buyer_seq;
						buyer_email = jsonData.buyer_email;
						buyer_name = jsonData.buyer_name;
						buyer_tel = jsonData.buyer_tel;
						buyer_addr = jsonData.buyer_addr;
						buyer_postcode = jsonData.buyer_postcode;
						
						requestPay();
						membership_seq = $("#memberShip option:checked").val();
					} else { alert( '서버 에러' ); }
				},
				error: function(err) { alert( '[에러] ' + err.status); } }); }
		 
		  function requestPay() {
		      
			    IMP.request_pay({
			      pg: "kcp.T0000",
			      pay_method: "card",
			      merchant_uid: merchant_uid,
			      name: name,
			      amount: amount/100, 
			      buyer_email: buyer_email,
			      buyer_name: buyer_name,
			      buyer_tel: buyer_tel,
			      buyer_addr: buyer_addr,
			      buyer_postcode: buyer_postcode
			    }, function (rsp) { // callback
			      if (rsp.success) {
			        // 결제 성공 시 로직
			          $.ajax({
			              url: "/pay",
			              type: "post",
			              data: {
			            	  imp_uid: rsp.imp_uid,
			                  merchant_uid: rsp.merchant_uid,
			                  pay_method: "card",
			                  membership_seq : membership_seq,
			                  buyer_seq : buyer_seq
			                  },
				          	  dataType: 'json', //서버에서 보내줄 데이터 타입
				          	  success: function( result ){
					        			        	
					          if(result.flag == 0){
								 console.log("추가성공");
								 location.href = "/pay/success";
								 
					          }else{
					             console.log("Insert Fail!!!");
					             console.log( window.location.href );
					             location.href = "/pay/fail";
					             
					          }
					        },
					        error:function(){
					          console.log("Insert ajax 통신 실패!!!");
					          location.href = "/pay/fail";
					        }
						}) //ajax
						
					} else{//결제 실패시
						var msg = '결제에 실패했습니다';
						msg += '에러 : ' + rsp.error_msg;
						console.log( window.location.href );
						location.href = "/pay/fail";
					}
					console.log(msg);
				});
			};
			
			function refundConfirm( data ) {
				
				console.log( data );	
						
				 $.ajax({
						url: "/refund/complate.jsp",
						type:"post",
						datatype:"json",
						contentType : 'application/x-www-form-urlencoded; charset = utf-8',
						data : {
							merchant_uid: data, // "{결제건의 주문번호}"
						}
					}).done(function(result){ //환불 성공
					
						console.log("환불 성공 : "+ result);
						
					}).fail(function(error){
						
						console.log("환불 실패 : "+ error);
					});//ajax
						
				};    
		          
	});
	</script>
	</head>
</html>