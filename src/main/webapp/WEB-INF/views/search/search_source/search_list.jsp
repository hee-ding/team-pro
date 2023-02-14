<%@page import="com.maumgagym.dto.MemberShipTO"%>
<%@page import="com.maumgagym.dto.MemberTO"%>
<%@page import="com.maumgagym.dto.BoardTO"%>
<%@page import="com.maumgagym.dao.SearchDAO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	

	int categorySeq = 0;
	
	String search = null;
	search = (String)request.getAttribute( "data" ); 
	//System.out.println( "검색어 : " + search );
	
	if( request.getParameter( "category_seq" ) != null ) {
		categorySeq = Integer.parseInt( request.getParameter( "category_seq" ) );   // int형 변수 categorySeq에 대입
	}
	//System.out.println("category_seq : " + categorySeq);
	
 	SearchDAO dao = new SearchDAO();
	ArrayList searchLists = (ArrayList)request.getAttribute( "searchLists" );
	
	BoardTO bto = new BoardTO();
	MemberTO mto = new MemberTO();
	MemberShipTO msto = new MemberShipTO();
	
	StringBuilder sb = new StringBuilder();
	
	
	for( int i=0; i<searchLists.size(); i++ ){
		Map<String, Object> map0 = (Map<String, Object>) searchLists.get(i);
		
		bto = (BoardTO) map0.get("bto"+(i+1));
		//System.out.println("title : " + bto.getTitle());
		
		mto = (MemberTO) map0.get("mto"+(i+1));
		//System.out.println("address : " + mto.getAddress());
		
		msto = (MemberShipTO) map0.get("msto"+(i+1));
		//System.out.println("price : " + msto.getMembership_price());
		
		String title = bto.getTitle();
		int seq = bto.getSeq();
		String address = mto.getAddress();
		int price =  msto.getMembership_price(); 
		String tag = bto.getTag();
		String imageName = bto.getImage_name();
		//System.out.println( "tag : " + tag );
		String category = bto.getTopic();
		//System.out.println( "topic : " + topic );
		
		if( (search != null ) && (categorySeq == 0) ) {
			if( bto.getTitle().contains(search) || mto.getAddress().contains(search) || bto.getTopic().contains(search)  ) {
				sb.append("	<div class='col'>");
				sb.append("		<div class='card shadow-sm'>");
				sb.append("			<a href='/facility/" + seq + "'>");
				sb.append("			<img src='../upload/" + imageName + "' class='card-img-top' alt='...'></a>");
				sb.append("			<span class='label-top'>" + tag + "</span>");
				sb.append("			<div class='card-body'>");
				sb.append("				<div class='clearfix mb-3'>");
				sb.append("					<span class='float-start badge rounded-pill bg'>" + String.format("￦%,d", price) + "</span>" );
				sb.append("					<span class='float-end'>");
				sb.append("						<a href='/facility/" + seq + "#review' class='small text-muted'>Reviews</a>");
				sb.append("					</span>");
				sb.append("				</div>");
				sb.append("				<h5 class='card-title'>" + title + "</h5>");
				sb.append("				<span>" + address + "</span>");
				sb.append("				<div class='text-center my-4'>");
				sb.append("					<a href='#' class='btn btn-warning'>회원권 예약</a>");
				sb.append("				</div>");
				sb.append("			</div>");
				sb.append("		</div>");
				sb.append("	</div>"); 

			}
		} else if( (search != null ) && (categorySeq != 0 ) ) {
			if( ( categorySeq == bto.getCategory_seq() ) && ( bto.getTitle().contains(search) || mto.getAddress().contains(search) || bto.getTopic().contains(search) ) ) {
				sb.append("	<div class='col'>");
				sb.append("		<div class='card shadow-sm'>");
				sb.append("			<a href='/facility/" + seq + "'>");
				sb.append("			<img src='../upload/" + imageName + "' class='card-img-top' alt='...'></a>");
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
				sb.append("				<div class='text-center my-4'>");
				sb.append("					<a href='#' class='btn btn-warning'>회원권 예약</a>");
				sb.append("				</div>");
				sb.append("			</div>");
				sb.append("		</div>");
				sb.append("	</div>"); 
			}
		}
	}
	
%>
<hr />

<!-- side navbar -->
<div class="container" style="padding-left: 60px">
	<div class="d-flex">
		<div class="d-flex flex-column flex-shrink-0 p-4">
			<span class="fs-3 pb-3 ">운동시설</span>
			<hr>
			<ul class="nav nav-pill flex-column mb-auto">
				<li class="nav-item ">
					<a id="1" class="nav-link active" aria-current="page">피트니스</a>
				</li>
				<li class="nav-item ">
					<a id="2" class="nav-link active" aria-current="page">요가</a>
				</li>
				<li class="nav-item">
					<a id="3" class="nav-link active " aria-current="page">수영</a>
				</li>
				<li class="nav-item">
					<a id="4" class="nav-link active " aria-current="page">테니스</a>
				</li>
				<li class="nav-item">
					<a id="5" class="nav-link active " aria-current="page">타바타</a>
				</li>
				<li class="nav-item">
					<a id="6" class="nav-link active " aria-current="page">필라테스</a>
				</li>
				<li class="nav-item">
					<a id="7" class="nav-link active " aria-current="page">골프</a>
				</li>
				<li class="nav-item">
					<a id="8" class="nav-link active " aria-current="page">복싱</a>
				</li>
				<li class="nav-item">
					<a id="9" class="nav-link active " aria-current="page">댄스</a>
				</li>
			</ul>
		</div>

		<div class="container">
			<div class="row row-cols-3">
				  <%=sb.toString() %> 
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function() {

	$( "li" ).click(function() {
	
		//카테고리 클릭하면 해당 카테고리 번호(id) get
		let categorySeq = $(this).children("a").attr("id");
		
		//현재 url
		const urlStr = window.location.href;  // window.location.href : 현재 페이지 url
		const url =  new URL(urlStr);
		
		//파라미터 객체 생성  => 변경된 페이지 주소 반영
		const urlParams = url.searchParams;
		//객체 로그 확인
		//console.log( "urlParams : " + urlParams);
		
		// search 파라미터 확인
		//console.log( "search파라미터 : " + urlParams.has( "search") ); 
			
		// search O / category_seq X	  	  ==> 		  카테고리 번호 파라미터 추가
		if( urlParams.has( "search" ) && !( urlParams.has( "category_seq" ) ) ){ 

			urlParams.append( "category_seq", categorySeq );
			location.href = url
			console.log( url );
			
		// search O / category_seq O	  	  ==> 		  카테고리 번호 파라미터 변경
		} else if( urlParams.has( "search" ) && ( urlParams.has( "category_seq" ) ) ) {
			urlParams.set( "category_seq", categorySeq );
			location.href = url; 
			console.log( url );
		}
		
	});
});	
</script>