$(document).ready(function(data){
	
	$.ajax({
	url: '/news',
	type: 'get',
	dataType: 'json',
	success: function( result ) {
		
		$('#unreadNews').text( result.unread_news );
		
		for( let i = 0; i < result.data.length; i++ ) {
			//console.log( "<li data-alert_id='" + i + "' class='list-group-item'><a class='text-decoration-none' href='#'>" + result.data[i].req_member_name + "님이 " + result.data[i].title + "글의 댓글을 달았습니다.</a> <br /><a href='#' class='turn_off_alert text-decoration-none'>" + result.data[i].time_stamp_diff + "</a></li> " );
			$('#newsList').append( "<li data-alert_id='" + i + "' class='list-group-item'><a class='text-decoration-none' href='#'>" + result.data[i].req_member_name + "님이 " + result.data[i].title + "글의 댓글을 달았습니다.</a> <br /><a href='#' class='turn_off_alert text-decoration-none'>" + result.data[i].time_stamp_diff + "</a></li> " );
			
		}
		
	    $('#news').popover({
		  'title' : '알림', 
		  'html' : true,
		  'placement' : 'bottom',
		  'content' : $('.alert_list').html()
		});
				

	},
	error: function(err) {
		alert( '[에러] ' + err.status);
	}
})
	

});
