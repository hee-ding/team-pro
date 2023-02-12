$(document).ready(function(data){
    $("#news").popover({
    	  'title' : '알림', 
    	  'html' : true,
    	  'placement' : 'bottom',
    	  'content' : $(".alert_list").html()
    	});
});
