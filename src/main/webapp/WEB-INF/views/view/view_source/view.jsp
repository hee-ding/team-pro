<%@page import="org.apache.catalina.tribes.membership.Membership"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.el.lang.ELSupport"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.to.review.ReviewTO"%>
<%@page import="com.to.board.MemberShipTO"%>
<%@page import="com.to.member.MemberTO"%>
<%@page import="com.to.board.BoardTO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	
	request.setCharacterEncoding( "utf-8" );
	
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	
	//String strDong = request.getParameter( "seq" );	// 컨트롤러 또는 파라미터를 통해서 받음.
	String seq = "1";
	
	StringBuilder sbHtml = new StringBuilder();
	
	
	Map<String, Object> mainMap = null;
	
	try {
		
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup( "java:comp/env" );
		DataSource dataSource = (DataSource)envCtx.lookup( "jdbc/mariadb1" );
		
		conn = dataSource.getConnection();
		
		
		//System.out.println( "DB 연결 성공");
		
		StringBuilder sbBoardInfo = new StringBuilder();
		
		// 우선 글번호를 통해 기업정보를 가져옵니다.
		// member 테이블 - board 테이블 조인 후 select 
		sbBoardInfo.append( " select b.title, b.content, " );
		sbBoardInfo.append( " 	m.fulladdress, m.phone, avg( rv.star_score )" );
		sbBoardInfo.append( " 			from board b  " );
		sbBoardInfo.append( " 				left outer join member m on ( b.write_seq = m.seq ) " );
		sbBoardInfo.append( " 					right outer join review rv " );
		sbBoardInfo.append( " 						on( b.seq = rv.board_seq) " );
		sbBoardInfo.append( " 							where b.seq = ? " );
		
		
		// 변수에 대입합니다.
 		String sql = sbBoardInfo.toString(); 
 		
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, seq );
		
		rs = pstmt.executeQuery();
		
		
		// 각기 다른 TO를 넣기위함.
		mainMap = new HashMap<>();
		
		
		while( rs.next()) {
			
			// 글
			BoardTO bto = new BoardTO();
			bto.setTitle( rs.getString("b.title") );
			bto.setContent( rs.getString("b.content") );
			mainMap.put( "bto", bto );
			
			// 작성자(회원)
			MemberTO mto = new MemberTO();
			mto.setFullAddress( rs.getString("m.fulladdress") );
			mto.setPhone( rs.getString("m.phone") );
			mainMap.put( "mto", mto );
			
			// 리뷰
			ReviewTO rvto = new ReviewTO();
			rvto.setAvg_star_score( rs.getFloat("avg( rv.star_score )") );
			mainMap.put( "rvto", rvto );
			
		}
		
		
		StringBuilder sbMemberShip = new StringBuilder();
		
		// 우선 글번호를 통해 등록된 회원권 대한 정보를 가져옵니다.
		sbMemberShip.append( " select ms.seq, ms.name, ms.price, ms.period " );
		sbMemberShip.append( " 		from board b left outer join membership ms " );
		sbMemberShip.append( " 			on( b.seq = ms.board_seq) " );
		sbMemberShip.append( " 					where b.seq = ? " );
		
		// 변수에 대입합니다.
 		sql = sbMemberShip.toString(); 
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, seq );
		
		rs = pstmt.executeQuery();
		
		ArrayList<MemberShipTO> msList = new ArrayList<>();
		
		while( rs.next()) {
			// 멤버쉽에 대한 정보 가져오기
			MemberShipTO msto = new MemberShipTO();
			msto.setMembership_seq( rs.getInt("ms.seq") );
			msto.setMembership_name( rs.getString("ms.name") );
			msto.setMembership_price( rs.getInt("ms.price") );
			msto.setMembership_period( rs.getInt("ms.period") );
			
			msList.add(msto);
			
		}
		
		mainMap.put( "msList", msList);
		
		
		
		StringBuilder sbNotice = new StringBuilder();
		
		// 셀프 조인을 통해 업체가 작성한 공지함으로 가져옵니다.
		sbNotice.append( " select b2.title, b2.seq" );
		sbNotice.append( " 		from board b1 left outer join board b2 " );
		sbNotice.append( " 			on( b1.write_seq = b2.write_seq ) " );
		sbNotice.append( " 					where b2.category_seq = 13 or b2.category_seq = 14 and b1.seq = ? " );
		sbNotice.append( " 						order by b1.seq desc " );
		sbNotice.append( " 						limit 0, 4 " );
		
		// 변수에 대입합니다.
 		sql = sbNotice.toString(); 
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, seq );
		
		rs = pstmt.executeQuery();
		
		ArrayList<BoardTO> noticeList = new ArrayList<>();
		
		while( rs.next()) {
			
			BoardTO bto = new BoardTO();
			bto.setSeq( rs.getInt("b2.seq") );
			bto.setTitle( rs.getString("b2.title") );
			
			noticeList.add( bto );
			
		}
		
		mainMap.put("noticeList", noticeList);
		
		
		StringBuilder sbImage = new StringBuilder();
		
		// 조인을 통해 이미지 파일을 가져옵니다.
		sbImage.append( " select img.name " );
		sbImage.append( " 		from board b left outer join image img " );
		sbImage.append( " 			on (b.seq = img.board_seq ) " );
		sbImage.append( " 					where b.seq = ? " );
		
		// 변수에 대입합니다.
 		sql = sbImage.toString(); 
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, seq );
		
		rs = pstmt.executeQuery();
		
		
		ArrayList<BoardTO> imageList = new ArrayList<>();
		
		while( rs.next()) {
			
			BoardTO bto = new BoardTO();
			bto.setImage_name( rs.getString("img.name") );
			
			imageList.add( bto );
			
		}
		
		mainMap.put("imageList", imageList);
		
		
		
		StringBuilder sbReview = new StringBuilder();
		
		// 조인을 통해 리뷰를 가져옵니다.
		sbReview.append( " SELECT rv.content, rv.write_date, rv.star_score, m.nickname " );
		sbReview.append( " 		FROM review rv " );
		sbReview.append( " 			LEFT OUTER JOIN board b " );
		sbReview.append( " 					ON ( rv.board_seq = b.seq ) left outer join member m" );
		sbReview.append( " 					ON ( rv.writer_seq = m.seq )" );
		sbReview.append( " 						where rv.board_seq = ? AND rv.status = 1" );
		
		// 변수에 대입합니다.
 		sql = sbReview.toString(); 
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, seq );
		
		rs = pstmt.executeQuery();
		
		ArrayList<ReviewTO> reviewList = new ArrayList<>();
		
		while( rs.next()) {
			
			ReviewTO rvto = new ReviewTO();
			rvto.setNickname( rs.getString("m.nickname") );
			rvto.setContent( rs.getString("rv.content") );
			rvto.setWrite_date( rs.getString("rv.write_date") );
			rvto.setStar_score( rs.getFloat( "rv.star_score"));
			
			reviewList.add(rvto);
			
			
		}
		
		mainMap.put("reviewList", reviewList);
		
		
		
	} catch( NamingException e) {
		System.out.println( e.getMessage());
	} catch( SQLException e) {
		System.out.println( e.getMessage());
	} finally {
		if( pstmt != null) try {pstmt.close();} catch(SQLException e) {}
		if( conn != null) try {conn.close();} catch(SQLException e) {}
		if( rs != null) try {rs.close();} catch(SQLException e) {}
	}
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// DB 커넥션 결과 담은 것을 출력하기 위함.
	// 추후 DAO 클래스로 분리할 것
	
	// 글 관련
	BoardTO bto = (BoardTO) mainMap.get( "bto" );
	String title = bto.getTitle();
	
	// 글을 등록한 업체 관련 
	MemberTO mto = (MemberTO) mainMap.get( "mto" );
	String fullAdress = mto.getFullAddress();
	String phone = mto.getPhone();
	
	// 리뷰 관련
	ReviewTO rvto = (ReviewTO) mainMap.get("rvto");
	Float avgStarScore = rvto.getAvg_star_score();
	
	int floatStarCountIntConvert = (int) (avgStarScore * 10);

 	// 회원권 관련
 	ArrayList<MemberShipTO> msList = (ArrayList) mainMap.get( "msList" );
 	
 	StringBuilder sbMembershipInfo = new StringBuilder();
 	
 	// 회원권에 대한 selectBox 순서대로 만들기 위함.
 	int selectLopNum = 0;
  	for( MemberShipTO msto : msList ) {
  		selectLopNum++;
  		sbMembershipInfo.append( "<option value='" + msto.getMembership_seq() +"'>" + msto.getMembership_period() + "개월권" +"</option>" );
 	}
  	
  	// 공지 관련
  	 ArrayList<BoardTO> noticeList = (ArrayList) mainMap.get("noticeList");
  	
  	// 이미지 관련
  	 ArrayList<BoardTO> imageList = (ArrayList) mainMap.get("imageList");
  	
  	// 이미지 
  	BoardTO btoMainImage = imageList.get(0);
  	
  	
  	StringBuilder sbMembershipPriceInfo = new StringBuilder();
  	
  	
  	int priceLopNum = 0;
  	for( MemberShipTO msto : msList ) {
  		priceLopNum ++;	
  		sbMembershipPriceInfo.append( "<tr id=view" + priceLopNum + " style='display: none;'>" );
  		sbMembershipPriceInfo.append( "		<td height='30' align='left'>" );
  		sbMembershipPriceInfo.append( "		<br>" );
  		sbMembershipPriceInfo.append( "			<p class='text-primary'>" );
  		sbMembershipPriceInfo.append( "				마음가짐 회원가&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;<span class='fw-bold'>" + String.format("%,d 원", msto.getMembership_price()) + "</span>" );
  		sbMembershipPriceInfo.append( "			</p>" );
  		sbMembershipPriceInfo.append( "			<hr><br></td>" );
  		sbMembershipPriceInfo.append( "	</tr>" );
  		
  	}
  	
  	// 리뷰 관련
  	 ArrayList<ReviewTO> reviewList = (ArrayList) mainMap.get("reviewList");
  	
  	StringBuilder sbReviewInfo = new StringBuilder();
  	
  	
	//Float avgStarScore = rvto.getAvg_star_score();
	
	//int floatStarCountIntConvert = (int) (avgStarScore * 10);
	
	
  	
  	for( ReviewTO rvto2 : reviewList ) {
  		
  		String nickname = rvto2.getNickname();
  		String writeDate = rvto2.getWrite_date();
  		String content = rvto2.getContent();
  		
  		Float starScore = rvto2.getStar_score();
  		int floatStarCountIntConvert2 = (int) (starScore * 10);
  		
		int j = 0;
		
		
  		
		sbReviewInfo.append( "	 	<div class='d-flex justify-content-between mb-2'>");
		sbReviewInfo.append( "  		<div class='d-flex flex-row align-items-center'>");
		sbReviewInfo.append( "    			<span class='small mb-0 ms-2'><i class='material-icons'>account_circle</i>&nbsp;" + nickname +"1</span> <span class='text-end'></span>");
		sbReviewInfo.append( "	  		</div>");
		sbReviewInfo.append( "	  		<div class='d-flex flex-row align-items-center'>");
		sbReviewInfo.append( "	    		<small>&nbsp;" + writeDate +"</small>");
	 	sbReviewInfo.append( " 		</div>");
	 	sbReviewInfo.append( "		</div>");
		
	 	sbReviewInfo.append( "		<div class='d-flex justify-content-between mb-3'>");
	 	sbReviewInfo.append( "			<div class='d-flex flex-row align-items-center'>");
	 	sbReviewInfo.append( "				<p class='small mb-0 ms-2'> " + content +" </p>");
	 	sbReviewInfo.append( "			</div>");
	 	sbReviewInfo.append( "			<div class='d-flex flex-row align-items-center'>");
	 	
		for( int i = 1; i <= 5; i++ ) { 
		if( i <= floatStarCountIntConvert2 / 10 ) {
			
			sbReviewInfo.append( "		<i class='material-icons' style='color:#FFCD3C'>star</i> ");
			
		} else {  
			
				if( floatStarCountIntConvert2 % 10 == 5 && j != 1 ) {
					
				j++;
				i++;
				
				sbReviewInfo.append( "	<i class='material-icons' style='color:#FFCD3C'>star_half</i> ");
				
			}	  
				
				sbReviewInfo.append( "<i class='material-icons' style='color:#c3c5c5'>star_border</i> ");
			};
				
		}; 
		sbReviewInfo.append( "			</div>");
	 	sbReviewInfo.append( "		</div>");
	 	sbReviewInfo.append( "		<hr>");
  		
  		
  		
  	}

%>
	
<hr>
<br>
<br>

<div class="container">
	<!-- Content here -->


	<div class="container mb-5">
		<div class="row justify-content-center">

			<div class="col-lg-10 col-12">
				<div class="row">
					<div class="col-lg-5 col-12">
						<div class="custom-block-icon-wrap">
							<div
								class="custom-block-image-wrap custom-block-image-detail-page mb-5">
								<img src="./upload/<%=btoMainImage.getImage_name()%>" class="custom-block-image img-fluid mb-5"> 
								<div class="mb-2 pb-3">
									<span class="material-symbols-outlined">Home</span><small class="text-muted">&nbsp;<%= fullAdress %></small>
								</div>
								<div class="mb-2 pb-3">
									<span class="material-symbols-outlined">phone_in_talk</span><span class="text-muted">&nbsp;<%= phone %></span>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-7 col-12">
						<div class="custom-block-info">
<!-- 찜하기&링크 -->
							<div class="mb-2 pb-3">
									<!-- 업체이름 -->
								<h3 class="mb-3">
									<%= title %>
								</h3>
							
							<!-- 별 문제 -->
								<div class="mb-2 pb-3">
									<% 
										int j = 0;
										for( int i = 1; i <= 5; i++ ) { 
									%>
									
									<% 		if( i <= floatStarCountIntConvert / 10 ) { %>
									
												<i class="material-icons" style="font-size:48px;color:#FFCD3C">star</i>
												
									<% 		} else {  
													if( floatStarCountIntConvert % 10 == 5 && j != 1 ) {
													j++;
													i++;
									%>					
													<i class="material-icons" style="font-size:48px;color:#FFCD3C">star_half</i>
									<% 					
												}	  
									%>	
												<i class="material-icons" style="font-size:48px;color:#c3c5c5">star_border</i>
								 	<% 			
								 				};
											};
									%>
								 	
								</div>
							</div>
							<div class="text-end mb-5">
							    <i class="bi-heart" style="font-size:25px; color: red; cursor: pointer;"></i>
								&nbsp;
								<span class="material-symbols-outlined"> share </span>
							</div>
							<div class="mb-2 pb-3">
							<div class="mb-2 pb-3">
								<p class="fw-bold">옵션 선택</p>
							<select id="memberShip" name= "memberShip" onChange="change(this.options[this.selectedIndex].text)" class="form-select" aria-label="Default select example">
							 <option>이용권을 선택하세요.</option>
							 
							<%= sbMembershipInfo.toString() %>
							</select>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<hr>
<br><br>
<!-- 여기서부터 중간페이지 -->
<div class="container">

	<div class="container">
		<div class="row">
		
<!-- 여기서부터 col-8 -->
			<div class="col-8">


				<div class="card text-start">
					<div class="card-header">
						<strong>시설정보</strong>
					</div>
					<div class="card-body">
						<h6>공지사항</h6>
						<div class="row">
						<%	for ( BoardTO btoNotice : noticeList ) { %>
							
							<a href="./view.jsp?%<%=btoNotice.getSeq()%>"><br>- <%=btoNotice.getTitle() %></a>
						
						<% 	} %>
						</div>
						<hr>
						<h6>운영시간 및 운동시설 소개</h6>
						<div class="card">
							<div class="card-body ">
								<p class="text-center">
								<%= bto.getContent() %>
								</p>
							</div>
						</div>
						<div class="row">
							<div><br>[평 일] 06:00~24:00</div>
							<div><br>[주 말] 10:00~19:00</div>
							<div><br>[공휴일] 10:00~19:00</div>
						</div>
						<hr>
						<br>
						<h6>사진</h6>
						<div class="row">
							<div class="table-responsive">
								<table
									class="table text-center border-light table-borderless table-sm">
									<thead class="border-light">
										<tr>
										<th scope="col">
										<br>
										<!-- 사진 -->
											<%	for ( BoardTO btoImage : imageList ) { %>
											<div class="custom-block-icon-wrap mb-5">
												<div
													class="custom-block-image-wrap custom-block-image-detail-page">
													
													<img src="./upload/<%=btoImage.getImage_name()%>" class="custom-block-image img-fluid">
												</div>
											</div> 
											<% 	} %>
											<br>
										</tr>
									</thead>
								</table>
							</div>
						</div>
						<hr>
						<br>
						<h6>지도</h6>
						<div class="row">
						<!-- 요 부분이 살아 있어야 중앙에 들어감 -->
							<div class="table-responsive">
								<table class="table text-center border-light table-borderless table-sm">
									<thead class="border-light">
										<tr>
											<th scope="col"></th>
										</tr>
									</thead>
								</table>
							</div>
								<!-- 요 부분이 살아 있어야 중앙에 들어감 -->
						</div>
					</div>
					<!-- 이용후기 부분 -->
					<div class="card-footer text-muted">
						<div class="card-body">
							<h6>이용후기</h6>

							<div class="row">

								<div class="table-responsive">
								
										<div class="card mb-4 card-comment">
						                  <div class="card-body">
											<%=sbReviewInfo.toString() %> 
						                  </div>
						                </div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

<!-- 여기까지 col-8 -->
<!-- 여기서부터 col-4 -->

			<div class="col-4">
				<div class="card sticky-top" style="width: 20rem;">
					<div class="card-header">예상결제가격</div>
					<ul class="list-group list-group-flush text-center">

								<table width="320" border="0" cellpadding="0">
								<%= sbMembershipPriceInfo.toString() %>
								</table>

								<!-- 장바구니 결제버튼 -->
						<li class="list-group-item">
							<div class="d-grid gap-3">
								<button type="button" class="btn btn-outline-primary btn-block">카트담기</button>
							</div>
							<p></p>
							<div class="d-grid gap-3">
							<button id="payBtn" type="button" class="btn btn-primary btn-block">결제하기</button>
							</div>
						</li>
					</ul>
				</div>
			</div>
			
			<!-- 여기까지 col-4 -->
		</div>
	</div>
</div>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>

<div class="container">
	<div class="row">
		<div class="col-lg-12 col-12">
			<div class="section-title-wrap mb-5">
				<h4 class="section-title">근처 비슷한 운동시설</h4>
			</div>
		</div>
		<div class="col-lg-4 col-12 mb-4 mb-lg-0">
			<div class="custom-block custom-block-full">
				<div class="custom-block-image-wrap">
					<a href="detail-page.html"> <img
						src="./resources/asset/images/main_view/main_carousel/4K6CDVVNJWHwtbMbSDrGaEXeqcKCw9WX4pvJxvnepvUP.jpg"
						class="custom-block-image img-fluid" alt="">
					</a>
				</div>
				<div class="custom-block-info">
					<h5 class="mb-2">
						<a href="detail-page.html"> Vintage Show </a>
					</h5>
					<div class="profile-block d-flex">
						<img src="images/profile/woman-posing-black-dress-medium-shot.jpg"
							class="profile-block-image img-fluid" alt="">
						<p>
							Elsa <strong>Influencer</strong>
						</p>
					</div>
					<p class="mb-0">Lorem Ipsum dolor sit amet consectetur</p>
					<div
						class="custom-block-bottom d-flex justify-content-between mt-3">
						<a href="#" class="bi-headphones me-1"> <span>100k</span>
						</a> <a href="#" class="bi-heart me-1"> <span>2.5k</span>
						</a> <a href="#" class="bi-chat me-1"> <span>924k</span>
						</a>
					</div>
				</div>
				<div class="social-share d-flex flex-column ms-auto">
					<a href="#" class="badge ms-auto"> <i class="bi-heart"></i>
					</a> <a href="#" class="badge ms-auto"> <i class="bi-bookmark"></i>
					</a>
				</div>
			</div>
		</div>
		<div class="col-lg-4 col-12 mb-4 mb-lg-0">
			<div class="custom-block custom-block-full">
				<div class="custom-block-image-wrap">
					<a href="detail-page.html"> <img
						src="./resources/asset/images/main_view/main_carousel/4K6CDVVNJWHwtbMbSDrGaEXeqcKCw9WX4pvJxvnepvUP.jpg"
						class="custom-block-image img-fluid" alt="">
					</a>
				</div>
				<div class="custom-block-info">
					<h5 class="mb-2">
						<a href="detail-page.html"> Vintage Show </a>
					</h5>
					<div class="profile-block d-flex">
						<img src="images/profile/cute-smiling-woman-outdoor-portrait.jpg"
							class="profile-block-image img-fluid" alt="">
						<p>
							Taylor <img src="images/verified.png"
								class="verified-image img-fluid" alt=""> <strong>Creator</strong>
						</p>
					</div>

					<p class="mb-0">Lorem Ipsum dolor sit amet consectetur</p>
					<div
						class="custom-block-bottom d-flex justify-content-between mt-3">
						<a href="#" class="bi-headphones me-1"> <span>100k</span>
						</a> <a href="#" class="bi-heart me-1"> <span>2.5k</span>
						</a> <a href="#" class="bi-chat me-1"> <span>924k</span>
						</a>
					</div>
				</div>
				<div class="social-share d-flex flex-column ms-auto">
					<a href="#" class="badge ms-auto"> <i class="bi-heart"></i>
					</a> <a href="#" class="badge ms-auto"> <i class="bi-bookmark"></i>
					</a>
				</div>
			</div>
		</div>
		<div class="col-lg-4 col-12">
			<div class="custom-block custom-block-full">
				<div class="custom-block-image-wrap">
					<a href="detail-page.html"> <img
						src="./resources/asset/images/main_view/main_carousel/4K6CDVVNJWHwtbMbSDrGaEXeqcKCw9WX4pvJxvnepvUP.jpg"
						class="custom-block-image img-fluid" alt="">
					</a>
				</div>
				<div class="custom-block-info">
					<h5 class="mb-2">
						<a href="detail-page.html"> Daily Talk </a>
					</h5>
					<div class="profile-block d-flex">
						<img
							src="images/profile/handsome-asian-man-listening-music-through-headphones.jpg"
							class="profile-block-image img-fluid" alt="">
						<p>
							William <img src="images/verified.png"
								class="verified-image img-fluid" alt=""> <strong>Vlogger</strong>
						</p>
					</div>
					<p class="mb-0">Lorem Ipsum dolor sit amet consectetur</p>
					<div
						class="custom-block-bottom d-flex justify-content-between mt-3">
						<a href="#" class="bi-headphones me-1"> <span>100k</span>
						</a> <a href="#" class="bi-heart me-1"> <span>2.5k</span>
						</a> <a href="#" class="bi-chat me-1"> <span>924k</span>
						</a>
					</div>
				</div>
				<div class="social-share d-flex flex-column ms-auto">
					<a href="#" class="badge ms-auto"> <i class="bi-heart"></i>
					</a> <a href="#" class="badge ms-auto"> <i class="bi-bookmark"></i>
					</a>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
</div>




