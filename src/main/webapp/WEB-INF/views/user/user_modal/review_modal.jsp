<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<!-- The Modal -->
	<div class="modal fade" id="reviewModal">
	  <div class="modal-dialog modal-dialog-centered modal-lg">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h5 class="modal-title">리뷰 쓰기</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" data-backdrop="static" data-keyboard="false"></button>
	      </div>
	      
	      <!-- Modal body -->
	      <div id="reviewConfirmMessage" class="modal-body">
				<div class="text-center mb-5">
					<div class="circle-image">
						<img id='membershipImage' class='owl-carousel-image rounded w-50' style="height:250px;">
					</div>
					<span id="title" class="name mb-1 fw-500"></span><br/>
					<small id="address" class="text-black-50"></small> 
					<div class="rate bg-white py-3 text-white">
						<div class="rating">
							<input type="radio" name="rating" value="5" id="5"><label
								for="5">☆</label> <input type="radio" name="rating" value="4"
								id="4"><label for="4">☆</label> <input type="radio"
								name="rating" value="3" id="3"><label for="3">☆</label>
							<input type="radio" name="rating" value="2" id="2"><label
								for="2">☆</label> <input type="radio" name="rating" value="1"
								id="1"><label for="1">☆</label>
						</div>
					</div>
					<div class="location text-left">
			            <label for="message-text" class="col-form-label">리뷰 내용</label>
			            <textarea class="form-control" id="message-text"></textarea>
					</div>
				</div>
			</div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	      	<button id="reviewOk" type="button" class="btn btn-primary">등록하기</button>
	        <button id="reviewcancle" type="button" class="btn btn-danger" data-bs-dismiss="modal">취소하기</button>
	      </div>
	
	    </div>
	  </div>
	</div>


