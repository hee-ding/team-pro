<%@page import="com.maumgagym.dto.ReviewTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.maumgagym.dto.BoardTO"%>
<%@page import="com.maumgagym.dto.MemberShipTO"%>
<%@page import="com.maumgagym.dto.PayTO"%>
<%@page import="com.maumgagym.dto.MemberTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding( "utf-8" );

	MemberTO mto = (MemberTO)request.getAttribute("mto");
	
	String beforeChangeNickname = mto.getNickname();
	
	ArrayList< Map<String, Object> > arryList = (ArrayList) request.getAttribute("arryList");
	
	Map<String, Object> map = null;

	// status 무관
	StringBuilder sbPurchaseList = new StringBuilder();
	// status 0 또는 1
	StringBuilder sbBeforeRegister = new StringBuilder();
	// status 2
	StringBuilder sbAfterRegister = new StringBuilder();
	// status 3
	StringBuilder sbPauseMembership = new StringBuilder();
	// status 4
	StringBuilder sbExpireMembership = new StringBuilder();
			
			for( int i = 0; i < arryList.size(); i++ ) {
				
				map = arryList.get( i );
				
				PayTO pto = (PayTO) map.get("pto");
				String payDate = pto.getPay_date();		//
				String payType = pto.getType();			//
				String payStatus = pto.getPay_status(); //
				String merchantUid = pto.getMerchant_uid();
				String membership_register_status = pto.getMembership_register_status();
				
				MemberShipTO msto = (MemberShipTO) map.get("msto");
				String membershipName = msto.getMembership_name();	//		
				int membershipPrice = msto.getMembership_price();
				int membershipPeriod = msto.getMembership_period();	//
				
				BoardTO bto = (BoardTO) map.get("bto");
				int boardSeq = bto.getSeq();			//
				String title = bto.getTitle();			//
				String imageName = bto.getImage_name();	//
				
				MemberTO wmto = (MemberTO) map.get("wmto");
				String facilityFullAddress = wmto.getFullAddress();
				String phone = wmto.getPhone();
				
				ReviewTO rvto = (ReviewTO) map.get("rvto");
				String reviewStatus = rvto.getStatus();
	
				
				sbPurchaseList.append( "	<div class='mt-3 mb-4'>");
				sbPurchaseList.append( "		<div class='col-xl-12'>");
				sbPurchaseList.append( "			<div class='card mb-4'>");
				sbPurchaseList.append( "				<div class='card-header fs-5 fw-bolder'><a href='/facility/" + boardSeq +"'>" + String.format( "%s (%s)", title, phone ) +"</a></div>");
				sbPurchaseList.append( "				<div class='card-body'>");
				sbPurchaseList.append( "					<div class='row g-0'>");
				sbPurchaseList.append( "						<div class='col-md-4'>");
				sbPurchaseList.append( "							<img src='../upload/" + imageName +"' class='owl-carousel-image img-fluid'>");
				sbPurchaseList.append( "						</div>");
				sbPurchaseList.append( "						<div class='col-md-8' style='padding-left: 50px'>");
				sbPurchaseList.append( "							<h3 class='card-title fw-semibold'>" + facilityFullAddress + "</h3>");
				sbPurchaseList.append( "							<br>");
				sbPurchaseList.append( "							<p class='card-text fs-5'>" + membershipName +"</p>");
				sbPurchaseList.append( "							<p class='card-text fs-7'>");
				if( membership_register_status.equals( "0" )) {
				sbPurchaseList.append( "							아직 등록전입니다. <br>사용하시려면 아래 등록하기 버튼을 눌러주시거나 등록된 번호로 문의하세요.</br>");
				}
				sbPurchaseList.append( "							</p>");
				sbPurchaseList.append( "						</div>");
				sbPurchaseList.append( "					</div>");
				sbPurchaseList.append( "					<table class='table mt-3'>");
				sbPurchaseList.append( "						<tbody>");
				sbPurchaseList.append( "							<tr>");
				sbPurchaseList.append( "								<th scope='row'>결제일</th>");
				sbPurchaseList.append( "								<td>" + payDate + "</td>");
				sbPurchaseList.append( "								<th>결제금액</th>");
				sbPurchaseList.append( "								<td>" + String.format("%,d 원", membershipPrice) + "</td>");
				sbPurchaseList.append( "							</tr>");
				sbPurchaseList.append( "							<tr>");
				sbPurchaseList.append( "								<th scope='row'>결제수단</th>");
				sbPurchaseList.append( "								<td>" + payType + "</td>");
				sbPurchaseList.append( "								<th>결제상태</th>");
				sbPurchaseList.append( "								<td>" + payStatus + "</td>");
				sbPurchaseList.append( "							</tr>");
				sbPurchaseList.append( "						</tbody>");
				sbPurchaseList.append( "					</table>");
				sbPurchaseList.append( "					<div class='d-grid gap-2'> ");
				if( membership_register_status.equals( "0" )) {
					sbPurchaseList.append( "						<button id='membershipRegister' class='btn btn-primary mt-1' type='button' onclick='membershipRegister(this)' value='" + merchantUid + "'> 등록하기 </button>");
					sbPurchaseList.append( "						<input type='hidden' id='reqMemberSeq' value='" + mto.getSeq() + "' >");
					sbPurchaseList.append( "						<input type='hidden' id='boardSeq' value='" + boardSeq + "' >");
				} else if (membership_register_status.equals( "1" ) ) {
					sbPurchaseList.append( "						<button id='membershipRegister' class='btn btn-secondary mt-1' type='button' onclick='membershipRegister(this)' value='" + merchantUid + "' disabled='disabled'> 승인 대기 중입니다. 취소를 원하시면 운동시설에 연락하세요. </button>");		
				}
				sbPurchaseList.append( "					</div>");
				sbPurchaseList.append( "				</div>");
				sbPurchaseList.append( "			</div>");
				sbPurchaseList.append( "		</div>");
				sbPurchaseList.append( "	</div>");

		
		}
		
			for( int i = 0; i < arryList.size(); i++ ) {
				
				map = arryList.get( i );
				
				PayTO pto = (PayTO) map.get("pto");
				String payDate = pto.getPay_date();		//
				String payType = pto.getType();			//
				String payStatus = pto.getPay_status(); //
				String merchantUid = pto.getMerchant_uid();
				String membership_register_status = pto.getMembership_register_status();
				
				MemberShipTO msto = (MemberShipTO) map.get("msto");
				String membershipName = msto.getMembership_name();	//		
				int membershipPrice = msto.getMembership_price();
				int membershipPeriod = msto.getMembership_period();	//
				
				BoardTO bto = (BoardTO) map.get("bto");
				int boardSeq = bto.getSeq();			//
				String title = bto.getTitle();			//
				String imageName = bto.getImage_name();	//
				
				MemberTO wmto = (MemberTO) map.get("wmto");
				String facilityFullAddress = wmto.getFullAddress();
				String phone = wmto.getPhone();
				
				ReviewTO rvto = (ReviewTO) map.get("rvto");
				String reviewStatus = rvto.getStatus();
				
				if( membership_register_status.equals( "0" ) || membership_register_status.equals( "1" ) ) {

				
				sbBeforeRegister.append( "	<div class='mt-3 mb-4'>");
				sbBeforeRegister.append( "		<div class='col-xl-12'>");
				sbBeforeRegister.append( "			<div class='card mb-4'>");
				sbBeforeRegister.append( "				<div class='card-header fs-5 fw-bolder'><a href='/facility/" + boardSeq +"'>" + String.format( "%s (%s)", title, phone ) +"</a></div>");
				sbBeforeRegister.append( "				<div class='card-body'>");
				sbBeforeRegister.append( "					<div class='row g-0'>");
				sbBeforeRegister.append( "						<div class='col-md-4'>");
				sbBeforeRegister.append( "							<img src='../upload/" + imageName +"' class='owl-carousel-image img-fluid'>");
				sbBeforeRegister.append( "						</div>");
				sbBeforeRegister.append( "						<div class='col-md-8' style='padding-left: 50px'>");
				sbBeforeRegister.append( "							<h3 class='card-title fw-semibold'>" + facilityFullAddress + "</h3>");
				sbBeforeRegister.append( "							<br>");
				sbBeforeRegister.append( "							<p class='card-text fs-5'>" + membershipName +"</p>");
				sbBeforeRegister.append( "							<p class='card-text fs-7'>");
				sbBeforeRegister.append( "							아직 등록전입니다. <br>사용하시려면 아래 등록하기 버튼을 눌러주시거나 등록된 번호로 문의하세요.</br>");
				sbBeforeRegister.append( "							</p>");
				sbBeforeRegister.append( "						</div>");
				sbBeforeRegister.append( "					</div>");
				sbBeforeRegister.append( "					<table class='table mt-3'>");
				sbBeforeRegister.append( "						<tbody>");
				sbBeforeRegister.append( "							<tr>");
				sbBeforeRegister.append( "								<th scope='row'>결제일</th>");
				sbBeforeRegister.append( "								<td>" + payDate + "</td>");
				sbBeforeRegister.append( "								<th>결제금액</th>");
				sbBeforeRegister.append( "								<td>" + String.format("%,d 원", membershipPrice) + "</td>");
				sbBeforeRegister.append( "							</tr>");
				sbBeforeRegister.append( "							<tr>");
				sbBeforeRegister.append( "								<th scope='row'>결제수단</th>");
				sbBeforeRegister.append( "								<td>" + payType + "</td>");
				sbBeforeRegister.append( "								<th>결제상태</th>");
				sbBeforeRegister.append( "								<td>" + payStatus + "</td>");
				sbBeforeRegister.append( "							</tr>");
				sbBeforeRegister.append( "						</tbody>");
				sbBeforeRegister.append( "					</table>");
				sbBeforeRegister.append( "					<div class='d-grid gap-2'> ");
				if( membership_register_status.equals( "0" )) {
					sbBeforeRegister.append( "						<button id='membershipRegister' class='btn btn-primary mt-1' type='button' onclick='membershipRegister(this)' value='" + merchantUid + "'> 등록하기 </button>");
					sbBeforeRegister.append( "						<input type='hidden' id='reqMemberSeq' value='" + mto.getSeq() + "' >");
					sbBeforeRegister.append( "						<input type='hidden' id='boardSeq' value='" + boardSeq + "' >");
				} else if (membership_register_status.equals( "1" ) ) {
					sbBeforeRegister.append( "						<button id='membershipRegister' class='btn btn-secondary mt-1' type='button' onclick='membershipRegister(this)' value='" + merchantUid + "' disabled='disabled'> 승인 대기 중입니다. 취소를 원하시면 운동시설에 연락하세요. </button>");		
				}
				sbBeforeRegister.append( "					</div>");
				sbBeforeRegister.append( "				</div>");
				sbBeforeRegister.append( "			</div>");
				sbBeforeRegister.append( "		</div>");
				sbBeforeRegister.append( "	</div>");
				
				}
		
		}
			
		for( int i = 0; i < arryList.size(); i++ ) {
				
				map = arryList.get( i );
				
				PayTO pto = (PayTO) map.get("pto");
				String payDate = pto.getPay_date();		//
				String payType = pto.getType();			//
				String payStatus = pto.getPay_status(); //
				String merchantUid = pto.getMerchant_uid();
				String membership_register_status = pto.getMembership_register_status();
				
				MemberShipTO msto = (MemberShipTO) map.get("msto");
				String membershipName = msto.getMembership_name();	//		
				int membershipPrice = msto.getMembership_price();
				int membershipPeriod = msto.getMembership_period();	//
				
				BoardTO bto = (BoardTO) map.get("bto");
				int boardSeq = bto.getSeq();
				String title = bto.getTitle();			//
				String imageName = bto.getImage_name();	//
				
				MemberTO wmto = (MemberTO) map.get("wmto");
				String facilityFullAddress = wmto.getFullAddress();
				String phone = wmto.getPhone();
				
				ReviewTO rvto = (ReviewTO) map.get("rvto");
				String reviewStatus = rvto.getStatus();

				if( membership_register_status.equals( "2" ) ) {
				
				sbAfterRegister.append( "	<div class='mt-3 mb-4'>");
				sbAfterRegister.append( "		<div class='col-xl-12'>");
				sbAfterRegister.append( "			<div class='card mb-4'>");
				sbAfterRegister.append( "				<div class='card-header fs-5 fw-bolder'><a href='/facility/" + boardSeq +"'>" + String.format( "%s (%s)", title, phone ) +"</a></div>");
				sbAfterRegister.append( "				<div class='card-body'>");
				sbAfterRegister.append( "					<div class='row g-0'>");
				sbAfterRegister.append( "						<div class='col-md-4'>");
				sbAfterRegister.append( "							<img src='../upload/" + imageName +"' class='owl-carousel-image img-fluid'>");
				sbAfterRegister.append( "						</div>");
				sbAfterRegister.append( "						<div class='col-md-8' style='padding-left: 50px'>");
				sbAfterRegister.append( "							<h3 class='card-title fw-semibold'>" + facilityFullAddress + "</h3>");
				sbAfterRegister.append( "							<br>");
				sbAfterRegister.append( "							<p class='card-text fs-5'>" + membershipName +"</p>");
				sbAfterRegister.append( "							<p class='card-text fs-7'>");
				sbAfterRegister.append( "							</p>");
				sbAfterRegister.append( "						</div>");
				sbAfterRegister.append( "					</div>");
				sbAfterRegister.append( "					<table class='table mt-3'>");
				sbAfterRegister.append( "						<tbody>");
				sbAfterRegister.append( "							<tr>");
				sbAfterRegister.append( "								<th scope='row'>결제일</th>");
				sbAfterRegister.append( "								<td>" + payDate + "</td>");
				sbAfterRegister.append( "								<th>결제금액</th>");
				sbAfterRegister.append( "								<td>" + String.format("%,d 원", membershipPrice) + "</td>");
				sbAfterRegister.append( "							</tr>");
				sbAfterRegister.append( "							<tr>");
				sbAfterRegister.append( "								<th scope='row'>결제수단</th>");
				sbAfterRegister.append( "								<td>" + payType + "</td>");
				sbAfterRegister.append( "								<th>결제상태</th>");
				sbAfterRegister.append( "								<td>" + payStatus + "</td>");
				sbAfterRegister.append( "							</tr>");
				sbAfterRegister.append( "						</tbody>");
				sbAfterRegister.append( "					</table>");
				sbAfterRegister.append( "					<div class='d-grid gap-2'> ");
				sbAfterRegister.append( "					</div>");
				sbAfterRegister.append( "				</div>");
				sbAfterRegister.append( "			</div>");
				sbAfterRegister.append( "		</div>");
				sbAfterRegister.append( "	</div>");
				
				}
		
		}
		
		for( int i = 0; i < arryList.size(); i++ ) {
			
			map = arryList.get( i );
			
			PayTO pto = (PayTO) map.get("pto");
			String payDate = pto.getPay_date();		//
			String payType = pto.getType();			//
			String payStatus = pto.getPay_status(); //
			String merchantUid = pto.getMerchant_uid();
			String membership_register_status = pto.getMembership_register_status();
			
			MemberShipTO msto = (MemberShipTO) map.get("msto");
			String membershipName = msto.getMembership_name();	//		
			int membershipPrice = msto.getMembership_price();
			int membershipPeriod = msto.getMembership_period();	//
			
			BoardTO bto = (BoardTO) map.get("bto");
			int boardSeq = bto.getSeq();
			String title = bto.getTitle();			//
			String imageName = bto.getImage_name();	//
			
			MemberTO wmto = (MemberTO) map.get("wmto");
			String facilityFullAddress = wmto.getFullAddress();
			String phone = wmto.getPhone();
			
			ReviewTO rvto = (ReviewTO) map.get("rvto");
			String reviewStatus = rvto.getStatus();

			if( membership_register_status.equals( "3" ) ) {
			
			sbPauseMembership.append( "	<div class='mt-3 mb-4'>");
			sbPauseMembership.append( "		<div class='col-xl-12'>");
			sbPauseMembership.append( "			<div class='card mb-4'>");
			sbPauseMembership.append( "				<div class='card-header fs-5 fw-bolder'><a href='/facility/" + boardSeq +"'>" + String.format( "%s (%s)", title, phone ) +"</a></div>");
			sbPauseMembership.append( "				<div class='card-body'>");
			sbPauseMembership.append( "					<div class='row g-0'>");
			sbPauseMembership.append( "						<div class='col-md-4'>");
			sbPauseMembership.append( "							<img src='../upload/" + imageName +"' class='owl-carousel-image img-fluid'>");
			sbPauseMembership.append( "						</div>");
			sbPauseMembership.append( "						<div class='col-md-8' style='padding-left: 50px'>");
			sbPauseMembership.append( "							<h3 class='card-title fw-semibold'>" + facilityFullAddress + "</h3>");
			sbPauseMembership.append( "							<br>");
			sbPauseMembership.append( "							<p class='card-text fs-5'>" + membershipName +"</p>");
			sbPauseMembership.append( "							<p class='card-text fs-7'>");
			sbPauseMembership.append( "							</p>");
			sbPauseMembership.append( "						</div>");
			sbPauseMembership.append( "					</div>");
			sbPauseMembership.append( "					<table class='table mt-3'>");
			sbPauseMembership.append( "						<tbody>");
			sbPauseMembership.append( "							<tr>");
			sbPauseMembership.append( "								<th scope='row'>결제일</th>");
			sbPauseMembership.append( "								<td>" + payDate + "</td>");
			sbPauseMembership.append( "								<th>결제금액</th>");
			sbPauseMembership.append( "								<td>" + String.format("%,d 원", membershipPrice) + "</td>");
			sbPauseMembership.append( "							</tr>");
			sbPauseMembership.append( "							<tr>");
			sbPauseMembership.append( "								<th scope='row'>결제수단</th>");
			sbPauseMembership.append( "								<td>" + payType + "</td>");
			sbPauseMembership.append( "								<th>결제상태</th>");
			sbPauseMembership.append( "								<td>" + payStatus + "</td>");
			sbPauseMembership.append( "							</tr>");
			sbPauseMembership.append( "						</tbody>");
			sbPauseMembership.append( "					</table>");
			sbPauseMembership.append( "					<div class='d-grid gap-2'> ");
			sbPauseMembership.append( "					</div>");
			sbPauseMembership.append( "				</div>");
			sbPauseMembership.append( "			</div>");
			sbPauseMembership.append( "		</div>");
			sbPauseMembership.append( "	</div>");
			
			}
	
		}
		
		for( int i = 0; i < arryList.size(); i++ ) {
			
			map = arryList.get( i );
			
			PayTO pto = (PayTO) map.get("pto");
			String payDate = pto.getPay_date();		//
			String payType = pto.getType();			//
			String payStatus = pto.getPay_status(); //
			String merchantUid = pto.getMerchant_uid();
			String membership_register_status = pto.getMembership_register_status();
			
			MemberShipTO msto = (MemberShipTO) map.get("msto");
			String membershipName = msto.getMembership_name();	//		
			int membershipPrice = msto.getMembership_price();
			int membershipPeriod = msto.getMembership_period();	//
			
			BoardTO bto = (BoardTO) map.get("bto");
			int boardSeq = bto.getSeq();
			String title = bto.getTitle();			//
			String imageName = bto.getImage_name();	//
			
			MemberTO wmto = (MemberTO) map.get("wmto");
			String facilityFullAddress = wmto.getFullAddress();
			String phone = wmto.getPhone();
			
			ReviewTO rvto = (ReviewTO) map.get("rvto");
			String reviewStatus = rvto.getStatus();

			if( membership_register_status.equals( "4" ) ) {
			
			sbExpireMembership.append( "	<div class='mt-3 mb-4'>");
			sbExpireMembership.append( "		<div class='col-xl-12'>");
			sbExpireMembership.append( "			<div class='card mb-4'>");
			sbExpireMembership.append( "				<div class='card-header fs-5 fw-bolder'><a href='/facility/" + boardSeq +"'>" + String.format( "%s (%s)", title, phone ) +"</a></div>");
			sbExpireMembership.append( "				<div class='card-body'>");
			sbExpireMembership.append( "					<div class='row g-0'>");
			sbExpireMembership.append( "						<div class='col-md-4'>");
			sbExpireMembership.append( "							<img src='../upload/" + imageName +"' class='owl-carousel-image img-fluid'>");
			sbExpireMembership.append( "						</div>");
			sbExpireMembership.append( "						<div class='col-md-8' style='padding-left: 50px'>");
			sbExpireMembership.append( "							<h3 class='card-title fw-semibold'>" + facilityFullAddress + "</h3>");
			sbExpireMembership.append( "							<br>");
			sbExpireMembership.append( "							<p class='card-text fs-5'>" + membershipName +"</p>");
			sbExpireMembership.append( "							<p class='card-text fs-7'>");
			sbExpireMembership.append( "							</p>");
			sbExpireMembership.append( "						</div>");
			sbExpireMembership.append( "					</div>");
			sbExpireMembership.append( "					<table class='table mt-3'>");
			sbExpireMembership.append( "						<tbody>");
			sbExpireMembership.append( "							<tr>");
			sbExpireMembership.append( "								<th scope='row'>결제일</th>");
			sbExpireMembership.append( "								<td>" + payDate + "</td>");
			sbExpireMembership.append( "								<th>결제금액</th>");
			sbExpireMembership.append( "								<td>" + String.format("%,d 원", membershipPrice) + "</td>");
			sbExpireMembership.append( "							</tr>");
			sbExpireMembership.append( "							<tr>");
			sbExpireMembership.append( "								<th scope='row'>결제수단</th>");
			sbExpireMembership.append( "								<td>" + payType + "</td>");
			sbExpireMembership.append( "								<th>결제상태</th>");
			sbExpireMembership.append( "								<td>" + payStatus + "</td>");
			sbExpireMembership.append( "							</tr>");
			sbExpireMembership.append( "						</tbody>");
			sbExpireMembership.append( "					</table>");
			sbExpireMembership.append( "					<div class='d-grid gap-2'> ");
 			if( reviewStatus.equals( "0" ) ) {
				sbExpireMembership.append( "						<button id='" + merchantUid + "' class='btn btn-primary mt-1' type='button' onclick='reviewRegister(this, " + boardSeq + ", " + mto.getSeq() + ", `" + bto.getTitle() + "`, `" + imageName + "`, `" + facilityFullAddress + "` )' value='" + merchantUid + "'> 리뷰쓰기 </button>");
				sbExpireMembership.append( "						<input type='hidden' id='reqMemberSeq' value='" + mto.getSeq() + "' >");
				sbExpireMembership.append( "						<input type='hidden' id='boardSeq' value='" + boardSeq + "' >");
			} else if ( reviewStatus.equals( "1" ) ) {
				sbExpireMembership.append( "						<button id='" + merchantUid + "' class='btn btn-secondary mt-1' type='button' onclick='reviewRegister(" + boardSeq + ", " + mto.getSeq() + ")' value='" + merchantUid + "' disabled='disabled'> 이미 리뷰를 등록했습니다. </button>");		
			} 
			sbExpireMembership.append( "					</div>");
			sbExpireMembership.append( "				</div>");
			sbExpireMembership.append( "			</div>");
			sbExpireMembership.append( "		</div>");
			sbExpireMembership.append( "	</div>");
			
			}
	
		}

%>

<div class="container-xl px-4 mt-4">
	<ul class="nav nav-tabs" id="myTab" role="tablist">
	
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="home-tab" data-bs-toggle="tab"
				data-bs-target="#home-tab-pane" type="button" role="tab"
				aria-controls="home-tab-pane" aria-selected="true">내 정보</button>
		</li>
		
		<li class="nav-item" role="presentation">
			<button class="nav-link active" id="purchase-list-tab" data-bs-toggle="tab"
				data-bs-target="#purchase-list-tab-pane" type="button" role="tab"
				aria-controls="purchase-list-tab-pane" aria-selected="false">전체 결제 목록</button>
		</li>
		
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="before-register-tab" data-bs-toggle="tab"
				data-bs-target="#before-register-tab-pane" type="button" role="tab"
				aria-controls="before-register-tab-pane" aria-selected="false">등록 대기중인 회원권</button>
		</li>
		
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="after-register-tab" data-bs-toggle="tab"
				data-bs-target="#after-register-tab-pane" type="button" role="tab"
				aria-controls="after-register-tab-pane" aria-selected="false">등록한 회원권</button>
		</li>
		
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="pause-membership-tab" data-bs-toggle="tab"
				data-bs-target="#pause-membership-tab-pane" type="button" role="tab"
				aria-controls="pause-membership-tab-pane" aria-selected="false">사용 중지한 회원권</button>
		</li>
		
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="expire-membership-tab" data-bs-toggle="tab"
				data-bs-target="#expire-membership-tab-pane" type="button" role="tab"
				aria-controls="expire-membership-tab-pane" aria-selected="false">만료된 회원권</button>
		</li>
		<!-- 
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="cart-membership-tab" data-bs-toggle="tab"
				data-bs-target="#cart-membership-tab-pane" type="button" role="tab"
				aria-controls="cart-membership-tab-pane" aria-selected="false">찜한 회원권</button>
		</li>
		-->
		
	</ul>
	<div class="tab-content" id="myTabContent">
		<div class="tab-pane fade show" id="home-tab-pane"
			role="tabpanel" aria-labelledby="home-tab" tabindex="0">

			<!-- 내 정보 -->
			<hr class="mt-0 mb-4">
			<div class="row" id="profile">
				<div class="col-xl-3">
					<!-- Profile picture card-->
					<div class="card mb-4 mb-xl-0">
						<div class="card-header fs-5 fw-bolder">프로필</div>
						<div class="card-body text-center">
							<!-- Profile picture icon-->
							<i class="bi bi-person-circle" style="font-size: 70px;"></i>
							<!-- Nickname and Email-->
							<div class="fs-4 fw-semibold text-muted mb-1">사용자</div>
							<div class="fs-6 font-italic text-muted mb-3"><%= mto.getName() %></div>
						</div>
					</div>
				</div>
				<div class="col-xl-9">
					<!-- Account details card-->
					<div class="card mb-4">
						<div class="card-header fs-5 fw-bolder">정보 수정</div>
						<div class="card-body">
							<form>
							
								<div class="row gx-3">
								
								<div class="mb-3">
										<label class="small mb-1" for="inputName">이름</label> <input
											class="form-control" id="inputName" type="text" value="<%= mto.getName() %>" readonly>
									</div>
								</div>
							
								<div class="mb-3">
									<label class="small mb-1" for="inputID">아이디</label> <input
										class="form-control" id="inputID" type="text" value="<%= mto.getId() %>" readonly>
								</div>
								
								<div class="mb-3">
									<label class="small mb-1" for="inputNickName">닉네임</label> <input
										class="form-control" id="inputNickName" type="text" value="<%= mto.getNickname() %>">
								</div>
								
								<div class="mb-3">
									<label class="small mb-1" for="inputBirthday">생년월일</label> <input
										class="form-control" id="inputBirthday" type="text" value="<%= mto.getBirthday() %>">
								</div>
								
								<div class="mb-3">
									<label class="small mb-1" for="inputPhone">휴대전화</label> <input
										class="form-control" id="inputPhone" type="text" value="<%= mto.getPhone() %>">
								</div>
								
								<div class="mb-3">
									<label class="small mb-1" for="inputEmailAddress">이메일</label> <input
										class="form-control" id="inputEmailAddress" type="email" value="<%= mto.getEmail() %>">
								</div>
								
								<div class="mb-3">
									<label class="small mb-1" for="inputAddress">주소</label> <input
										class="form-control" id="inputAddress" type="text" value="<%= mto.getFullAddress() %>">
								</div>
							
								<!-- Form Row-->
								<div class="row gx-3 mb-3">
									<!-- Form Group (phone number)-->
									<div class="col-md-6">
										<label class="small mb-1" for="inputPassword">비밀번호 </label> <input
											class="form-control" id="inputPassword" type="password"
											placeholder="현재 비밀번호를 입력하세요." value="">
									</div>
									<!-- Form Group (birthday)-->
									<div class="col-md-6">
										<label class="small mb-1" for="inputChangePassword">비밀번호 입력</label>
										<input class="form-control" id="inputChangePassword" type="password"
										placeholder="변경할 비밀번호를 입력하세요."
											value="">
									</div>
								</div>
								<!-- Save changes button-->
								<div class="d-grid gap-2">
									<button onclick='memberModify("<%=mto.getId() %>", "<%= beforeChangeNickname %>")' class="btn btn-primary mt-3" type="button"> 변경하기 </button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="tab-pane fade show active" id="purchase-list-tab-pane" role="tabpanel"
			aria-labelledby="purchase-list-tab-pane-tab" tabindex="1">

			<%= sbPurchaseList.toString() %>
			
		</div>
		
		
		<div class="tab-pane fade" id="before-register-tab-pane" role="tabpanel"
			aria-labelledby="before-register-tab-pane-tab" tabindex="2">

			<%= sbBeforeRegister.toString() %>
			
		</div>
		
		<div class="tab-pane fade" id="after-register-tab-pane" role="tabpanel"
			aria-labelledby="after-register-tab-pane-tab" tabindex="3">

			<%= sbAfterRegister.toString() %>
			
		</div>
		
		<div class="tab-pane fade" id="pause-membership-tab-pane" role="tabpanel"
			aria-labelledby="pause-membership-tab-pane-tab" tabindex="4">

			<%= sbPauseMembership.toString() %>
			
		</div>
		
		<div class="tab-pane fade" id="expire-membership-tab-pane" role="tabpanel"
			aria-labelledby="expire-membership-tab-pane-tab" tabindex="5">

			 <%= sbExpireMembership.toString() %>
			
		</div>
		
		<div class="tab-pane fade" id="cart-membership-tab-pane" role="tabpanel"
			aria-labelledby="cart-membership-tab-pane" tabindex="6">
		</div> 
		
	</div>
</div>
