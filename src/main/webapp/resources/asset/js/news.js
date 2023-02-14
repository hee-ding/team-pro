$(document).ready(function( ){
	
	let newsClickHref =( $("#mypageHref").attr("href") );
	
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
			
			// time_stamp_diff < 1 ==> 몇초 전
			// 1 ~ 59 ==> 00 분전 		==> 1 < time_stamp_diff < 60
			// 1시간 ~ 24시간 ==> 1시간 전	==> 60 < time_stamp_diff < 1440
			// 하루 ~ 한달 ==> 				1440 < time_stamp_diff < 43,200
			
			if( time_stamp_diff < 1 ) {
				
				time_stamp_diff = "몇초 전";
				
			} else if( time_stamp_diff >= 1 && time_stamp_diff < 60 ) {
				
				time_stamp_diff = "약 " + time_stamp_diff + "분 전";
				
			} else if( time_stamp_diff >= 60 && time_stamp_diff < 1440 ) {
				
				time_stamp_diff = "약 " + Math.round( time_stamp_diff/60 ) + "시간 전";
				
			} else if( time_stamp_diff >= 1440 && time_stamp_diff < 43,200 ) {
				
				time_stamp_diff = "약 " + Math.round( time_stamp_diff/60/60 ) + "일 전";
				
			}
			
			if( result.data[i].type == '댓글' ) {
				if( result.data[i].read_check == 'N' ) {
					$('#newsList').append( "<li data-alert_id='" + i + "' class='list-group-item'><a class='text-decoration-none' href='#'><span class ='fw-bold'>" + result.data[i].req_member_name + "</span>님이 <span class ='fw-bold'>" + result.data[i].title + "</span> 글의 댓글을 작성했습니다.</a> <br /><a href='#' class='turn_off_alert text-decoration-none'>" + time_stamp_diff + "</a></li> " );
				} else if( result.data[i].read_check == 'Y' ) {
					$('#newsList').append( "<li data-alert_id='" + i + "' class='list-group-item'><a class='text-decoration-none' href='#'><span class ='text-black-50'>" + result.data[i].req_member_name + "</span>님이 <span class ='text-black-50'>" + result.data[i].title + "</span> 글의 댓글을 작성했습니다.</a> <br /><a href='#' class='turn_off_alert text-decoration-none text-black-50'>" + time_stamp_diff + "</a></li> " );
				}				
			} else if ( result.data[i].type == '리뷰' ) {
				if( result.data[i].read_check == 'N' ) {
					$('#newsList').append( "<li data-alert_id='" + i + "' class='list-group-item'><a class='text-decoration-none' href='/facility/" +  result.data[i].board_seq + "'><span class ='fw-bold'>" + result.data[i].req_member_name + "</span>님이 <span class ='fw-bold'>" + result.data[i].title + "</span> 회원권에 대한 리뷰를 작성했습니다.</a> <br /><span class='turn_off_alert text-decoration-none'>" + time_stamp_diff + "</span></li> " );
				} else if( result.data[i].read_check == 'Y' ) {
					$('#newsList').append( "<li data-alert_id='" + i + "' class='list-group-item'><a class='text-decoration-none' href='/facility/" +  result.data[i].board_seq + "'><span class ='text-black-50'>" + result.data[i].req_member_name + "님이</span> <span class ='text-black-50'>" + result.data[i].title + " 회원권에 대한 리뷰를 작성했습니다.</span> </a> <br /><span class='turn_off_alert text-decoration-none text-black-50'>" + time_stamp_diff + "</span></li> " );
				}
			} else if ( result.data[i].type == '승인요청' ) {
				if( result.data[i].read_check == 'N' ) {
					$('#newsList').append( "<li data-alert_id='" + i + "' class='list-group-item'><a class='text-decoration-none'  href='/news/" + result.data[i].news_seq +"' ><span class ='fw-bold'>" + result.data[i].req_member_name + "</span>님이 <span class ='fw-bold'>" + result.data[i].title + "</span> 회원권에 대한 승인 요청을 했습니다.</a> <br /><span class='turn_off_alert text-decoration-none'>" + time_stamp_diff + "</span></li> " );
				} else if( result.data[i].read_check == 'Y' ) {
					$('#newsList').append( "<li data-alert_id='" + i + "' class='list-group-item'><a class='text-decoration-none'  href='/news/" + result.data[i].news_seq +"' ><span class ='text-black-50'>" + result.data[i].req_member_name + "님이 </span><span class ='text-black-50'>" + result.data[i].title + " 회원권에 대한 승인 요청을 했습니다.</span> </a> <br /><span class='turn_off_alert text-decoration-none text-black-50'>" + time_stamp_diff + "</span></li> " );
				}					
			} else if ( result.data[i].type == '승인완료' ) {
				if( result.data[i].read_check == 'N' ) {
					$('#newsList').append( "<li data-alert_id='" + i + "' class='list-group-item'><a class='text-decoration-none' onclick='readNews(" +  result.data[i].news_seq + ")'>요청하신 <span class ='fw-bold'>" + result.data[i].title + "</span>회원권에 대한 승인이 완료되었습니다.</a> <br /><span class='turn_off_alert text-decoration-none'>" + time_stamp_diff + "</span></li> " );
				} else if( result.data[i].read_check == 'Y' ) {
					$('#newsList').append( "<li data-alert_id='" + i + "' class='list-group-item'><a class='text-decoration-none' onclick='readNews(" +  result.data[i].news_seq + ")'>요청하신 <span class ='text-black-50'>" + result.data[i].title + "회원권에 대한 승인이 완료되었습니다.</span></a> <br /><span class='turn_off_alert text-decoration-none text-black-50'>" + time_stamp_diff + "</span></li> " );
				}
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