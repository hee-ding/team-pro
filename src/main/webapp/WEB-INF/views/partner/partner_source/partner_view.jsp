<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="container-xl px-4 mt-4">
	<!-- Account page navigation-->
	<ul class="nav nav-tabs" id="myTab" role="tablist">
		<li class="nav-item" role="presentation">
			<button class="nav-link active" id="profile-tab" data-bs-toggle="tab"
				data-bs-target="#profile-tab-pane" type="button" role="tab"
				aria-controls="profile-tab-pane" aria-selected="true">업체 정보</button>
		</li>
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="manage-tab" data-bs-toggle="tab"
				data-bs-target="#manage-tab-pane" type="button" role="tab"
				aria-controls="manage-tab-pane" aria-selected="false">회원 관리</button>
		</li>
	</ul>
	<div class="tab-content" id="myTabContent">
		<div class="tab-pane fade show active" id="profile-tab-pane"
			role="tabpanel" aria-labelledby="profile-tab" tabindex="0">

			<!-- 업체 정보 -->
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
							<div class="fs-4 fw-semibold text-muted mb-1">업체명</div>
							<div class="fs-6 font-italic text-muted mb-3">abcd@abcmail.com</div>
						</div>
					</div>
				</div>
				<div class="col-xl-9">
					<!-- Account details card-->
					<div class="card mb-4">
						<div class="card-header fs-5 fw-bolder">정보 수정</div>
						<div class="card-body">
							<form>
								<!-- Form Group (name)-->
								<div class="mb-3">
									<label class="small mb-1" for="inputUsername">업체명</label> 
									<input class="form-control" id="inputUsername" type="text" value="업체명" readonly>
								</div>
								<!-- Form Row-->
								<div class="row gx-3">
									<!-- Form Group (manager name)-->
									<div class="mb-3">
										<label class="small mb-1" for="inputManagerName">관리자</label> 
										<input class="form-control" id="inputManagerName" type="text" value="name">
									</div>
								</div>

								<div class="row gx-3 mb-3">
									<!-- Form Group (email address)-->
									<div class="col-md-6">
										<label class="small mb-1" for="inputEmail">이메일 </label> 
										<input class="form-control" id="inputEmail" type="text" value="abc@testmail.com">
									</div>
									<!-- Form Group (phone number)-->
									<div class="col-md-6">
										<label class="small mb-1" for="inputPhone">전화번호</label>
										<input class="form-control" id="inputPhone" type="tel" name="Phone" value="010-1234-5678">
									</div>
								</div>
								<!-- Form Row-->
								<div class="row gx-3 mb-3">
									<!-- Form Group (Now password)-->
									<div class="col-md-6">
										<label class="small mb-1" for="inputNowPassword">현재 비밀번호 </label> 
										<input class="form-control" id="inputNowPassword" type="password" value="123456">
									</div>
									<!-- Form Group (birthday)-->
									<div class="col-md-6">
										<label class="small mb-1" for="inputNewPassword">변경 비밀번호</label>
										<input class="form-control" id="inputNewPassword" type="password" value="654321">
									</div>
								</div>
								<!-- Save changes button-->
								<button class="btn btn-primary" type="button">Save changes</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="tab-pane fade" id="manage-tab-pane" role="tabpanel"
			aria-labelledby="manage-tab" tabindex="0">

			<!-- 회원권 관리-->
			<hr class="mt-0 mb-4">
			<table class="table table-hover text-center">
				<thead>
					<tr>
						<th scope="col">회원권 번호</th>
						<th scope="col">회원 이름</th>
						<th scope="col">회원권 기간</th>
						<th scope="col">회원권 상태</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row">20230001</th>
						<td>황병국</td>
						<td>2023.01.01 ~ 2023.01.31</td>
						<td>만료</td>
					</tr>
					<tr>
						<th scope="row">20230002</th>
						<td>김종희</td>
						<td>2023.02.01 ~ 2023.04.30</td>
						<td>정상</td>
					</tr>
					<tr>
						<th scope="row">20230003</th>
						<td>하태현</td>
						<td>2023.02.01 ~ 2023.07.31</td>
						<td>정지</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="tab-pane fade" id="contact-tab-pane" role="tabpanel"
			aria-labelledby="contact-tab" tabindex="0">...</div>
	</div>
</div>
