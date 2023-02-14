<%@page import="com.maumgagym.dto.BoardTO"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding( "utf-8" );
	ArrayList<BoardTO> recommendedList = (ArrayList) request.getAttribute("recommendedList");
	ArrayList<BoardTO> FacilityBoardCountList = (ArrayList) request.getAttribute("FacilityBoardCountList");
	ArrayList<BoardTO> weeklyBoardList = (ArrayList) request.getAttribute("weeklyBoardList");
	
	StringBuilder sbRecommendedList = new StringBuilder();
	
 	for( BoardTO to : recommendedList) {
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
	if( recommendedList.size() < 6) {
		for( int i = 0; i < (6 - recommendedList.size() ); i++ ) {
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
	StringBuilder sbFacilityBoardCountList = new StringBuilder();
	String[] imageArry = { "fitness", "yoga", "swimming", "tennis", "tabata", "pilates", "golf", "boxing", "dance" };
	int i = 0;
 	for( BoardTO to : FacilityBoardCountList) {
		String topic = to.getTopic();
		int categoryBoardCount = to.getCategoryBoardCount();
		
		sbFacilityBoardCountList.append("		<div class='col-lg-3 col-md-6 col-12 mb-4 mb-lg-5'> ");
		sbFacilityBoardCountList.append("		<div class='custom-block custom-block-overlay'> ");
		sbFacilityBoardCountList.append("			<a href='/facility?category_seq=" + ( i + 1 ) + "' class='custom-block-image-wrap'> "); 
		sbFacilityBoardCountList.append("				<img src='./resources/asset/images/main_view/main_category/" + imageArry[i] + ".jpg' class='custom-block-image img-fluid' alt=''> ");
		sbFacilityBoardCountList.append("			</a> ");
		sbFacilityBoardCountList.append("			<div class='custom-block-info custom-block-overlay-info'> ");
		sbFacilityBoardCountList.append("				<h5 class='mb-1'> ");
		sbFacilityBoardCountList.append("					<a href='listing-page.html'>" + topic + "</a> ");
		sbFacilityBoardCountList.append("				</h5> ");
		if( categoryBoardCount == 0 ) {
		sbFacilityBoardCountList.append("				<p class='badge mb-0'>등록된 글이 없습니다.</p> ");
		} else { 
		sbFacilityBoardCountList.append("				<p class='badge mb-0'>" + categoryBoardCount + "개</p> ");			
		}
		sbFacilityBoardCountList.append("			</div> ");
		sbFacilityBoardCountList.append("		</div> "); 
		sbFacilityBoardCountList.append("	</div> ");
		i++;
	}
 	
 	StringBuilder sbWeeklyBoardList = new StringBuilder();
 	for( BoardTO to : weeklyBoardList) {
 		
 		int seq =to.getSeq();
		String title = to.getTitle();
		String topic = to.getTopic();
		String nickname = to.getNickname();
		int viewCount = to.getView_count();
		int likeCount = to.getLike_count();
		int commentCount = to.getComment_count();
		String imageName = to.getImage_name();
		
		sbWeeklyBoardList.append( " <div class='col-lg-4 col-12 mb-4 mb-lg-0'> " );
		sbWeeklyBoardList.append( "			<div class='custom-block custom-block-full mb-5'> " );
		sbWeeklyBoardList.append( "				<div class='custom-block-image-wrap'> " );
		if( topic.equals("운동") ) {
			sbWeeklyBoardList.append( " <a href='/community/view?seq=" + seq +"'><img src='./resources/asset/images/main_view/main_hot_weekly/fitness.jpg' class='custom-block-image img-fluid'></a>" );
		} else if ( topic.equals("건강") ) {
			sbWeeklyBoardList.append( "	<a href='/community/view?seq=" + seq +"'><img src='./resources/asset/images/main_view/main_hot_weekly/health.jpg' class='custom-block-image img-fluid'></a>" );
		} else if ( topic.equals("수다") ) {
			sbWeeklyBoardList.append( "	<a href='/community/view?seq=" + seq +"'><img src='./resources/asset/images/main_view/main_hot_weekly/chat.jpg' class='custom-block-image img-fluid'></a>" );
		}
		sbWeeklyBoardList.append( "		</a> " );
		sbWeeklyBoardList.append( "				</div> " );
		sbWeeklyBoardList.append( "				<div class='custom-block-info'> " );
		sbWeeklyBoardList.append( "					<h5 class='mb-2'> " );
		sbWeeklyBoardList.append( "						<a class='text-truncate' style='max-width: 300px;' href='/community/view?seq=" + seq +"'> " + title + " </a> " );
		sbWeeklyBoardList.append( "					</h5> " );
		sbWeeklyBoardList.append( "					<div class='profile-block d-flex'> " );
		sbWeeklyBoardList.append( "						<p> " );
		sbWeeklyBoardList.append( "							" + topic + "<strong>" + nickname + "</strong> " );
		sbWeeklyBoardList.append( "						</p> " );
		sbWeeklyBoardList.append( "					</div> " );
		sbWeeklyBoardList.append( "					<div class='custom-block-bottom d-flex justify-content-between mt-3'> " );
		sbWeeklyBoardList.append( "						<a class='bi bi-hand-index-thumb me-1'> <span>" + viewCount + "</span> " );
		sbWeeklyBoardList.append( "						</a> <a class='bi-heart me-1'> <span>" + likeCount + "</span> " );
		sbWeeklyBoardList.append( "						</a> <a class='bi-chat me-1'> <span>" + commentCount + "</span> " );
		sbWeeklyBoardList.append( "						</a> " );
		sbWeeklyBoardList.append( "					</div> " ); 
		sbWeeklyBoardList.append( "				</div> " );
		sbWeeklyBoardList.append( "			</div> " );
		sbWeeklyBoardList.append( "		</div> " );
	}
 	
 	for( i = 0; i < 6 - weeklyBoardList.size(); i++ ) {
 		
		sbWeeklyBoardList.append( " <div class='col-lg-4 col-12 mb-4 mb-lg-0'> " );
		sbWeeklyBoardList.append( "			<div class='custom-block custom-block-full mb-5'> " );
		sbWeeklyBoardList.append( "				<div class='custom-block-image-wrap'> " );
		sbWeeklyBoardList.append( "					<a> <img ' class='custom-block-image img-fluid' alt=''> " );
		sbWeeklyBoardList.append( "					</a> " );
		sbWeeklyBoardList.append( "				</div> " );
		sbWeeklyBoardList.append( "				<div class='custom-block-info'> " );
		sbWeeklyBoardList.append( "					<h5 class='mb-2'> " );
		sbWeeklyBoardList.append( "						<a>아직 등록된 글이 없습니다.</a> " );
		sbWeeklyBoardList.append( "					</h5> " );
		sbWeeklyBoardList.append( "					<div class='profile-block d-flex'> " );
		sbWeeklyBoardList.append( "						<p> " );
		sbWeeklyBoardList.append( "						<strong></strong> " );
		sbWeeklyBoardList.append( "						</p> " );
		sbWeeklyBoardList.append( "					</div> " );
		sbWeeklyBoardList.append( "					<div class='custom-block-bottom d-flex justify-content-between mt-3'> " );
		sbWeeklyBoardList.append( "						<a class='bi bi-hand-index-thumb me-1'> <span></span> " );
		sbWeeklyBoardList.append( "						</a> <a class='bi-heart me-1'> <span></span> " );
		sbWeeklyBoardList.append( "						</a> <a class='bi-chat me-1'> <span></span> " );
		sbWeeklyBoardList.append( "						</a> " );
		sbWeeklyBoardList.append( "					</div> " ); 
		sbWeeklyBoardList.append( "				</div> " );
		sbWeeklyBoardList.append( "			</div> " );
		sbWeeklyBoardList.append( "		</div> " );
 		
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
							<a href="/facility" class="btn custom-btn smoothscroll mt-3">보러가기</a>
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
							<h4 class="section-title">운동시설 종류</h4>
						</div>
					</div>
						<%= sbFacilityBoardCountList.toString() %>	
				</div>
			</div>
		</section>
	
		<section class="trending-podcast-section section-padding">
			<div class="container">
				<div class="row">
	
					<div class="col-lg-12 col-12">
						<div class="section-title-wrap mb-5">
							<h4 class="section-title">최신글</h4>
						</div>
					</div>
						<%= sbWeeklyBoardList.toString() %>	
				</div>
			</div>
		</section>