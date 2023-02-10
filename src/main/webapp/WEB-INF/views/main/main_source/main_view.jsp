<%@page import="com.maumgagym.dto.BoardTO"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding( "utf-8" );
	ArrayList<BoardTO> arryList = (ArrayList) request.getAttribute("arryList");
	
	StringBuilder sbRecommendedList = new StringBuilder();
	
	for( BoardTO to : arryList) {
		int seq = to.getSeq();
		String title = to.getTitle();
		String tags = to.getTag();
		String imageName = to.getImage_name();
		String[] arryTag = tags.split(" ");
		
		sbRecommendedList.append( " <div class='owl-carousel-info-wrap item'> ");
		sbRecommendedList.append( " <div style='height: 300px;'> ");
		sbRecommendedList.append( " <a href= '/facility/" + seq + "'><img src='../upload/" + imageName +"' class='owl-carousel-image img-fluid' alt=''></a> ");
		sbRecommendedList.append( " </div> ");
		sbRecommendedList.append( " 		<div class='owl-carousel-info'> ");
		sbRecommendedList.append( " 			<a href= '/facility/" + seq + "'><h4 class='mb-2'>" + title + ""); 
		sbRecommendedList.append( " 			</h4></a> ");
		sbRecommendedList.append( " 			</br> ");
		for( int i = 0; i < arryTag.length; i++ ) {
			sbRecommendedList.append( " 			<span class='badge'>" + arryTag[i] + "</span>"); 
		}
		sbRecommendedList.append( " 		</div> ");
		sbRecommendedList.append( " 		</div> "); 
	}
	
	if( arryList.size() < 6) {
		for( int i = 0; i < (6 - arryList.size() ); i++ ) {
			sbRecommendedList.append( " <div class='owl-carousel-info-wrap item'> ");
			sbRecommendedList.append( " <div style='height: 300px;'> ");
			sbRecommendedList.append( " <img src='../resources/asset/images/logo_3.jpg' class='owl-carousel-image img-fluid' alt=''> ");
			sbRecommendedList.append( " </div> ");
			sbRecommendedList.append( " 		<div class='owl-carousel-info'> ");
			sbRecommendedList.append( " 			<h4 class='mb-2'><small>아직 등록된 글이 없습니다.</small>"); 
			sbRecommendedList.append( " 			</h4> ");
			sbRecommendedList.append( " 		</div> ");
			sbRecommendedList.append( " 		</div> "); 
		}
		
	}
	
%>    
		<div class="container">
			<div class="row">
	
				<div class="col-lg-12 col-12 mt-5">
					<div class="text-center mb-5 pb-2">
						<h2 class="text-dark">
							마음가짐 회원이라면, 우주 최저가 혜택 받아야죠!
							</h2>
							<p class="text-dark">직접 방문한 것보다 더 저렴해요. 지금 둘러보세요.</p>
							<a href="#section_2" class="btn custom-btn smoothscroll mt-3">보러가기</a>
					</div>
	
					<div class="owl-carousel owl-theme">
						<%= sbRecommendedList.toString() %>
					</div>
				</div>
	
			</div>
		</div>
	
		<section class="topics-section section-padding pb-0" id="section_3">
			<div class="container">
				<div class="row">
	
					<div class="col-lg-12 col-12">
						<div class="section-title-wrap mb-5">
							<h4 class="section-title">운동 종류</h4>
						</div>
					</div>
					<div class="col-lg-3 col-md-6 col-12 mb-4 mb-lg-5">
						<div class="custom-block custom-block-overlay">
							<a href="detail-page.html" class="custom-block-image-wrap"> <img
								src="./resources/asset/images/main_view/main_category/woman-practicing-yoga-mat-home.jpg"
								class="custom-block-image img-fluid" alt="">
							</a>
	
							<div class="custom-block-info custom-block-overlay-info">
								<h5 class="mb-1">
									<a href="listing-page.html"> 피트니스 </a>
								</h5>
	
								<p class="badge mb-0">10개</p>
							</div>
						</div>
					</div>
	
					<div class="col-lg-3 col-md-6 col-12 mb-4 mb-lg-0">
						<div class="custom-block custom-block-overlay">
							<a href="detail-page.html" class="custom-block-image-wrap"> <img
								src="./resources/asset/images/main_view/main_category/woman-practicing-yoga-mat-home.jpg"
								class="custom-block-image img-fluid" alt="">
							</a>
	
							<div class="custom-block-info custom-block-overlay-info">
								<h5 class="mb-1">
									<a href="listing-page.html"> 요가 </a>
								</h5>
	
								<p class="badge mb-0">10개</p>
							</div>
						</div>
					</div>
	
					<div class="col-lg-3 col-md-6 col-12 mb-4 mb-lg-0">
						<div class="custom-block custom-block-overlay">
							<a href="detail-page.html" class="custom-block-image-wrap"> <img
								src="./resources/asset/images/main_view/main_category/woman-practicing-yoga-mat-home.jpg"
								class="custom-block-image img-fluid" alt="">
							</a>
	
							<div class="custom-block-info custom-block-overlay-info">
								<h5 class="mb-1">
									<a href="listing-page.html"> 수영 </a>
								</h5>
	
								<p class="badge mb-0">10개</p>
							</div>
						</div>
					</div>
	
					<div class="col-lg-3 col-md-6 col-12 mb-4 mb-lg-0">
						<div class="custom-block custom-block-overlay">
							<a href="detail-page.html" class="custom-block-image-wrap"> <img
								src="./resources/asset/images/main_view/main_category/woman-practicing-yoga-mat-home.jpg"
								class="custom-block-image img-fluid" alt="">
							</a>
	
							<div class="custom-block-info custom-block-overlay-info">
								<h5 class="mb-1">
									<a href="listing-page.html"> 테니스 </a>
								</h5>
	
								<p class="badge mb-0">10개</p>
							</div>
						</div>
					</div>
	
					<!-- 2row -->
					<div class="col-lg-3 col-md-6 col-12 mb-4 mb-lg-5">
						<div class="custom-block custom-block-overlay">
							<a href="detail-page.html" class="custom-block-image-wrap"> <img
								src="./resources/asset/images/main_view/main_category/woman-practicing-yoga-mat-home.jpg"
								class="custom-block-image img-fluid" alt="">
							</a>
	
							<div class="custom-block-info custom-block-overlay-info">
								<h5 class="mb-1">
									<a href="listing-page.html"> 타바타 </a>
								</h5>
	
								<p class="badge mb-0">10개</p>
							</div>
						</div>
					</div>
	
					<div class="col-lg-3 col-md-6 col-12 mb-4 mb-lg-0">
						<div class="custom-block custom-block-overlay">
							<a href="detail-page.html" class="custom-block-image-wrap"> <img
								src="./resources/asset/images/main_view/main_category/woman-practicing-yoga-mat-home.jpg"
								class="custom-block-image img-fluid" alt="">
							</a>
	
							<div class="custom-block-info custom-block-overlay-info">
								<h5 class="mb-1">
									<a href="listing-page.html"> 필라테스 </a>
								</h5>
	
								<p class="badge mb-0">10개</p>
							</div>
						</div>
					</div>
	
					<div class="col-lg-3 col-md-6 col-12 mb-4 mb-lg-0">
						<div class="custom-block custom-block-overlay">
							<a href="detail-page.html" class="custom-block-image-wrap"> <img
								src="./resources/asset/images/main_view/main_category/woman-practicing-yoga-mat-home.jpg"
								class="custom-block-image img-fluid" alt="">
							</a>
	
							<div class="custom-block-info custom-block-overlay-info">
								<h5 class="mb-1">
									<a href="listing-page.html"> 골프 </a>
								</h5>
	
								<p class="badge mb-0">10개</p>
							</div>
						</div>
					</div>
	
					<div class="col-lg-3 col-md-6 col-12 mb-4 mb-lg-0">
						<div class="custom-block custom-block-overlay">
							<a href="detail-page.html" class="custom-block-image-wrap"> <img
								src="./resources/asset/images/main_view/main_category/woman-practicing-yoga-mat-home.jpg"
								class="custom-block-image img-fluid" alt="">
							</a>
	
							<div class="custom-block-info custom-block-overlay-info">
								<h5 class="mb-1">
									<a href="listing-page.html"> 복싱 </a>
								</h5>
	
								<p class="badge mb-0">10개</p>
							</div>
						</div>
					</div>
					<!-- /2row -->
	
					<!-- 3row -->
					<div class="col-lg-3 col-md-6 col-12 mb-4 mb-lg-0">
						<div class="custom-block custom-block-overlay">
							<a href="detail-page.html" class="custom-block-image-wrap"> <img
								src="./resources/asset/images/main_view/main_category/woman-practicing-yoga-mat-home.jpg"
								class="custom-block-image img-fluid" alt="">
							</a>
	
							<div class="custom-block-info custom-block-overlay-info">
								<h5 class="mb-1">
									<a href="listing-page.html"> 댄스 </a>
								</h5>
	
								<p class="badge mb-0">10개</p>
							</div>
						</div>
					</div>
	
	
				</div>
			</div>
	
	
		</section>
	
		<section class="trending-podcast-section section-padding">
			<div class="container">
				<div class="row">
	
					<div class="col-lg-12 col-12">
						<div class="section-title-wrap mb-5">
							<h4 class="section-title">금주의 인기글</h4>
						</div>
					</div>
	
					<div class="col-lg-4 col-12 mb-4 mb-lg-0">
						<div class="custom-block custom-block-full">
							<div class="custom-block-image-wrap">
								<a href="detail-page.html"> <img
									src="./resources/asset/images/main_view/main_hot_weekly/main_weekly1.jpg"
									class="custom-block-image img-fluid" alt="">
								</a>
							</div>
							<div class="custom-block-info">
								<h5 class="mb-2">
									<a href="detail-page.html"> 샘플 제목1 </a>
								</h5>
	
								<div class="profile-block d-flex">
									<p>
										운동상식 <strong>글쓴이 1</strong>
									</p>
								</div>
								<div
									class="custom-block-bottom d-flex justify-content-between mt-3">
									<a href="#" class="bi bi-hand-index-thumb me-1"> <span>100k</span>
									</a> <a href="#" class="bi-heart me-1"> <span>2.5k</span>
									</a> <a href="#" class="bi-chat me-1"> <span>924k</span>
									</a>
								</div>
							</div>
						</div>
					</div>
	
					<div class="col-lg-4 col-12 mb-4 mb-lg-0">
						<div class="custom-block custom-block-full">
							<div class="custom-block-image-wrap">
								<a href="detail-page.html"> <img
									src="./resources/asset/images/main_view/main_hot_weekly/main_weekly1.jpg"
									class="custom-block-image img-fluid" alt="">
								</a>
							</div>
	
							<div class="custom-block-info">
								<h5 class="mb-2">
									<a href="detail-page.html"> 샘플 제목2 </a>
								</h5>
	
								<div class="profile-block d-flex">
									<p>
										운동상식 <strong>글쓴이 2</strong>
									</p>
								</div>
								<div
									class="custom-block-bottom d-flex justify-content-between mt-3">
									<a href="#" class="bi bi-hand-index-thumb me-1"> <span>100k</span>
									</a> <a href="#" class="bi-heart me-1"> <span>2.5k</span>
									</a> <a href="#" class="bi-chat me-1"> <span>924k</span>
									</a>
								</div>
							</div>
						</div>
					</div>
	
					<div class="col-lg-4 col-12">
						<div class="custom-block custom-block-full">
							<div class="custom-block-image-wrap">
								<a href="detail-page.html"> <img
									src="./resources/asset/images/main_view/main_hot_weekly/main_weekly1.jpg"
									class="custom-block-image img-fluid" alt="">
								</a>
							</div>
	
							<div class="custom-block-info">
								<h5 class="mb-2">
									<a href="detail-page.html"> 샘플 제목3 </a>
								</h5>
	
								<div class="profile-block d-flex">
									<p>
										운동상식 <strong>글쓴이 3</strong>
									</p>
								</div>
								<div
									class="custom-block-bottom d-flex justify-content-between mt-3">
									<a href="#" class="bi bi-hand-index-thumb me-1"> <span>100k</span>
									</a> <a href="#" class="bi-heart me-1"> <span>2.5k</span>
									</a> <a href="#" class="bi-chat me-1"> <span>924k</span>
									</a>
								</div>
							</div>
						</div>
					</div>
	
				</div>
			</div>
		</section>