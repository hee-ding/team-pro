$(document).ready(function( ){
	
	$.ajax({
	url: '/news',
	type: 'get',
	dataType: 'json',
	success: function( result ) {
		
		$('#unreadNews').text( result.unread_news );
		
		for( let i = 0; i < result.data.length; i++ ) {
			
			//console.log( result.data[i].time_stamp_diff );
			//console.log( result.data[i].time_stamp_diff / 60 );
			
			time_stamp_diff = result.data[i].time_stamp_diff;
			
			if( time_stamp_diff/60 < 1 ) {
				
				time_stamp_diff = "몇초 전";
				
			} else if( time_stamp_diff/60 > 1 && time_stamp_diff/60 < 60 ) {
				
				time_stamp_diff = Math.round( time_stamp_diff/60 ) + "분 전";
				
			} else if( time_stamp_diff/60 > 60 && time_stamp_diff/60 < 3600 ) {
				
				time_stamp_diff = Math.round( time_stamp_diff/60 ) + "시간 전";
			} else if( time_stamp_diff/60 > 3600 && time_stamp_diff/60 < 3600 ) {
				
				time_stamp_diff = Math.round( time_stamp_diff/60 ) + "일 전";
			}
			
			if( result.data[i].type == '댓글' ) {
				$('#newsList').append( "<li data-alert_id='" + i + "' class='list-group-item'><a class='text-decoration-none' href='#'><span class ='fw-bold'>" + result.data[i].req_member_name + "</span>님이 <span class ='fw-bold'>" + result.data[i].title + "</span> 글의 댓글을 작성했습니다.</a> <br /><a href='#' class='turn_off_alert text-decoration-none'>" + time_stamp_diff + "</a></li> " );				
			} else if ( result.data[i].type == '리뷰' ) {
				$('#newsList').append( "<li data-alert_id='" + i + "' class='list-group-item'><a class='text-decoration-none' href='#'><span class ='fw-bold'>" + result.data[i].req_member_name + "</span>님이 <span class ='fw-bold'>" + result.data[i].title + "</span> 회원권에 대한 리뷰를 작성했습니다.</a> <br /><a href='#' class='turn_off_alert text-decoration-none'>" + time_stamp_diff + "</a></li> " );
			} else if ( result.data[i].type == '승인요청' ) {
				$('#newsList').append( "<li data-alert_id='" + i + "' class='list-group-item'><a class='text-decoration-none' href='#'><span class ='fw-bold'>" + result.data[i].req_member_name + "</span>님이 <span class ='fw-bold'>" + result.data[i].title + "</span> 회원권에 대한 승인 요청을 했습니다.</a> <br /><a href='#' class='turn_off_alert text-decoration-none'>" + time_stamp_diff + "</a></li> " );
			} else if ( result.data[i].type == '승인완료' ) {
				$('#newsList').append( "<li data-alert_id='" + i + "' class='list-group-item'><a class='text-decoration-none' href='#'>요청하신 <span class ='fw-bold'>" + result.data[i].title + "</span> 회원권에 대한 승인이 완료되었습니다.</a> <br /><a href='#' class='turn_off_alert text-decoration-none'>" + time_stamp_diff + "</a></li> " );
			}
		}
		
		if( result.data.length == 0 ) {
			$('.alert_list').append( "아직 알림이 없습니다." );
		}
		
		newsList();
		
	},
	error: function(err) {
		alert( '[에러] ' + err.status);
	}
})

});

	function newsList( ) { 
	
		$('#news').popover({
		  'title' : '알림', 
		  'html' : true,
		  'placement' : 'bottom',
		  'content' : $('.alert_list').html()
		});
	
	};