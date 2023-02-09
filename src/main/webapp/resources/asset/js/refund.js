  
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
