// 등록 승인 요청 관련
// [일반 회원] 멤버쉽 승인 요청
function membershipRegister( data ){ 
	$.ajax({
	url: '/membership/request',
	type: 'post',
	data: {
		merchant_uid : data.value,
		req_member_seq : $(data).next().val(),
		board_seq : $(data).next().next().val()
	},
	dataType: 'json',
	success: function( jsonData ) {
		if( jsonData.flag == 0 ) {
			
			$( data ).attr("disabled", true);			
			$( data ).removeClass( 'btn-primary' );
			$( data ).addClass( 'btn-secondary' );
			$( data ).text( '승인 대기 중입니다. 취소를 원하시면 운동시설에 연락하세요.' );
			
		} else {
			
			alert( '서버 오류' );
			
		}
	},
	error: function(err) {
		alert( '[에러] ' + err.status);
	}
});
	
}

// 등록 승인 관련
// [기어 회원] 멤버쉽 승인
let merchant_uid;
function registerConfirm( data  ){ 

	console.log( data.value );
	
	$('#registerConfirmMessage').text( data.id +" 님의 회원권을 정말로 승인 하시겠습니까?" );
	
	$('#registerModal').modal("show");
	
	merchant_uid = data.value;
}

$("#registerOk").on( 'click', function(){

	console.log( "registerOk" + merchant_uid );
	RegisterOk( merchant_uid );
	
  });

function RegisterOk( data ) { 
	$.ajax({
		url: '/membership/approve',
		type: 'put',
		data: {
			
			merchant_uid : data
		},
		dataType: 'json',
		success: function( jsonData ) {
			if( jsonData.flag == 0 ) {
				console.log( '성공' );
				location.reload();
			} else {
				alert( '실패' );
			}
		},
		error: function(err) {
			alert( '[에러] ' + err.status);
		}
	});
	}

// 홀딩 관련
// [기어 회원] 멤버쉽 정지
function pauseConfirm( data  ){ 
	$('#pauseConfirmMessage').text( data.id +" 님의 회원권을 정말로 중지 하시겠습니까?" );
	$('#pauseModal').modal("show");
	merchant_uid = data.value;
}

$("#pauseOk").on( 'click', function(){
	console.log( "pauseOk" + merchant_uid );
	pauseOk( merchant_uid );
	
  });

function pauseOk( data ) { 
	console.log( data );
	$.ajax({
	url: '/membership/pause',
	type: 'put',
	data: {
		merchant_uid : data
	},
	dataType: 'json',
	success: function( jsonData ) {
		if( jsonData.flag == 0 ) {
			console.log( '성공' );
			location.reload();
		} else if ( jsonData.flag == 1 ) {
			alert( '이전 회원권 중지 사용' );
		} else if ( jsonData.flag == 8 ) {
			alert( '비정상 입력' );
		} else {
			alert( '서버 오류' );
		}
	},
	error: function(err) {
		alert( '[에러] ' + err.status);
	}
});
	
}

// 재개 관련 
// [기업 회원] 멤버쉽 재개
function restartConfirm( data  ){ 

	$('#restartConfirmMessage').text( data.id +" 님의 회원권을 정말로 재개 하시겠습니까?" );
	
	$('#restartModal').modal("show");
	
	merchant_uid = data.value;
}

$("#restartOk").on( 'click', function(){

	//console.log( "restartOk" + merchant_uid );
	restartOk( merchant_uid );
	
  });


$("#restartcancle").on( 'click', function(){

	alert("결제 취소를 눌렀습니다.");
  });


function restartOk( data ) { 
	//console.log( data );
		$.ajax({
		url: '/membership/restart',
		type: 'put',
		data: {
			merchant_uid : data
		},
		dataType: 'json',
		success: function( jsonData ) {
			if( jsonData.flag == 0 ) {
				console.log( '성공' );
				location.reload();
			} else if ( jsonData.flag == 1 ) {
				alert( ' membership_hold 테이블 변경 오류' );
			} else if ( jsonData.flag == 2 ) {
				alert( 'membership_register 테이블 변경 오류' );
			} else if ( jsonData.flag == 8 ) {
				alert( '비정상 오류' );
			} else {
				alert( '서버 오류' );
			}
		},
		error: function(err) {
			alert( '[에러] ' + err.status);
		}
	});
}

// 환불 관련 
// [기업 회원] 멤버쉽 환불
let cancel_request_amount;

function refundConfirm( data ) {
	
	$('#refundConfirmMessage').text( data.id +" 님의 회원권을 정말로 환불 하시겠습니까?" );
	
	$('#refundModal').modal("show");
	
	merchant_uid = data.value;
	 
}; // refundConfirm 클릭


$("#refundOk").on( 'click', function(){

	console.log( "refundOk" + merchant_uid );
	refundOk( merchant_uid );
	
 });

function refundOk( data ) { 
	console.log( data );
	$.ajax({
	url: '/membership/refund',
	type: 'put',
	data: {
		merchant_uid : data
	},
	dataType: 'json',
	success: function( jsonData ) {
		if( jsonData.flag == 0 ) {
			
			console.log( '성공' );
			
			location.reload();
			
		} else {
			alert( '오류' );
		}
	},
	error: function(err) {
		alert( '[에러] ' + err.status);
	}
});
	
}

// 회원 정보 수정 관련
function memberModify( id, nickname ) {
	
	if ( $( "#inputNickName" ).val() == '' ) {
		alert( "변결할 닉네임을 입력하세요.");
		return false;
	}
	
	if ( $( "#inputBirthday" ).val() == '' ) {
		alert( "생년월일 정확히 입력하세요. (형식: yyyy-mm-dd)");
		return false;
	}
	
	if ( $( "#inputPhone" ).val() == '' ) {
		alert( "연락가능한 번호를 입력하세요.");
		return false;
	}
	
	if ( $( "#inputEmailAddress" ).val() == '' ) {
		alert( "이메일을 입력하세요.");
		return false;
	}
	
	if ( $( "#inputAddress" ).val() == '' ) {
		alert( "주소를 입력하세요. (형식: [06253] 서울특별시 강남구 역삼1동 강남대로 310) ");
		return false;
	}
	
	if ( $( "#inputPassword" ).val() == '' ) {
		alert( "현재 비밀번호를 선택하세요.");
		return false;
	}
	
	if ( $( "#inputPasswordConfirm" ).val() == '' ) {
		alert( "변결할 비밀번호를 선택하세요.");
		return false;
	}
	
	if( nickname != $( "#inputNickName" ).val() ) {
		$.ajax({
		url: '/member/nicknameCheck',
		type: 'post',
		data: {
			nickname : $('#inputNickName').val()
		},
		dataType: 'json',
		success: function( jsonData ) {
			if( jsonData.flag == 0 ) {
				
					console.log( '중복 없음 성공' );
				
					$('#memberModifyConfirmMessage').text( id +" 님 작성하신 내용으로 정말로 수정 하시겠습니까?" );
	
					$('#memberModifyModal').modal("show");
				
			} else {
				alert( '닉네임 중복 오류' );
			}
		},
		error: function(err) {
			alert( '[에러] ' + err.status);
		}
	});
	
	} else {
	
		$('#memberModifyConfirmMessage').text( id +" 님 작성하신 내용으로 정말로 수정 하시겠습니까?" );
		$('#memberModifyModal').modal("show");
	}
		
	 
};



$("#memberModifyOk").on( 'click', function(){

	memberModifyOk( ); 
	
 });


function memberModifyOk( ) { 
	
	$.ajax({
	url: '/mypage',
	type: 'put',
	data: {
		name : $('#inputName').val(),
		id :  $('#inputID').val(),
		nickname :  $('#inputNickName').val(),
		birthday :  $('#inputBirthday').val(),
		phone :  $('#inputPhone').val(),
		email :  $('#inputEmailAddress').val(),
		full_address :  $('#inputAddress').val(),
		password :  $('#inputPassword').val(),
		change_password :  $('#inputChangePassword').val()
	},
	dataType: 'json',
	success: function( jsonData ) {
		if( jsonData.flag == 0 ) {
						
			$('#mypageModifyModal').modal("show");
			//location.reload();
			
		} else if ( jsonData.flag == 1) {
			alert( '비밀번호 오류' );
		} else {
			alert( '서버 오류' );
		}
	},
	error: function(err) {
		alert( '[에러] ' + err.status);
	}
});
	
}


// 리뷰 작성 관련
// [일반 회원] 멤버쉽 만료에 따른 리뷰 작성
let content;
let writerSeq;
let starScore;
let boardSeq;
let merchantUid;

function reviewRegister( data, boardSeq, writerSeq, membershipName, imageName, address ) {
	$('#title').text( membershipName );
	$('#address').text( address );
	$("#membershipImage").attr("src","../upload/" + imageName + "");
	$('#reviewModal').modal("show");
	
	this.boardSeq = boardSeq;
	this.writerSeq = writerSeq;
	this.merchantUid = data.id;
} 



$("#reviewOk").on( 'click', function(){
	
	if ( $("input[name='rating']").is(':checked') == false ) {
		alert( "별점을 체크해 주세요.");
		return false;
	}
	
	if ( $("#message-text").val() == '' ) {
		alert( "내용을 작성해 주세요.");
		return false;
	}
	
	reviewRegisterOk( );
	
	$('#reviewModal').modal("hide"); 
	$('input[name=rating]').prop( 'checked', false );
	$("#message-text").val('');
	
 });
 
 function reviewRegisterOk( ) { 
	$.ajax({
	url: '/review/write',
	type: 'post',
	data: {
		merchant_uid : this.merchantUid,
		content : $("#message-text").val(),
		writer_seq : this.writerSeq,
		star_score :  $("input[name='rating']:checked").val(),
		board_seq : this.boardSeq
	},
	dataType: 'json',
	success: function( jsonData ) {
		if( jsonData.flag == 0 ) {
			
			$("#" + jsonData.merchant_uid).attr("disabled", true);			
			$("#" + jsonData.merchant_uid).removeClass( 'btn-primary' );
			$("#" + jsonData.merchant_uid).addClass( 'btn-secondary' );
			$("#" + jsonData.merchant_uid).text( '리뷰가 정상적으로 등록되었습니다.' );
			
			
		} else if ( jsonData.flag == 1) {
			alert( '입력 오류' );
			
		} else {
			alert( '서버 오류' );
		}
	},
	error: function(err) {
		alert( '[에러] ' + err.status);
	}
});
	
}