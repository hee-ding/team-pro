<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    	<script>
		$(document).ready(function(){
		  $("button1").click(function(){
		    $("small1").text("1개월");
		    $("div1").text("80,000원");
		  });
		  $("button2").click(function(){
	 	     $("small1").text("3개월");
		     $("div1").text("180,000원");
		  });
		  $("button3").click(function(){
		     $("small1").text("6개월");
	  	     $("div1").text("240,000원");
		  });
		  $("button4").click(function(){
		     $("small1").text("1년");
		     $("div1").text("299,000원");
		  });
		});
		</script>