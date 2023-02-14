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
			
	for( int i = 0; i < arryList.size(); i++ ) {
		
		map = arryList.get( i );
		
		BoardTO bto = (BoardTO) map.get("bto");
		String fullCategoryString = bto.getFullCategoryString();
		
		MemberShipTO msto = (MemberShipTO) map.get("msto");
		String fullMembershipName = msto.getFull_membership_name();
		
		MemberTO pmto = (MemberTO) map.get("pmto");
		String name = pmto.getName();
		String phone = pmto.getPhone();
		String email = pmto.getEmail();
		
		PayTO pto = (PayTO) map.get("pto");
		String membershipRegisterDate = pto.getMembership_register_date();
		String membershipExpiryDate = pto.getMembership_expiry_date();
		String membershipRegisterStatus = pto.getMembership_register_status();
		String pdayStatus = pto.getPay_status();
		String payDate = pto.getPay_date();
		String merchantUid = pto.getMerchant_uid();
		
		//System.out.println( pdayStatus );
		
		sbPurchaseList.append( "	<tr class='h-100'> ");
		sbPurchaseList.append( "		<td>" + (1 + i) +"</td> ");
		sbPurchaseList.append( "		<td>" + fullCategoryString + "</td> ");
		sbPurchaseList.append( "		<td>" + fullMembershipName + "</td> ");
		sbPurchaseList.append( "		<td>" + name + "</td> ");
		sbPurchaseList.append( "		<td>" + phone + "</td> ");
		if( membershipRegisterStatus.equals( "환불")) {
		sbPurchaseList.append( "		<td class='text-decoration-line-through'>" + membershipRegisterDate + "</td> ");
		} else {
		sbPurchaseList.append( "		<td >" + membershipRegisterDate + "</td> ");			
		}
		if( membershipRegisterStatus.equals( "환불")) {
		sbPurchaseList.append( "		<td class='text-decoration-line-through'>" + membershipExpiryDate + "</td> ");
		} else {
		sbPurchaseList.append( "		<td>" + membershipExpiryDate + "</td> ");			
		}
		if( membershipRegisterStatus.equals( "승인 대기")) {
		sbPurchaseList.append( "	    	<td><span class='badge bg-secondary'>" + membershipRegisterStatus + "</span></td>");
		} else if ( membershipRegisterStatus.equals( "승인 완료")) {
		sbPurchaseList.append( "	    	<td><span class='badge bg-success'>" + membershipRegisterStatus + "</span></td>");
		} else if ( membershipRegisterStatus.equals( "사용 중지")) {
		sbPurchaseList.append( "	    	<td><span class='badge bg-warning '>" + membershipRegisterStatus + "</span></td>");
		} else if ( membershipRegisterStatus.equals( "기간 만료")) {
		sbPurchaseList.append( "	    	<td><span class='badge bg-danger '>" + membershipRegisterStatus + "</span></td>");
		} else if ( membershipRegisterStatus.equals( "환불")) {
		sbPurchaseList.append( "	    	<td><span class='badge bg-danger '>" + membershipRegisterStatus + "</span></td>");
		}
		sbPurchaseList.append( "		<td>" + pdayStatus + "</td> ");
		sbPurchaseList.append( "		<td>" + payDate + "</td> ");
		sbPurchaseList.append( "		<td> ");
		
		if( membershipRegisterStatus.equals( "승인 대기")) {
		sbPurchaseList.append( "	    	<button id='" + name + "' onclick='registerConfirm(this);' value='" + merchantUid +"' class='border-0 badge bg-success'>승인</button> ");
		}
		if( membershipRegisterStatus.equals( "승인 대기")) {
		//sbPurchaseList.append( "	    	<a ><span class='badge bg-warning text-dark'>반려</span></a> ");
		}
		if( membershipRegisterStatus.equals( "승인 대기") || membershipRegisterStatus.equals( "승인 완료") ) {
		sbPurchaseList.append( "	    	<button id='" + name + "' onclick='refundConfirm(this);' value='" + merchantUid +"' class='border-0 badge bg-danger'>환불</button> ");
		}
		if( membershipRegisterStatus.equals( "승인 완료") ) {
		sbPurchaseList.append( "	    	<button id='" + name + "' onclick='pauseConfirm(this);' value='" + merchantUid +"' class='border-0 badge bg-warning text-dark'>중지</button> ");
		}
		if( membershipRegisterStatus.equals( "사용 중지") ) {
		sbPurchaseList.append( "	    	<button id='" + name + "' onclick='restartConfirm(this);' value='" + merchantUid +"' class='border-0 badge bg-secondary text-white'>재개</button> ");
		}
		sbPurchaseList.append( "		</td> ");
		sbPurchaseList.append( "	</tr> ");
		
		
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
				aria-controls="purchase-list-tab-pane" aria-selected="false">전체 결제 회원권</button>
		</li>
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

			<!--  %= sbPurchaseList.toString() %> -->
			
			<div class="container mt-5">
				<div class="row">
	            <div class="page-heading">
	                <section class="section">
	                    <div class="card">
	                        <div class="card-header bg-white">
	                          <h3>전체 조회</h3>
	                          <p class="text-subtitle text-muted">결제한 회원을 조회합니다.</p>
	                        </div>
	                        <div class="card-body">
	                            <table class="table table-hover text-left" id="table1">
	                                <thead>
	                                    <tr>
	                                    	<th>번호</th>
	                                        <th>카테고리</th>
	                                        <th>회원권 정보</th>
	                                        <th>이름</th>
	                                        <th>연락처</th>
	                                        <th>등록일</th>
	                                        <th>만료일</th>
	                                        <th>상태</th>
	                                        <th>결제 상태</th>
	                                        <th>결제일</th>
	                                        <th>기능</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <%= sbPurchaseList.toString() %>
	                                </tbody>
	                            </table>
	                        </div>
	                    </div>
	                </section>
	            </div>
	         </div>
	       </div>
		</div>
	</div>
</div>
