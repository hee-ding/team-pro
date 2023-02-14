<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.maumgagym.dto.ReviewTO"%>
<%@page import="com.maumgagym.dto.MemberShipTO"%>
<%@page import="com.maumgagym.dto.MemberTO"%>
<%@page import="com.maumgagym.dto.BoardTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	
	request.setCharacterEncoding( "utf-8" );
	
	Map<String, Object> map = (HashMap) request.getAttribute("map");
	
 	// 글 관련
	BoardTO bto = (BoardTO) map.get( "bto" );
	String title = bto.getTitle();
	// 글을 등록한 업체 관련 
	MemberTO mto = (MemberTO) map.get( "mto" );
	String fullAdress = mto.getFullAddress();
	String phone = mto.getPhone();
	// 리뷰 관련
	ReviewTO rvto = (ReviewTO) map.get("rvto");
	Float avgStarScore = rvto.getAvg_star_score();
	int floatStarCountIntConvert = (int) (avgStarScore * 10);
 	// 회원권 관련
 	ArrayList<MemberShipTO> msList = (ArrayList) map.get( "membershipList" );
 	StringBuilder sbMembershipInfo = new StringBuilder();
 	int selectLopNum = 0;
  	for( MemberShipTO msto : msList ) {
  		selectLopNum++;
  		sbMembershipInfo.append( "<option value='" + msto.getMembership_seq() +"'>" + msto.getMembership_period() + "개월권" +"</option>" );
 	}
  	// 공지 관련
  	 ArrayList<BoardTO> noticeList = (ArrayList) map.get("noticeList");
  	// 이미지 관련
  	 ArrayList<BoardTO> imageList = (ArrayList) map.get("imageList");
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
  		sbMembershipPriceInfo.append( "				마음가짐 회원가&emsp;&emsp;&emsp;&emsp;<span class='fw-bold'>" + String.format("%,d 원", msto.getMembership_price()) + "</span>" );
  		sbMembershipPriceInfo.append( "			</p>" );
  		sbMembershipPriceInfo.append( "		<hr></td>" );
  		sbMembershipPriceInfo.append( "	</tr>" );
  	}
  	
  	// 리뷰 관련
  	 ArrayList<ReviewTO> reviewList = (ArrayList) map.get("reviewList");
  	
  	StringBuilder sbReviewInfo = new StringBuilder();
  	
  	for( ReviewTO rvto2 : reviewList ) {
  		
  		String nickname = rvto2.getNickname();
  		String writeDate = rvto2.getWrite_date();
  		String content = rvto2.getContent();
  		
  		Float starScore = rvto2.getStar_score();
  		int floatStarCountIntConvert2 = (int) (starScore * 10);
  		
		int j = 0;
  		
		sbReviewInfo.append( "	 	<div class='d-flex justify-content-between mb-2'>");
		sbReviewInfo.append( "  		<div class='d-flex flex-row align-items-center'>");
		sbReviewInfo.append( "    			<span class='small mb-0 ms-2'><i class='material-icons'>account_circle</i>&nbsp;" + nickname +"</span> <span class='text-end'></span>");
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
								<img src="../upload/<%=btoMainImage.getImage_name()%>" class="custom-block-image img-fluid mb-5"> 
								<div class="mb-2 pb-3">
									<span class="material-symbols-outlined"></span><small id="fullAdress" class="text-muted">&nbsp;<%= fullAdress %></small>
								</div>
								<div class="mb-2 pb-3">
									<span class="material-symbols-outlined"></span><span class="text-muted">&nbsp;<%= phone %></span>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-7 col-12">
						<div class="custom-block-info">
<!-- 찜하기&링크 -->
							<div class="mb-2 pb-3">
									<!-- 업체이름 -->
								<h3 id="title" class="mb-3">
									<%= title %>
								</h3>
							
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
							    <!--  <i class="bi-heart" style="font-size:25px; color: red; cursor: pointer;"></i> -->
								&nbsp;
								 <!-- <span class="material-symbols-outlined"> share </span>  -->
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
						<div class="row mb-3">
							<%	for ( BoardTO btoNotice : noticeList ) { %>
								<a href="./view.jsp?%<%=btoNotice.getSeq()%>"><br>- <%=btoNotice.getTitle() %></a>
							<% 	} %>
						</div>
						</br>
						<h6 class="mb-lg-5">운영시간 및 운동시설 소개</h6>
						<div class="card">
							<div class="card-body">
								<p class="mt-3 text-center fw-bold">
								<%= bto.getContent() %>
								</p>
							</div>
						</div>
						</br>
						<h6 class="mb-lg-3 mt-3">사진</h6>
						<div class="row">
							<div class="table-responsive">
								<table class="table text-center border-light table-borderless table-sm">
									<thead class="border-light">
										<tr>
										<th scope="col">
										<br>
										<!-- 사진 -->
											<%	for ( BoardTO btoImage : imageList ) { %>
											<div class="custom-block-icon-wrap mb-5">
												<div class="custom-block-image-wrap custom-block-image-detail-page">
													<img src="../upload/<%=btoImage.getImage_name()%>" class="custom-block-image img-fluid">
												</div>
											</div> 
											<% 	} %>
										</tr>
									</thead>
								</table>
							</div>
						</div>
						<hr>
						</br>
						<h6>지도</h6>
						</br>
						<div class="row">
						<div class="custom-block-icon-wrap mb-5">
							<div class="custom-block-image-wrap custom-block-image-detail-page">
								<div id="map" style="width:100%;height:350px;"></div>
							</div>
						</div>
						</div>
					</div>
					<div class="card-footer text-muted" id="review">
						<div class="card-body">
							<h6>이용후기</h6>
							<br>
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
								<!--  <button type="button" class="btn btn-outline-primary btn-block">카트담기</button> -->
							</div>
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
</div>
</div>




