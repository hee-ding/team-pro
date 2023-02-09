<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    <hr><br><br>
        <div class="container">
	        <div class="container text-center">

			  <div class="row">
			     <!-- col8 시작 -->
			    <div class="col-8">
			    
			    	<!-- 구매 정보 확인 카드 시작 -->
			    	<div class="card text-start" style="max-width: 900px;">
					  <div class="card-header">
					    구매 정보 확인
					  </div>
					  <ul class="list-group list-group-flush">
					    <li class="list-group-item">
						    <!-- 카드 -->
						    
						    <div class="card mb-3" style="max-width: 800px;">
						 		 <div class="row g-0">
							  		 <div class="col-md-4">
							   		 <img src="./resources/asset/images/main_view/main_carousel/4K6CDVVNJWHwtbMbSDrGaEXeqcKCw9WX4pvJxvnepvUP.jpg" class="owl-carousel-image img-fluid" alt="" style="height: 180px"> 
									 </div>	
									    <div class="col-md-8">
									      <div class="card-body">
									        <h5 class="card-title">시청 비나이더피트니스</h5>
									        <br><br>
									        <p class="card-text">헬스 이용권</p>
									        <p class="card-text"><small1 class="text-muted">1개월</small1></p>
									      </div>
									    </div>
								    </div>
							    </div>
							</li>
						  </ul>
						</div>
					<!-- 여기까지구매 정보 확인 카드 -->
					<br>
					<!-- 구매자 정보 확인 카드 시작 -->
					  <div class="card text-start" style="max-width: 900px;">
							  <div class="card-header">
							    구매자 정보
							  </div>
							  
							  <ul class="list-group list-group-flush">
							    <li class="list-group-item">
							    
							    		<form class="row g-3">
							    		  <div class="col-12">
   										    <label for="inputName" class="form-label">이름</label>
										    <input type="text" class="form-control" id="name">
										  </div>
										  
										  
										  <!-- raios id값 변경 필요 -->
										    <legend class="col-form-label col-sm-2 pt-0">성별</legend>
										    <div class="col-sm-10">
										      <div class="form-check">
										        <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios1" value="option1" checked>
										        <label class="form-check-label" for="gridRadios1">
										          남자
										        </label>
										      </div>
										      <div class="form-check">
										        <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios2" value="option2">
										        <label class="form-check-label" for="gridRadios2">
										          여자
										        </label>
										        
										      </div>
										    </div>
										  
										  <div class="col-md-12">
										    <label for="inputEmail4" class="form-label">Email</label>
										    <input type="email" class="form-control" id="inputEmail4">
										  </div>
										  <div class="col-md-12">
										  <label for="inputPhone" class="form-label">연락처</label>
										    <input type="tel" class="form-control" id="inputPhone" placeholder="ex) 010-3456-7890">
										  </div>
									
										  <div class="col-md-5">
										    <label for="inputState" class="form-label">주소</label>
										    <select id="inputState" class="form-select">
										      <option selected>시</option>
										      <option>...</option>
										    </select>
										  </div>
										  <div class="col-md-5">
										    <label for="inputState" class="form-label">&emsp;</label>
										    <select id="inputState" class="form-select">
										      <option selected>도</option>
										      <option>...</option>
										    </select>
										  </div>
										  <div class="col-md-2">
										    <label for="inputZip" class="form-label">우편번호</label>
										    <input type="text" class="form-control" id="inputZip">
										  </div>
						
										  <div class="col-12">
										    <label for="inputAddress2" class="form-label">상세주소</label>
										    <input type="text" class="form-control" id="inputAddress2" placeholder="ex) 한빛로 한빛아파트 101동 101호">
										  </div>
										  <div class="col-12">
									   <br>
										  	<form action="/action_page.php">
											  <label for="start-day">운동시작일 :</label>
											  <span><input type="date" id="start-day" name="dstart-day"></span>
											</form>
										  </div>
										 <br> 
										</form>
									</li>
							  </ul>
						</div>
			    	<!-- 여기까지 구매자 정보 확인 카드-->
			    	<br>
				    	<div class="card text-start" style="max-width: 900px;">
				    	
						  <div class="card-header">
						    결제방법
						  </div>
						 <!-- radio -->
						<ul class="list-group list-group-flush">
					    	<li class="list-group-item">
						 
						    	<div class="col-sm-10">
							      <div class="form-check">
							      &emsp;
							        <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios1" value="option1" checked>
							        <label class="form-check-label" for="gridRadios1">
							          신용카드
							        </label>
							      </div>
						          <div class="form-check">
							          &emsp;
							        <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios2" value="option2">
							        <label class="form-check-label" for="gridRadios2">
							          무통장입금
						       		 </label>
							      </div>
							     </div>
						    </li>
					    </ul>
					</div>
			    </div>
		        <!-- 여기까지 col8 -->
		        
		        
		        
		        
		        
		        
		        
			    <!-- col4 -->
			    <div class="col-4">
			    	<div class="card" style="width: 18rem;">
					  <div class="card-header">
					    결제금액
					  </div>
					  <ul class="list-group list-group-flush">
					    <li class="list-group-item">
						    <p>상품금액&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;<span>270,000 원</span></p>
							<p>마음가짐 회원 할인&emsp;&emsp;&emsp;<span>- 60,000 원</span></p>
						</li>
					    <li class="list-group-item">
					    	<br><div>최종 결제 금액</div><p class="text-primary">210,000 원</p>
				    	</li>
					    <li class="list-group-item">
					    	<div class="d-grid gap-3">
							  <button onclick="requestPay()" type="button" class="btn btn-primary btn-block">결제하기</button>
							</div>
							
				    	</li>
					  </ul>
					</div>
					<br>
					<div class="card" style="width: 18rem;">
					  <small class="card-header">
					    아래 사항을 모두 확인하였으며, <br>결제 진행에 동의합니다.
					  </small>
					  <ul class="list-group list-group-flush">
					    <li class="list-group-item">
						   <div class="form-check">
							  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
							  <label class="form-check-label" for="flexCheckDefault">
							    <small>[필수]취소 및 환불규정에 동의합니다.</small>
							  </label>
							</div>
							<div class="form-check">
							  <input class="form-check-input" type="checkbox" value="" id="flexCheckChecked" checked>
							  <label class="form-check-label" for="flexCheckChecked">
							    <small>[필수]개인정보 제 3자 위탁에 동의합니다.</small>
							  </label>
							</div>
						</li>

					  </ul>
					</div>
					
					
					
					
			    </div>
			    
			    
			    
			      <!-- 여기까지 col4 -->
				  </div>
  		  	  <br><br>
			</div>
        </div>