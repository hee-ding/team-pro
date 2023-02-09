<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="com.to.board.FacilityDAO"%>
<%@page import="com.to.board.MemberShipTO"%>
<%@page import="com.to.member.MemberTO"%>
<%@page import="java.util.Map"%>
<%@page import="com.to.board.BoardTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	//System.out.println( request.getParameter( "dongAddr" ) );

	// facility_map.jsp에서 동 주소 받아오기
	String data = request.getParameter( "dongAddr" );
	if( request.getParameter( "dongAddr" ) == null ){
		data = "";
	}

 	FacilityDAO dao = new FacilityDAO();
	ArrayList facilityLists = dao.facility();
	
	BoardTO bto = new BoardTO();
	MemberTO mto = new MemberTO();
	MemberShipTO msto = new MemberShipTO();
	
	String tag ="";
	String title = "";
	String address = "";
	int price =  0; 
	StringBuilder sb = new StringBuilder();

	
	if( data == "") {
		for( int i=0; i<facilityLists.size(); i++ ){
			Map<String, Object> map0 = (Map<String, Object>) facilityLists.get(i);
			
			bto = (BoardTO) map0.get("bto"+(i+1));
			System.out.println(bto.getTitle());
			
			mto = (MemberTO) map0.get("mto"+(i+1));
			System.out.println(mto.getAddress());
			
			msto = (MemberShipTO) map0.get("msto"+(i+1));
			System.out.println(msto.getMembership_price());
			
			tag = bto.getTag();
			title = bto.getTitle();
			address = mto.getAddress();
			price =  msto.getMembership_price(); 
			System.out.println( tag);
			
		
			sb.append("	<div class='col'>");
			sb.append("		<div class='card shadow-sm'>");
			sb.append("			<a href='#'>");
			sb.append("			<img src='https://s3.ap-northeast-2.amazonaws.com/stone-i-dagym-centers/images/gyms/16016b1fe47123af04/Small)Xpine.jpg'class='card-img-top' alt='...'></a>");
			sb.append("			<span class='label-top'>" + tag + "</span>");
			sb.append("			<div class='card-body'>");
			sb.append("				<div class='clearfix mb-3'>");
			sb.append("					<span class='float-start badge rounded-pill bg'>" + String.format("￦%,d", price) + "</span>" );
			sb.append("					<span class='float-end'>");
			sb.append("						<a href='#' class='small text-muted'>Reviews</a>");
			sb.append("					</span>");
			sb.append("				</div>");
			sb.append("				<h5 class='card-title'>" + title + "</h5>");
			sb.append("				<span>" + address + "</span>");
			sb.append("				<p class='tab'>현위치와의 거리</p>");
			sb.append("				<div class='text-center my-4'>");
			sb.append("					<a href='#' class='btn btn-warning'>회원권 예약</a>");
			sb.append("				</div>");
			sb.append("			</div>");
			sb.append("		</div>");
			sb.append("	</div>"); 
			//System.out.println( sb.toString() );
		} 
	} else {
		System.out.println("*********");
		for( int i=0; i<facilityLists.size(); i++ ){
			Map<String, Object> map0 = (Map<String, Object>) facilityLists.get(i);
			
			bto = (BoardTO) map0.get("bto"+(i+1));
			System.out.println(bto.getTitle());
			
			mto = (MemberTO) map0.get("mto"+(i+1));
			System.out.println(mto.getAddress());
			
			msto = (MemberShipTO) map0.get("msto"+(i+1));
			System.out.println(msto.getMembership_price());
			
			tag = bto.getTag();
			title = bto.getTitle();
			address = mto.getAddress();
			price =  msto.getMembership_price(); 
			System.out.println( tag);
			//address = data;
			sb.append("	<div class='col'>");
			sb.append("		<div class='card shadow-sm'>");
			sb.append("			<a href='#'>");
			sb.append("			<img src='https://s3.ap-northeast-2.amazonaws.com/stone-i-dagym-centers/images/gyms/16016b1fe47123af04/Small)Xpine.jpg'class='card-img-top' alt='...'></a>");
			sb.append("			<span class='label-top'>" + tag + "</span>");
			sb.append("			<div class='card-body'>");
			sb.append("				<div class='clearfix mb-3'>");
			sb.append("					<span class='float-start badge rounded-pill bg'>" + String.format("￦%,d", price) + "</span>" );
			sb.append("					<span class='float-end'>");
			sb.append("						<a href='#' class='small text-muted'>Reviews</a>");
			sb.append("					</span>");
			sb.append("				</div>");
			sb.append("				<h5 class='card-title'>" + title + "</h5>");
			sb.append("				<span>" + address + "</span>");
			sb.append("				<p class='tab'>현위치와의 거리</p>");
			sb.append("				<div class='text-center my-4'>");
			sb.append("					<a href='#' class='btn btn-warning'>회원권 예약</a>");
			sb.append("				</div>");
			sb.append("			</div>");
			sb.append("		</div>");
			sb.append("	</div>"); 
			//System.out.println( sb.toString() );
		
			}
	}
	
%>
<script src="./resources/asset/script/jquery-1.11.1.min.js"></script>
<script src="./resources/asset/script/jquery-3.6.0.js"></script>	

<hr />
<!-- 내 주변 운동시설-->
<div class="container md-5" style="padding-left: 60px">
	<div class="current-menu container-xl">
		<a href="./homePage.jsp">홈</a> &gt; 내 주변 운동시설
	</div>
	<div class="current-location container-xl">
		<div class="desktop-location-view ng-star-inserted">
			<i class="bi bi-geo-alt" id="getAddr"><%=data %></i>
			<div class="btn-view float-end">
				<a href="./facilityMapPage.jsp" class="clickable"> 위치지정</a>
			</div>
		</div>
	</div>
</div>

<hr />

<!-- side navbar -->
<div class="container" style="padding-left: 60px">
	<div class="d-flex">
		<div class="d-flex flex-column flex-shrink-0 p-4">
			<span class="fs-3 pb-3 ">운동시설</span>
			<hr>
			<ul class="nav nav-pill flex-column mb-auto">
				<li class="nav-item "><a href="#"
					class="category nav-link active" aria-current="page">요가</a></li>
				<li class="nav-item"><a href="#" class="nav-link active "
					aria-current="page">수영</a></li>
				<li class="nav-item"><a href="#" class="nav-link active "
					aria-current="page">테니스</a></li>
				<li class="nav-item"><a href="#" class="nav-link active "
					aria-current="page">타바타</a></li>
				<li class="nav-item"><a href="#" class="nav-link active "
					aria-current="page">필라테스</a></li>
				<li class="nav-item"><a href="#" class="nav-link active "
					aria-current="page">골프</a></li>
				<li class="nav-item"><a href="#" class="nav-link active "
					aria-current="page">복싱</a></li>
				<li class="nav-item"><a href="#" class="nav-link active "
					aria-current="page">댄스</a></li>
			</ul>
		</div>

		<!-- 업체 목록 -->
		<!--  <div class="d-flex flex-column flex-wrap my-4 p-4"
		style="position: relative; max-width: 1500px; margin:0 auto;">
		-->

		<div class="row row-cols-1 row-cols-xs-2 row-cols-sm-2 row-cols-md-3 row-cols-lg-3">
			  <%=sb.toString() %> 
		</div>
	</div>
</div>
